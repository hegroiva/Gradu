run_rf_test <- function(features.training, 
                        features.testing,
                        filenamestem,
                        ntree=500,
                        mtry=5,
                        genres_only=TRUE,
                        fringe_is_poetry=FALSE) {
  
  matrices_no_cutoff <- list()
  
  

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
    features.training$author <- is_known_author(features.training$author, 
                                                poetry_authors=poetry_authors,
                                                ignore_NA=TRUE)
  } else if ("varia_author" %in% names(features.training)) {
    if (fringe_is_poetry) {
      poetry_authors <- features.training$varia_author[which(is_poetry=="POETRY" | is_poetry=="HARDCORE")]
    } else {
      poetry_authors <- features.training$varia_author[which(is_poetry=="POETRY" | is_poetry=="HARDCORE")]
    }
    features.training$varia_author <- is_known_author(features.training$varia_author, 
                                                      poetry_authors=poetry_authors,
                                                      ignore_NA=TRUE)
  }
  
  varNames <- names(features.training)[!names(features.training) %in% c("is_poetry")]
  varNames1 <- paste(varNames, collapse="+")
  rfForm <- as.formula(paste("is_poetry", varNames1, sep=" ~ "))
  
  #ctrl <- trainControl(method = "boot",
  #                     number = 1, 
  #                     repeats = 5, 
  #                     summaryFunction = hmeasureCaret,
  #                     classProbs=TRUE,
  #                     allowParallel = TRUE,
  #                     verboseIter=FALSE,
  #                     returnData=FALSE,
  #                     savePredictions=FALSE)
  # On the fly! (Part 2)
  if ("author" %in% names(features.testing)) {
    features.testing$author <- is_known_author(features.testing$author, 
                                        poetry_authors=poetry_authors,
                                        ignore_NA=TRUE)
  } else if ("varia_author" %in% names(features.testing)) {
    features.testing$varia_author <- is_known_author(features.testing$varia_author, 
                                              poetry_authors=poetry_authors,
                                              ignore_NA=TRUE)
  }
  
  retRF_no_cutoff <- randomForest::randomForest(rfForm,
                                                features.training, 
                                                ntree=ntree, 
                                                importance=TRUE, 
                                                replace=FALSE,
                                                mtry=mtry)
  
  
  
  
  
  
  
  
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
  if ("author" %in% names(features2)) {
    features2$author <- is_known_author(features2$author, 
                                        poetry_authors=poetry_authors,
                                        ignore_NA=TRUE)
  } else if ("varia_author" %in% names(features2)) {
    features2$varia_author <- is_known_author(features2$varia_author, 
                                              poetry_authors=poetry_authors,
                                              ignore_NA=TRUE)
    if (levels(features2$varia_author) == c("FALSE")) {
      levels(features2$varia_author) <- c("FALSE", "TRUE")
    } else if (levels(features2$varia_author) == c("TRUE")) {
      levels(features2$varia_author) <- c("TRUE", "FALSE")
    }
  }
  
  # Get prediction
  features2$is_poetry <- NULL
  #print(features2$varia_author)
  
  prediction_no_cutoff <- predict(retRF_no_cutoff, features2)
  
  return(prediction_no_cutoff)
  cm_no_cutoff <- confusionMatrix(data=prediction_no_cutoff, reference=is_poetry2, positive="POETRY")
  cm_df <- convert_cm_to_df(cm_no_cutoff)
  #matrices_no_cutoff[[1]] <- cm_df
  
  gc()
  
  
  
  #aggregated_results_no_cutoff <- aggregate_cm_dynamically(matrices_no_cutoff)
  sink(file = paste0(outputpath, "/", filenamestem ,"_confusionMatrix_combined_no_cutoff.txt"),
       append=FALSE)
  
  #aggregated_results_no_cutoff <- aggregate_confusion_matrix(matrices_no_cutoff)
  
  width <- getOption("width")
  options("width"=1000)
  print(cm_df)
  options("width"=width)
  
  sink()
  
  
  
  
  
  
  
  
  
  
  
  return(cm_df)
}
