library(OneR)
run_oner <- function(features.split, filestem="", method="infogain", unseen_value="FALSE") {
  matrices = list()
  for (set_no in 1:length(features.split)) {
    print(paste0("Starting run_oneR round ", set_no, " at ", date()))
    # Get all except one portion as a training group
    features <- rbindlist(features.split[-set_no], use.names=TRUE)
    
    is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
    features$is_poetry <- is_poetry
    
    if ("author" %in% names(features)) {
      poetry_authors <- features$author[which(is_poetry=="POETRY")]
      #author <- features$author
      features$author <- is_known_author(features$author, 
                                         poetry_authors=poetry_authors,
                                         ignore_NA=TRUE)
    } else if ("varia_author" %in% names(features)) {
      poetry_authors <- features$varia_author[which(is_poetry=="POETRY")]
      #author <- features$author
      features$varia_author <- is_known_author(features$varia_author, 
                                               poetry_authors=poetry_authors,
                                               ignore_NA=TRUE)
    }
    
	  x <- subset(features, select=-is_poetry)
    y <- is_poetry
	  features <- OneR::optbin(features, method=method)
	
    oner_model <- OneR::OneR(is_poetry ~ ., data=features)
    #oner_model <- optbin(oner_model, method=method)
    
	#summary(oner_model)
    # Get the last portion as the test group
    features2 <- rbindlist(features.split[set_no])
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
    
    x2 <- subset(features2, select=-is_poetry)
    y2 <- is_poetry2
    pred2 <- predict(oner_model,x2)
    matrices[[set_no]] <- table(pred2,y2)
    
    # Get variable_importance and print it
    if (set_no == 1) {
      #png(filename = paste0(outputpath, "/", filestem, "variable_importance_", set_no, ".png"))
      #varImpPlot(svm_model, sort=TRUE, main="Variable importance")                      
      #dev.off()
    }
	
    # OneR quirks:
    # pred2 has an extra class: "UNSEEN"
    print("...before UNSEEN")
    pred2[which(pred2=="UNSEEN")] <- unseen_value
    levels(pred2) <- droplevels(pred2)
	  print("..,before confusionMatrix")
    cm <- confusionMatrix(data=pred2, reference=is_poetry2, positive="TRUE")
    print("...convert_cm_to_df")
    cm_df <- convert_cm_to_df(cm)
    
    matrices[[set_no]] <- cm_df
    print(paste0("set_no: ", set_no, " done"))
    gc()
  }
  print("hep")
  sink(file = paste0(outputpath, "/", filestem ,"confusionMatrix_combined.txt"),
       append=FALSE)
  width <- getOption("width")
  options("width"=1000)
  aggregated_results <- aggregate_cm_dynamically(matrices)
  print(aggregated_results)
  options("width"=width)
  sink()
  return(aggregated_results)
 
}