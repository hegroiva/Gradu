run_rf_with_features <- function(df, features, filenamestem, language="eng", ntree=500, mtry=5) {
  df <- get_subset(language=language, 
                   df=df)
  df.genres <- df$df.genres
  
  df.genres.sets <- get_training_and_testing_sets(df=df.genres, 
                                                  training_percent=50, 
                                                  filenamestem=filenamestem, 
                                                  load=FALSE)

#  features.training <- features[df.genres.sets$training_inds,]
#  features.testing <- features[-df.genres.sets$training_inds,]
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

  aggr <- as.data.frame(matrix(nrow = 22, ncol = length(features)))
  names(aggr) <- append(names(features[names(features)!="is_poetry"]), "TOTAL")
  for (feat in names(features)) {
    if (feat != "is_poetry") {
      aggregated_results <- run_rf(features.split=lapply(features.split, FUN=function(x) {x[names(x) != feat]}), 
                                              filestem = paste0(filenamestem, "_sans_", feat, "_"),
                                              ntree=ntree, 
                                              mtry=mtry)
      aggr[[feat]] <- t(as.data.frame(aggregated_results[,"total"]))
      rownames(aggr) <- rownames(aggregated_results)
    } 
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
  sink(file = paste0(outputpath, "/", filestem ,"aggregated_sans_fields_round1.txt"),
       append=FALSE)
  
  print(aggr)
  sink()
  return(aggr)
}
