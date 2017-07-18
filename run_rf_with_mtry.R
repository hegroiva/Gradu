run_rf_with_mtry <- function(df, features, filenamestem, language="eng", ntree=500) {
  df <- get_subset(language=language, 
                   df=df)
  df.genres <- df$df.genres
  
  df.genres.sets <- get_training_and_testing_sets(df=df.genres, 
                                                  training_percent=50, 
                                                  filenamestem=filenamestem, 
                                                  load=FALSE)
  
  #features.training <- features[df.genres.sets$training_inds,]
  #features.testing <- features[-df.genres.sets$training_inds,]
 
  features.training <- df.genres.sets$training
  features.testing <- df.genres.sets$testing

  df.genres.training <- df.genres.sets$training
  df.training.split <- split_training_set(df=df.genres.training, features=features.training, parts=5)
  df.training.split.df <- df.training.split$df
  features.split <- df.training.split$features
  
  df.genres.testing <- df.genres.sets$testing
  
  stats <- df$stats
  rm(df)
  rm(df.genres)
  rm(df.genres.sets)
  
  aggr <- as.data.frame(matrix(nrow = 22, ncol = (length(features)-2)))
  names(aggr) <- append(paste0("mtry_", 3:(length(features)-1)), "TOTAL")
  for (mtry in 3:nrow(features)) {
    
      aggregated_results <- run_rf(features.split=features.split[names(features.split) != "is_poetry"], 
                                              filestem = paste0(filenamestem, "_", ntree, "_", mtry),
                                              ntree=ntree, 
                                              mtry=mtry)
      aggr[[paste0("mtry_", mtry)]] <- t(as.data.frame(aggregated_results[,"total"]))
      rownames(aggr) <- rownames(aggregated_results)
     
  }  
  means <- list()
  for (i in 1:nrow(aggr)) {
    if (i <= 4) {
      means[[i]] <- round(mean(unlist((aggr[i,1:length(features)-1]))))
    } else {
      means[[i]] <- mean(unlist((aggr[i,1:length(features)-1])))
    }
  }
  aggr[["TOTAL"]] <- means
  sink(file = paste0("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\output\\", filestem ,"aggregated_mtry.txt"),
       append=FALSE)
  
  print(aggr)
  sink()
  return(aggr)
}
