#run_rf_once <- function(df, features, filenamestem, language="eng", ntree=500, mtry=5) {
run_caret_rf_once <- function(df, 
                              features, 
                              filenamestem, 
                              language="eng", 
                              ntree=500, 
                              mtry=5, 
                              get_pairwise_comparison=TRUE, 
                              get_varImp=TRUE,
                              get_rfe=TRUE,
                              get_prediction=FALSE
                              ) {
  
  feats <- features[which(df$language==language & df$genre!=""),]
  
  df <- get_subset(language=language, 
                   df=df)
  df.genres <- df$df.genres
  
  df.genres.sets <- get_training_and_testing_sets(features=feats, 
                                                  training_percent=50, 
                                                  filenamestem=filenamestem, 
                                                  load=FALSE)
  
  features.training <- df.genres.sets$training
  features.testing <- df.genres.sets$testing
  
  features.training.split <- split_training_set(features=features.training, parts=5)
  features.split <- features.training.split
    
  #aggr <- as.data.frame(matrix(nrow = 22, ncol = length(features)))
  #names(aggr) <- append(names(features[names(features)!="is_poetry"]), "TOTAL")
  
  aggregated_results <- run_caret_rf(features.split=features.split, 
                                              filestem = paste0(filenamestem, "_"),
                                              ntree=ntree, 
                                              mtry=mtry,
                                              get_pairwise_comparison=get_pairwise_comparison,
                                              get_varImp = get_varImp,
                                              get_rfe=get_rfe,
                                              get_prediction=get_prediction
                                    )
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
  #return(aggr)
  return()
}
