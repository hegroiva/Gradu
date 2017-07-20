run_rf <- function(features.split, filestem="", ntree=500, mtry=5) {
  matrices = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_random_forest round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    features$is_poetry <- is_poetry
    varNames <- names(features)[!names(features) %in% c("is_poetry")]
    varNames1 <- paste(varNames, collapse="+")
    rfForm <- as.formula(paste("is_poetry", varNames1, sep=" ~ "))
    ratio_is_poetry <- length(which(features$is_poetry==TRUE)) / length(features$is_poetry==FALSE)

    ctrl <- trainControl(method = "boot",
                         number = 1, 
                         repeats = 5, 
                         summaryFunction = hmeasureCaret,
                         classProbs=TRUE,
                         allowParallel = TRUE,
                         verboseIter=FALSE,
                         returnData=FALSE,
                         savePredictions=FALSE)
    
    rf_Tune <- train(is_poetry ~ ., 
                     data = features,method = "rf",
                     trControl = ctrl,
                     preProc =c(),
                     #tuneLength = 15,
                     metric="Hmeas",
                     verbose = FALSE)
    
    varLists <- rfe(x=features, y=is_poetry, sizes=c(5,10,20), rfeControl = rfeControl(functions=rfFuncs))
    retRF <- randomForest::randomForest(rfForm,
                                        features, 
                                        ntree=ntree, 
                                        importance=TRUE, 
                                        mtry=mtry, 
                                        cutoff=c(1-ratio_is_poetry, ratio_is_poetry)
                                        )
#                                        strata="is_poetry",
#                                        sampsize=c(5000,500))
    
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
    is_poetry2 <- features2$is_poetry
    varNames_2 <- names(features2)[!names(features2) %in% c("is_poetry")]
    varNames1_2 <- paste(varNames_2, collapse="+")
    rfForm2 <- as.formula(paste("is_poetry", varNames1_2, sep=" ~ "))
    
    ratio_is_poetry <- length(which(features2$is_poetry==TRUE)) / length(features2$is_poetry==FALSE)
    retRF2 <- randomForest::randomForest(rfForm2, 
                                         features2, 
                                         ntree=ntree, 
                                         importance=TRUE, 
                                         mtry=mtry,
                                         #strata="is_poetry",
                                         #sampsize=c(5000,500))
                                         cutoff=c(1-ratio_is_poetry, ratio_is_poetry))
    
    # Get variable_importance and print it
    if (set_no == 1) {
      png(filename = paste0(outputpath, "/", filestem, "variable_importance_", set_no, ".png"))
      varImpPlot(retRF2, sort=TRUE, main="Variable importance")                      
      dev.off()
    }
    # Get prediction
    features2$is_poetry <- NULL
    prediction <- predict(retRF, features2)
    
    #sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_", set_no, ".txt"),
    #     append=FALSE)
    #print(paste0("Number of trees: ", ntree))
    #print(paste0("Features tried: ", mtry))
    cm <- confusionMatrix(data=prediction, reference=is_poetry2, positive="TRUE")
    matrices[[set_no]] <- cm
    #cm2 <- table(prediction, is_poetry2)
    #print(cm)
    #print(cm2)
    #print("--------------------------------------------------------------------------------------------")
    #print(date())
    #sink()
    #matrices[[set_no]] <- cm
    gc()
  }
  sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
       append=FALSE)
  
  aggregated_results <- aggregate_confusion_matrix(matrices)
  print(aggregated_results)
  sink()
#  for (matr in matrices) {
#    print(cm)
#    sink()
#    sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
#         append=TRUE)
#  }
#  sink()
  return(aggregated_results)
  #cm2
}