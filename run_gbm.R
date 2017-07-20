library(gbm)
run_gbm <- function(features.split, filestem="", distribution="multinomial", n.trees=1) {
  matrices = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_gbm round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    features$is_poetry <- is_poetry
    
	x <- subset(features, select=-is_poetry)
    y <- is_poetry
	
    gbm_model <- gbm(is_poetry ~ ., data=features, distribution=distribution, n.trees=n.trees)
    
	#summary(oner_model)
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
    is_poetry2 <- features2$is_poetry
    x2 <- subset(features2, select=-is_poetry)
    y2 <- is_poetry2
    prob2 <- predict.gbm(gbm_model,x2, n.trees=n.trees)
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