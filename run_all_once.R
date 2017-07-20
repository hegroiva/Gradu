run_all_once <- function(df, 
                         features, 
                         filenamestem, 
                         startpoint=1,
                         language="eng", 
                         ntree=500, 
                         mtry=5, 
                         k=NULL, 
                         oner_method="logreg",
                         rpart_method="class") {

  df <- get_subset(language=language, 
                   df=df)
  df.genres <- df$df.genres
  
  df.genres.sets <- get_training_and_testing_sets(features=df.genres, 
                                                  training_percent=50, 
                                                  filenamestem=filenamestem, 
                                                  load=FALSE)
  
  #features.training <- features[df.genres.sets$training_inds,]
  #features.testing <- features[-df.genres.sets$training_inds,]
  features.training <- df.genres.sets$training
  features.testing <- df.genres.sets$testing
  
  features.training.split <- split_training_set(features=features.training, parts=5)
  features.split <- features.training.split
  
  #aggr <- as.data.frame(matrix(nrow = 22, ncol = 8))
  #names(aggr) <- c("SVM", "kNN", "RF", "OneR", "rpart", "C45", "PART", "gbm", "naive")
  #names(aggr) <- append(names(features[names(features)!="is_poetry"]), "TOTAL")
  aggr <- data.frame(SVM=numeric(22),
                     kNN=integer(22),
                     RF=integer(22),
                     OneR=integer(22),
                     rpart=integer(22),
                     C45=integer(22),
                     PART=integer(22),
                     gbm=integer(22),
                     naive=integer(22),
                     LDA=integer(22)
  )
  if (startpoint > 1) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr1.txt",sep= " "))
    rownames(aggr) <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[1]})
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[2]})
    aggr$SVM <-aggregated_results
  } else {   
    aggregated_results <- run_svm(features.split=features.split, 
                                            filestem = paste0(filenamestem, "_svm_")
                                            )
    aggr$SVM <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
      if ((x%%1==0)) {
        formatC(x, digits=9)
      } else {
        formatC(x=x, digits=8,format = "f")
      }
    })
    rownames(aggr) <- rownames(aggregated_results)
    sink(file=paste0(outputpath, "/", filenamestem, "_aggr1.txt"), append=FALSE)
    print(aggr)
    sink()
  }

  
  if (startpoint > 2) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr2.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[3]})
    aggr$kNN <-aggregated_results
  } else {
    aggregated_results <- run_knn(features.split=features.split, 
                                            filestem = paste0(filenamestem, "_knn_"),
                                            k = k
										  )
    aggr$kNN <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
      if ((x%%1==0)) {
        formatC(x, digits=9)
      } else {
        formatC(x=x, digits=8,format = "f")
      }
    })
    sink(file=paste0(outputpath, "/", filenamestem, "_aggr2.txt"), append=FALSE)
    print(aggr)
    sink()
  }
	
  if (startpoint > 3) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr3.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[4]})
    aggr$RF <-aggregated_results
  } else {
  	aggregated_results <- run_random_forest(features.split=features.split, 
                                            filestem = paste0(filenamestem, "_rf_"),
                                            ntree=ntree,
  										                      mtry=mtry
  										                      )
  	
  	aggr$RF <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
  	  if ((x%%1==0)) {
  	    formatC(x, digits=9)
  	  } else {
  	    formatC(x=x, digits=8,format = "f")
  	  }
  	})
    sink(file=paste0(outputpath, "/", filenamestem, "_aggr3.txt"), append=FALSE)
    print(aggr)
    sink()
  }
  
  if (startpoint > 4) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr4.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[5]})
    aggr$OneR <-aggregated_results
  } else {
    aggregated_results <- run_oner(features.split=features.split, 
                                   filestem = paste0(filenamestem, "_oner_"),
                                   method=oner_method
                                   )
    aggr$OneR <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
      if ((x%%1==0)) {
        formatC(x, digits=9)
      } else {
        formatC(x=x, digits=8,format = "f")
      }
    })
    sink(file=paste0(outputpath, "/", filenamestem, "_aggr4.txt"), append=FALSE)
    print(aggr)
    sink()
  }
  
  # CART: Classification And Regression Trees
  if (startpoint > 5) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr5.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[6]})
    aggr$rpart <-aggregated_results
  } else {
    aggregated_results <- run_rpart(features.split=features.split, 
                                    filestem = paste0(filenamestem, "_rpart_"),
                                    method=rpart_method
    )
    aggr$rpart <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
      if ((x%%1==0)) {
        formatC(x, digits=9)
      } else {
        formatC(x=x, digits=8,format = "f")
      }
    })
    sink(file=paste0(outputpath, "/", filenamestem, "_aggr5.txt"), append=FALSE)
    print(aggr)
    sink()
  }
  
	# C4.5 (Weka)
  if (startpoint > 6) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr6.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[7]})
    aggr$C45 <-aggregated_results
  } else {
  	aggregated_results <- run_C45(features.split=features.split, 
  	                                filestem = paste0(filenamestem, "_C45_")
  	)
  	aggr$C45 <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
  	  if ((x%%1==0)) {
  	    formatC(x, digits=9)
  	  } else {
  	    formatC(x=x, digits=8,format = "f")
  	  }
  	})
  	sink(file=paste0(outputpath, "/", filenamestem, "_aggr6.txt"), append=FALSE)
  	print(aggr)
  	sink()
  }
	
  if (startpoint > 7) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr7.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[8]})
    aggr$PART <-aggregated_results
  } else {
  	# PART: PART decision lists (Weka)
  	aggregated_results <- run_PART(features.split=features.split, 
  	                                filestem = paste0(filenamestem, "_PART_")
  	)
  	aggr$PART <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
  	  if ((x%%1==0)) {
  	    formatC(x, digits=9)
  	  } else {
  	    formatC(x=x, digits=8,format = "f")
  	  }
  	})
  	sink(file=paste0(outputpath, "/", filenamestem, "_aggr7.txt"), append=FALSE)
  	print(aggr)
  	sink()
  }
	
  if (startpoint > 8) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr8.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[9]})
    aggr$gbm <-aggregated_results
  } else {
	# gbm: Gradient Boosted Machine
  	aggregated_results <- run_gbm(features.split=features.split, 
  	                                filestem = paste0(filenamestem, "_gbm_"),
  	                                  distribution="multinomial",
  	                                 n.trees=100)
  	aggr$gbm <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
  	  if ((x%%1==0)) {
  	    formatC(x, digits=9)
  	  } else {
  	    formatC(x=x, digits=8,format = "f")
  	  }
  	})
  	sink(file=paste0(outputpath, "/", filenamestem, "_aggr8.txt"), append=FALSE)
  	print(aggr)
  	sink()
  }	
	# Naive Bayes
  if (startpoint > 9) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr9.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[10]})
    aggr$naive <-aggregated_results
  } else {
  	aggregated_results <- run_naivebayes(features.split=features.split, 
  	                              filestem = paste0(filenamestem, "_naive_")
  	                              )
  	aggr$naive <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
  	  if ((x%%1==0)) {
  	    formatC(x, digits=9)
  	  } else {
  	    formatC(x=x, digits=8,format = "f")
  	  }
  	})
  	sink(file=paste0(outputpath, "/", filenamestem, "_aggr9.txt"), append=FALSE)
  	print(aggr)
  	sink()
  }
  
	# LDA
  if (startpoint > 10) {
    aggregated_results <- read.delim(paste0(outputpath, "/", filenamestem, "_aggr10.txt",sep= " "))
    aggregated_results <- mapply(aggregated_results[[1]], FUN=function(x) {unlist(str_split(x, " +"))[11]})
    aggr$LDA <-aggregated_results
  } else {
    aggregated_results <- run_LDA(features.split=features.split, 
  	                                     filestem = paste0(filenamestem, "_lda_")
  	                                     )
  	aggr$LDA <- mapply(unlist(aggregated_results[, "total"]), FUN = function(x) {
  	  if ((x%%1==0)) {
  	    formatC(x, digits=9)
  	  } else {
  	    formatC(x=x, digits=8,format = "f")
  	  }
  	})
  	sink(file=paste0(outputpath, "/", filenamestem, "_aggr10.txt"), append=FALSE)
  	print(aggr)
  	sink()
  }
  return(aggr)
}
