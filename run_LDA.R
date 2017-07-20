library(MASS)
run_LDA <- function(features.split, filestem="", distribution="multinomial", n.trees=1) {
  matrices = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_LDA round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    features$is_poetry <- is_poetry
    
	x <- subset(features, select=-is_poetry)
    y <- is_poetry
	
    LDA_model <- lda(is_poetry ~ ., data=features)
    
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
    is_poetry2 <- features2$is_poetry
    x2 <- subset(features2, select=-is_poetry)
    y2 <- is_poetry2
    pred2 <- predict(LDA_model,x2)$class
	
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