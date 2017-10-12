run_gbm_once <- function(df, features, filenamestem, language="eng", distribution="multinomial", n.trees=10, training_percent=100) {

  feats <- features[which(df$language==language & df$genre!=""),]
  
  df <- get_subset(language=language, 
                   df=df)
  df.genres <- df$df.genres
  
  df.genres.sets <- get_training_and_testing_sets(features=feats, 
                                                  training_percent=training_percent, 
                                                  filenamestem=filenamestem, 
                                                  load=FALSE)
  
  #features.training <- features[df.genres.sets$training_inds,]
  #features.testing <- features[-df.genres.sets$training_inds,]
  features.training <- df.genres.sets$training
  features.testing <- df.genres.sets$testing
 
  features.training.split <- split_training_set(features=features.training, parts=5)
  features.split <- features.training.split
  
  aggr <- as.data.frame(matrix(nrow = 22, ncol = length(features)))
  names(aggr) <- append(names(features[names(features)!="is_poetry"]), "TOTAL")

  aggregated_results <- run_gbm(features.split=features.split, 
                                          filestem = paste0(filenamestem, "_"),
										  distribution=distribution,
										  n.trees=n.trees
                                          )
										  
  aggr[["TOTAL"]] <- t(as.data.frame(aggregated_results[,"total"]))
  rownames(aggr) <- rownames(aggregated_results)

  return(aggr)
}
