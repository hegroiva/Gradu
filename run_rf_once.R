#run_rf_once <- function(df, features, filenamestem, language="eng", ntree=500, mtry=5) {
run_rf_once <- function(df, features, filenamestem, language="eng", ntree=500, mtry=5) {
  
  feats <- features[which(df$language==language & df$genre!=""),]
  
  df <- get_subset(language=language, 
                   df=df)
  df.genres <- df$df.genres
  
  df.genres.sets <- get_training_and_testing_sets(features=feats, 
                                                  training_percent=50, 
                                                  filenamestem=filenamestem, 
                                                  load=FALSE)
  
  #features.training <- features[df.genres.sets$training_inds,]
  #features.testing <- features[-df.genres.sets$training_inds,]
  features.training <- df.genres.sets$training
  features.testing <- df.genres.sets$testing
  
  #features.training <- features.genres.sets$training
  #features.testing <- features.genres.sets$testing
  
  #eatures.genres.training <- features.genres.sets$training
  #features.training.split <- split_training_set(df=df.genres.training, features=features.training, parts=5)
  features.training.split <- split_training_set(features=features.training, parts=5)
  #features.training.split.df <- features.training.split$df
  features.split <- features.training.split
  
  #features.genres.testing <- features.genres.sets$testing
  
  #stats <- df$stats
  #rm(df)
  #rm(df.genres)
  #rm(df.genres.sets)
  
  aggr <- as.data.frame(matrix(nrow = 22, ncol = length(features)))
  names(aggr) <- append(names(features[names(features)!="is_poetry"]), "TOTAL")
  #for (feat in names(features)) {
  #  if (feat != "is_poetry") {
      #aggregated_results <- run_random_forest(features.split=lapply(features.split, FUN=function(x) {x[names(x) != "is_poetry"]}),
       aggregated_results <- run_rf(features.split=features.split, 
                                              filestem = paste0(filenamestem, "_"),
                                              ntree=ntree, 
                                              mtry=mtry)
      #aggr[["TOTAL"]] <- t(as.data.frame(aggregated_results[,"total"]))
      #rownames(aggr) <- rownames(aggregated_results)
    #} 
  #}  
#  means <- list()
#  for (i in 1:nrow(aggr)) {
#    if (i <= 4) {
#      means[[i]] <- round(mean(unlist((aggr[i,1:length(features)-1]))))
#    } else {
#      means[[i]] <- mean(unlist((aggr[i,1:length(features)-1])))
#    }
#  }
#  aggr[["TOTAL"]] <- means
#  sink(file = paste0(outputpath, "/", filenamestem ,"aggregated.txt"),
#       append=FALSE)
#  
#  print(aggr)
#  sink()
  return(aggr)
}
