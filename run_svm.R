run_svm <- function(features.split, filestem="", ntree=500, mtry=5) {
  matrices = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_svm round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    features$is_poetry <- is_poetry
    #varNames <- names(features)[!names(features) %in% c("is_poetry")]
    #varNames1 <- paste(varNames, collapse="+")
    #rfForm <- as.formula(paste("is_poetry", varNames1, sep=" ~ "))
    #ratio_is_poetry <- length(which(features$is_poetry==TRUE)) / length(features$is_poetry==FALSE)
    x <- subset(features, select=-is_poetry)
    y <- is_poetry
    svm_model <- svm(is_poetry ~ ., data=features)
    summary(svm_model)
    
    pred <- predict(svm_model,x)
    system.time(pred <- predict(svm_model,x))
    
    table(pred,y)
    
    
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
    is_poetry2 <- features2$is_poetry
    x2 <- subset(features2, select=-is_poetry)
    y2 <- is_poetry2
    pred2 <- predict(svm_model,x2)
    system.time(pred <- predict(svm_model,x2))
    table(pred,y2)
    matrices[[set_no]] <- table(pred,y2)
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
    
    # Get variable_importance and print it
    if (set_no == 1) {
      #png(filename = paste0(outputpath, "/", filestem, "variable_importance_", set_no, ".png"))
      #varImpPlot(svm_model, sort=TRUE, main="Variable importance")                      
      #dev.off()
    }
    
    cm <- confusionMatrix(data=pred, reference=is_poetry2, positive="TRUE")
    matrices[[set_no]] <- cm
    
    gc()
  }
  sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
       append=FALSE)
  
  aggregated_results <- aggregate_confusion_matrix(matrices)
  print(aggregated_results)
  sink()
  for (matr in matrices) {
    
    
    #sink(file = paste0(outputpath, "/", filestem ,"svm_confusionMatrix.txt"),
    #     append=TRUE)
    
    #sink()
  }
  #sink()
  #return(matrices)
  return(aggregated_results)
  #cm2
}