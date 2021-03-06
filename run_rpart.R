library(rpart)
run_rpart <- function(features.split, filestem="", method="class", rpart_split="information", usesurrogate=2, surrogatestyle=1) {
  matrices = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_rpart round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    features$is_poetry <- is_poetry
    
	x <- subset(features, select=-is_poetry)
    y <- is_poetry
	
	rpart_control <- rpart.control(usesurrogate=usesurrogate, surrogatestyle=surrogatestyle, xval=1)
    rpart_model <- rpart(is_poetry ~ ., data=features, method=method, parms=list(split=rpart_split), control=rpart_control)
    
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
    is_poetry2 <- features2$is_poetry
    x2 <- subset(features2, select=-is_poetry)
    y2 <- is_poetry2
    prob2 <- predict(rpart_model,x2)
    pred2 <- colnames(prob2)[apply(prob2,1,which.max)]
    matrices[[set_no]] <- table(pred2,y2)
    
    # Get variable_importance and print it
    if (set_no == 1) {
      #png(filename = paste0(outputpath, "/", filestem, "variable_importance_", set_no, ".png"))
      #varImpPlot(svm_model, sort=TRUE, main="Variable importance")                      
      #dev.off()
    }
    
    cm <- confusionMatrix(data=pred2, reference=is_poetry2, positive="TRUE")
    matrices[[set_no]] <- cm
    
    gc()
  }
  sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
       append=FALSE)
  
  aggregated_results <- aggregate_confusion_matrix(matrices)
  print(aggregated_results)
  sink()
  return(aggregated_results)
 
}