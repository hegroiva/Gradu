run_rf <- function(features.split, filestem="", ntree=500, mtry=5, get_cutoff=FALSE) {
  matrices = list()
  matrices_no_cutoff = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_random_forest round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)

    # Precaution
    names(features) <- gsub(" ", "_", names(features))
    
    # Change names for cforest
    levels(features$is_poetry) <- gsub("FALSE", "NONPOETRY", levels(features$is_poetry))
    levels(features$is_poetry) <- gsub("TRUE", "POETRY", levels(features$is_poetry))
    
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
    
    #rf_Tune <- train(is_poetry ~ ., 
    #                 data = features,method = "rf",
    #                 trControl = ctrl,
    #                 preProc =c(),
    #                 #tuneLength = 15,
    #                 metric="Hmeas",
    #                 verbose = FALSE)
    
    #varLists <- rfe(x=features, y=is_poetry, sizes=c(5,10,20), rfeControl = rfeControl(functions=rfFuncs))
    if (get_cutoff) {
      retRF <- randomForest::randomForest(rfForm,
                                          features, 
                                          ntree=ntree, 
                                          importance=TRUE, 
                                          mtry=mtry, 
                                          cutoff=c(1-ratio_is_poetry, ratio_is_poetry)
                                          )
    }
    
    retRF_no_cutoff <- randomForest::randomForest(rfForm,
                                        features, 
                                        ntree=ntree, 
                                        importance=TRUE, 
                                        mtry=mtry
    )
#                                        strata="is_poetry",
#                                        sampsize=c(5000,500))
    
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
    # Precaution
    names(features2) <- gsub(" ", "_", names(features2))
    # Change names for cforest
    levels(features$is_poetry) <- gsub("FALSE", "NONPOETRY", levels(features$is_poetry))
    levels(features$is_poetry) <- gsub("TRUE", "POETRY", levels(features$is_poetry))
    
    is_poetry2 <- features2$is_poetry
    #varNames_2 <- names(features2)[!names(features2) %in% c("is_poetry")]
    #varNames1_2 <- paste(varNames_2, collapse="+")
    #rfForm2 <- as.formula(paste("is_poetry", varNames1_2, sep=" ~ "))
    
    #ratio_is_poetry <- length(which(features2$is_poetry==TRUE)) / length(features2$is_poetry==FALSE)
    #retRF2 <- randomForest::randomForest(rfForm2, 
    #                                     features2, 
    #                                     ntree=ntree, 
    #                                     importance=TRUE, 
    #                                     mtry=mtry,
    #                                     #strata="is_poetry",
    #                                     #sampsize=c(5000,500))
    #                                     cutoff=c(1-ratio_is_poetry, ratio_is_poetry))
    
    ## Get variable_importance and print it
    #if (set_no == 1) {
    #  png(filename = paste0(outputpath, "/", filestem, "variable_importance_", set_no, ".png"))
    #  varImpPlot(retRF2, sort=TRUE, main="Variable importance")                      
    #  dev.off()
    #}
    # Get prediction
    features2$is_poetry <- NULL
    if (get_cutoff) {
      prediction <- predict(retRF, features2)
      cm <- confusionMatrix(data=prediction, reference=is_poetry2, positive="TRUE")
      matrices[[set_no]] <- cm
    }
    
    prediction_no_cutoff <- predict(retRF_no_cutoff, features2)
    
    #sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_", set_no, ".txt"),
    #     append=FALSE)
    #print(paste0("Number of trees: ", ntree))
    #print(paste0("Features tried: ", mtry))
    
    cm_no_cutoff <- confusionMatrix(data=prediction_no_cutoff, reference=is_poetry2, positive="TRUE")
    cm_df <- convert_cm_to_df(cm_no_cutoff)
    matrices_no_cutoff[[set_no]] <- cm_df
    #cm2 <- table(prediction_no_cutoff, is_poetry2)
    #print(prediction_no_cutoff)
    #print("---")
    #print(cm_no_cutoff)
    #print(cm2)
    #print("--------------------------------------------------------------------------------------------")
    #print(date())
    #sink()
    #matrices[[set_no]] <- cm
    gc()
  }
  
  
    
  if (get_cutoff) {
    sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
         append=FALSE)
  
    aggregated_results <- aggregate_confusion_matrix(matrices)
    print(aggregated_results)
    sink()
  }
  
  sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined_no_cutoff.txt"),
       append=FALSE)
  
  #aggregated_results_no_cutoff <- aggregate_confusion_matrix(matrices_no_cutoff)
  aggregated_results_no_cutoff <- aggregate_cm_dynamically(matrices_no_cutoff)
  print(aggregated_results_no_cutoff)
  sink()
#  for (matr in matrices) {
#    print(cm)
#    sink()
#    sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
#         append=TRUE)
#  }
#  sink()
  return(aggregated_results_no_cutoff)
  #cm2
}