run_svm <- function(features.split, filestem="") {
  matrices = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_svm round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    features$is_poetry <- is_poetry
    
    x <- subset(features, select=-is_poetry)
    y <- is_poetry
    svm_model <- svm(is_poetry ~ ., data=x)
    
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
    is_poetry2 <- features2$is_poetry
    x2 <- subset(features2, select=-is_poetry)
    y2 <- is_poetry2
    pred2 <- predict(svm_model,x2)
    
    cm <- confusionMatrix(data=pred2, reference=is_poetry2, positive="TRUE")
    cm_df <- convert_cm_to_df(cm)
    matrices[[set_no]] <- cm_df
    
    gc()
  }
  aggregated_results <- aggregate_cm_dynamically(matrices)
  sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
       append=FALSE)
  width <- getOption("width")
  options("width"=1000)
  print(aggregated_results)
  options("width"=width)
  sink()
  return(aggregated_results)
}