library(caret)
source("GitHub/Gradu/hmeasureCaret.R")
run_caret_rf <- function(features.split, filestem="", ntree=500, mtry=5, get_pairwise_comparison=TRUE, get_rfe=TRUE) {
  matrices = list()

  custom_rf_method <- add_customized_rf_model()
  
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting customized run_random_forest round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    # Precaution
    names(features) <- gsub(" ", "_", names(features))
    # Change names for cforest
    levels(features$is_poetry) <- gsub("FALSE", "NONPOETRY", levels(features$is_poetry))
    levels(features$is_poetry) <- gsub("TRUE", "POETRY", levels(features$is_poetry))
    
    #is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    #features$is_poetry <- is_poetry
    is_poetry <- features$is_poetry
    
    
    

    
    features2 <- rbindlist(features.split[set_no])
    
    # Precaution
    names(features2) <- gsub(" ", "_", names(features2))
    # Change names for cforest
    levels(features2$is_poetry) <- gsub("FALSE", "NONPOETRY", levels(features2$is_poetry))
    levels(features2$is_poetry) <- gsub("TRUE", "POETRY", levels(features2$is_poetry))
    
    is_poetry2 <- features2$is_poetry
    
    

    
    
    if (set_no==1) {
      ctrl <- trainControl(method = "boot",
                           number = 10, 
                           repeats = 1, 
                           summaryFunction = hmeasureCaret,
                           classProbs=TRUE,
                           allowParallel = TRUE,
                           verboseIter=FALSE,
                           returnData=FALSE,
                           savePredictions=FALSE)
      
      rf_Tune <- train(is_poetry ~ ., 
                       data = features,
                       method = custom_rf_method,
                       trControl = ctrl,
                       preProc =c(),
                       tuneLength = 20,
                       ntree=500,
                       metric="Hmeas",
                       verbose = FALSE)
      
      predictedProbs <- predict(rf_Tune, features2, type="prob")
      hmeas.check<- HMeasure(true.class = is_poetry2 ,predictedProbs[,2])
      summary(hmeas.check)
      sink(file = paste0("C:/Users/Hege/Opiskelu/Kurssit/Gradu/output/", filestem, "_measures.txt"))
      print(t(hmeas.check$metrics))
      sink()
    }
    
    # Pairwise comparisons of individual features
    # NOTE: Done on party::cforest, because it is the only package that supports conditional unbiased permutation measure
    if (get_pairwise_comparison & set_no==1) {
      # Prepare a matrix for the end results of pairwise comparisons
      pairwise_rets <- matrix(nrow = length(features)-1,
                              ncol =length(features)-1, 
                              dimnames = list(names(features)[1:(length(names(features))-1)],
                                              names(features)[1:(length(names(features))-1)]))
      
      for (j in 1:(length(features) -2)) {
        print(paste0(" ...starting VarImp check for feature ", j, ": ", names(features)[j], " at ", date()))
        for (k in (j+1):(length(features) -1)) {
          tmp_feats <- features[,c(j,k,which(names(features)=="is_poetry")), with=FALSE]
          tmp_model <- cforest(is_poetry ~., tmp_feats, controls = cforest_unbiased(mtry=2, ntree=1))
          tryCatch({
            tmp_ret <- party::varimp(tmp_model, conditional = TRUE)
          }, error=function(e) {print(paste0("      ...pairwise comparison failed for: ", 
                                             names(tmp_feats)[1], 
                                             " and ", 
                                             names(tmp_feats)[2]))}
          ) 
          pairwise_rets[names(tmp_ret)[1], names(tmp_ret)[2]] <- unname(tmp_ret[1])
          pairwise_rets[names(tmp_ret)[2], names(tmp_ret)[1]] <- unname(tmp_ret[2])
        }
        tmp_feats <- features
      }
      variable_importance <- data.frame(rowMeans(pairwise_rets, na.rm = TRUE))
      row_names <- row.names(variable_importance)
      variable_importance <- unlist(lapply(variable_importance, FUN = function(x) {
        if ((x%%1==0)) {
          formatC(x, digits=9)
        } else {
          formatC(x=x, digits=8,format = "f")
        }
      }))
      na_count <- apply(pairwise_rets, 1, function(x) sum(is.na(x)))
      
      variable_importance <- data.frame(variable_name=row_names, 
                                        conditional_importance=variable_importance,
                                        na_count=na_count,
                                        row.names = NULL,
                                        stringsAsFactors = FALSE
                                        )
      
      sink(file = paste0("C:/Users/Hege/Opiskelu/Kurssit/Gradu/output/", filestem, "_variable_importance_conditional.txt"))
      print(variable_importance)
      sink()
    }
    
    varNames <- names(features)[!names(features) %in% c("is_poetry")]
    varNames1 <- paste(varNames, collapse="+")
    rfForm <- as.formula(paste("is_poetry", varNames1, sep=" ~ "))
    ratio_is_poetry <- length(which(features$is_poetry=="POETRY")) / nrow(features)
    
    
    retRF <- randomForest::randomForest(rfForm,
                                        features, 
                                        ntree=ntree, 
                                        importance=TRUE, 
                                        mtry=mtry, 
                                        cutoff=c(1-ratio_is_poetry, ratio_is_poetry)
                                        )
    retRF_no_cutoff <- randomForest::randomForest(rfForm,
                                        features, 
                                        ntree=ntree, 
                                        importance=TRUE, 
                                        mtry=mtry 
                                        #cutoff=c(1-ratio_is_poetry, ratio_is_poetry)
                                        )
    
    
    if (set_no==1) {
      print(paste0("...start caret::varImp at ", date()))
      imp2 <- randomForest::importance(retRF)
      imp3 <- caret::varImp(retRF, scale=FALSE)
      
      imp2_no_cutoff <- randomForest::importance(retRF_no_cutoff)
      imp3_no_cutoff <- caret::varImp(retRF_no_cutoff, scale=FALSE)
      
      sink(file = paste0("C:/Users/Hege/Opiskelu/Kurssit/Gradu/output/", filestem, "_variable_importance_randomForest.txt"))
      print(imp2)
      sink()
      sink(file = paste0("C:/Users/Hege/Opiskelu/Kurssit/Gradu/output/", filestem, "_variable_importance_caret.txt"))
      print(imp3)
      sink()
      
      sink(file = paste0("C:/Users/Hege/Opiskelu/Kurssit/Gradu/output/", filestem, "_variable_importance_randomForest_no_cut.txt"))
      print(imp2_no_cutoff)
      sink()
      sink(file = paste0("C:/Users/Hege/Opiskelu/Kurssit/Gradu/output/", filestem, "_variable_importance_caret_no_cut.txt"))
      print(imp3_no_cutoff)
      sink()
    }
    
    if (get_rfe & set_no==1) {
      print(paste0("...start rfe at ", date()))
      f2 <- features
      f2$is_poetry <- NULL
      varLists <- rfe(x=f2, y=is_poetry, sizes=c(2:10,15,20), rfeControl = rfeControl(functions=rfFuncs))
      sink(file = paste0("C:/Users/Hege/Opiskelu/Kurssit/Gradu/output/", filestem, "_recursive_feature_selection.txt"))
      print(varLists)
      sink()
    }
    
    varNames_2 <- names(features2)[!names(features2) %in% c("is_poetry")]
    varNames1_2 <- paste(varNames_2, collapse="+")
    rfForm2 <- as.formula(paste("is_poetry", varNames1_2, sep=" ~ "))
    
    ratio_is_poetry <- length(which(features2$is_poetry=="POETRY")) / nrow(features2)
    retRF2 <- randomForest::randomForest(rfForm2, 
                                         features2, 
                                         ntree=ntree, 
                                         importance=TRUE, 
                                         mtry=mtry,
                                         #strata="is_poetry",
                                         #sampsize=c(5000,500))
                                         cutoff=c(1-ratio_is_poetry, ratio_is_poetry))
    
    # Get variable_importance and print it
    if (set_no == 1) {
      png(filename = paste0("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\output\\", filestem, "variable_importance_", set_no, ".png"))
      varImpPlot(retRF2, sort=TRUE, main="Variable importance")                      
      dev.off()
    }
    # Get prediction
    features2$is_poetry <- NULL
    prediction <- predict(retRF, features2)
    
    #sink(file = paste0("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\output\\", filestem ,"confusionMatrix_", set_no, ".txt"),
    #     append=FALSE)
    #print(paste0("Number of trees: ", ntree))
    #print(paste0("Features tried: ", mtry))
    cm <- confusionMatrix(data=prediction, reference=is_poetry2, positive="POETRY")
    matrices[[set_no]] <- cm
    #cm2 <- table(prediction, is_poetry2)
    #print(cm)
    #print(cm2)
    #print("--------------------------------------------------------------------------------------------")
    #print(date())
    #sink()
    #matrices[[set_no]] <- cm
    gc()
  }
  sink(file = paste0("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\output\\", filestem ,"confusionMatrix_combined.txt"),
       append=FALSE)
  
  aggregated_results <- aggregate_confusion_matrix(matrices)
  print(aggregated_results)
  sink()
  #  for (matr in matrices) {
  #    print(cm)
  #    sink()
  #    sink(file = paste0("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\output\\", filestem ,"confusionMatrix_combined.txt"),
  #         append=TRUE)
  #  }
  #  sink()
  return(aggregated_results)
  #cm2
}