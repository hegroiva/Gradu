run_rf_final <- function(df, features, filenamestem, language="eng", ntree=500, mtry=5, training_percent=50, genres_only=TRUE, fringe_is_poetry=FALSE) {

  matrices_no_cutoff <- list()
  
  if (genres_only) {
    feats <- features[which(df$language==language & df$genre!=""),]
  } else {
    feats <- features[which(df$language==language),]
  }
  
  df <- get_subset(language=language, 
                   df=df)
  df.genres <- df$df.genres
  
  df.genres.sets <- get_training_and_testing_sets(features=feats, 
                                                  training_percent=training_percent, 
                                                  filenamestem=filenamestem, 
                                                  load=FALSE)
  
  features.training <- df.genres.sets$training
  features.testing <- df.genres.sets$testing

  #aggr <- as.data.frame(matrix(nrow = 22, ncol = length(features.training)))
  #names(aggr) <- append(names(features[names(features.training)!="is_poetry"]), "TOTAL")

  #aggregated_results <- run_rf(features.split=features.split, 
  #                             filestem = paste0(filenamestem, "_"),
  #                             ntree=ntree, 
  #                             mtry=mtry)
  
  
  # Precaution
  names(features.training) <- gsub(" ", "_", names(features.training))
  
  is_poetry <- features.training$is_poetry
  features.training$is_poetry <- is_poetry
  
  # Change names for cforest
  levels(features.training$is_poetry) <- gsub("FALSE", "NONPOETRY", levels(features.training$is_poetry))
  levels(features.training$is_poetry) <- gsub("TRUE", "POETRY", levels(features.training$is_poetry))
  is_poetry <- features.training$is_poetry
  
  # On the fly! (Part 1)
  if ("author" %in% names(features.training)) {
    if (fringe_is_poetry) {
      poetry_authors <- features.training$author[which(is_poetry=="POETRY" | is_poetry=="HARDCORE" | is_poetry=="FRINGE")]
    } else {
      poetry_authors <- features.training$author[which(is_poetry=="POETRY" | is_poetry=="HARDCORE")]
    }
    #author <- features$author
    features.training$author <- is_known_author(features.training$author, 
                                       poetry_authors=poetry_authors,
                                       ignore_NA=TRUE)
  } else if ("varia_author" %in% names(features.training)) {
    if (fringe_is_poetry) {
      poetry_authors <- features.training$varia_author[which(is_poetry=="POETRY" | is_poetry=="HARDCORE")]
    } else {
      poetry_authors <- features.training$varia_author[which(is_poetry=="POETRY" | is_poetry=="HARDCORE")]
    }
    #author <- features$author
    features.training$varia_author <- is_known_author(features.training$varia_author, 
                                             poetry_authors=poetry_authors,
                                             ignore_NA=TRUE)
  }
  
  varNames <- names(features.training)[!names(features.training) %in% c("is_poetry")]
  varNames1 <- paste(varNames, collapse="+")
  rfForm <- as.formula(paste("is_poetry", varNames1, sep=" ~ "))

  ctrl <- trainControl(method = "boot",
                       number = 1, 
                       repeats = 5, 
                       summaryFunction = hmeasureCaret,
                       classProbs=TRUE,
                       allowParallel = TRUE,
                       verboseIter=FALSE,
                       returnData=FALSE,
                       savePredictions=FALSE)
  
  
  
  retRF_no_cutoff <- randomForest::randomForest(rfForm,
                                                features.training, 
                                                ntree=ntree, 
                                                importance=TRUE, 
                                                mtry=mtry
  )
  
  # Get the last portion as the test group
  #features2 <- rbindlist(features.split[set_no])
  features2 <- features.testing
  # Precaution
  names(features2) <- gsub(" ", "_", names(features2))
  # Change names for cforest
  levels(features2$is_poetry) <- gsub("FALSE", "NONPOETRY", levels(features2$is_poetry))
  levels(features2$is_poetry) <- gsub("TRUE", "POETRY", levels(features2$is_poetry))
  
  is_poetry2 <- features2$is_poetry
  
  # On the fly! (Part 2)
  if ("author" %in% names(features)) {
    features2$author <- is_known_author(features2$author, 
                                        poetry_authors=poetry_authors,
                                        ignore_NA=TRUE)
  } else if ("varia_author" %in% names(features)) {
    features2$varia_author <- is_known_author(features2$varia_author, 
                                              poetry_authors=poetry_authors,
                                              ignore_NA=TRUE)
  }
  
  # Get prediction
  features2$is_poetry <- NULL
  
  
  prediction_no_cutoff <- predict(retRF_no_cutoff, features2)
  
  
  cm_no_cutoff <- confusionMatrix(data=prediction_no_cutoff, reference=is_poetry2, positive="POETRY")
  cm_df <- convert_cm_to_df(cm_no_cutoff)
  #matrices_no_cutoff[[1]] <- cm_df
  
  gc()
  
  
  
  #aggregated_results_no_cutoff <- aggregate_cm_dynamically(matrices_no_cutoff)
  sink(file = paste0(outputpath, "/", filenamestem ,"confusionMatrix_combined_no_cutoff.txt"),
       append=FALSE)
  
  #aggregated_results_no_cutoff <- aggregate_confusion_matrix(matrices_no_cutoff)
  
  width <- getOption("width")
  options("width"=1000)
  print(cm_df)
  options("width"=width)
  
  sink()
  
  
  
  
  
  
  
  
  
  
  
  return(cm_df)
}
