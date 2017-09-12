library(stringr)
aggregate_aggregated_cm <- function(filepath, pattern, files=NULL) {
  
  if (is.null(files)) {
    files <- list.files(path=filepath, pattern=pattern, full.names = TRUE)
    filenames <- list.files(path=filepath, pattern=pattern, full.names = FALSE)
  } else {
    filenames <- files
    files <- paste0(filepath, "/", files)
  }
    
  ret <- data.frame(t(data.frame(FALSEFALSE=rep(NA, length(files)), 
                      FALSETRUE=rep(NA, length(files)),
                      TRUEFALSE=rep(NA, length(files)), 
                      TRUETRUE=rep(NA, length(files)), 
                      accuracy=rep(NA, length(files)), 
                      Kappa=rep(NA, length(files)),
                      accuracyLower=rep(NA, length(files)), 
                      accuracyUpper=rep(NA, length(files)), 
                      accuracyNull=rep(NA, length(files)), 
                      accuracyPValue=rep(NA, length(files)), 
                      accuracyMcnemarPValue=rep(NA, length(files)), 
                      sensitivity=rep(NA, length(files)), 
                      specifity=rep(NA, length(files)), 
                      pos_pred_value=rep(NA, length(files)), 
                      neg_pred_value=rep(NA, length(files)),
                      precision=rep(NA, length(files)), 
                      recall=rep(NA, length(files)), 
                      F1=rep(NA, length(files)), 
                      prevalence=rep(NA, length(files)), 
                      detection_rate=rep(NA, length(files)), 
                      detection_prevalence=rep(NA, length(files)), 
                      balanced_accuracy=rep(NA, length(files)))))
  names(ret) <- filenames
  i <- 1
  for (file in mixedsort(files)) {
    
    cm <- read.delim(file=file,sep="\t")
    
    
    ret["FALSEFALSE", i] <- unlist(str_split(as.character(cm[["total"]][1]), " +"))[7]
    ret["FALSETRUE", i] <- unlist(str_split(as.character(cm[["total"]][2]), " +"))[7]
    ret["TRUEFALSE", i] <- unlist(str_split(as.character(cm[["total"]][3]), " +"))[7]
    ret["TRUETRUE", i] <- unlist(str_split(as.character(cm[["total"]][4]), " +"))[7]
    ret["accuracy", i] <- unlist(str_split(as.character(cm[["total"]][5]), " +"))[7]
    ret["Kappa", i] <- unlist(str_split(as.character(cm[["total"]][6]), " +"))[7]
    ret["accuracyLower", i] <- unlist(str_split(as.character(cm[["total"]][7]), " +"))[7]
    ret["accuracyUpper", i] <- unlist(str_split(as.character(cm[["total"]][8]), " +"))[7]
    ret["accuracyNull", i] <- unlist(str_split(as.character(cm[["total"]][9]), " +"))[7]
    ret["accuracyPValue", i] <- unlist(str_split(as.character(cm[["total"]][10]), " +"))[7]
    ret["accuracyMcnemarPValue", i] <- unlist(str_split(as.character(cm[["total"]][11]), " +"))[7]
    ret["sensitivity", i] <- unlist(str_split(as.character(cm[["total"]][12]), " +"))[7]
    ret["specifity", i] <- unlist(str_split(as.character(cm[["total"]][13]), " +"))[7]
    ret["pos_pred_value", i] <- unlist(str_split(as.character(cm[["total"]][14]), " +"))[7]
    ret["neg_pred_value", i] <- unlist(str_split(as.character(cm[["total"]][15]), " +"))[7]
    ret["precision", i] <- unlist(str_split(as.character(cm[["total"]][16]), " +"))[7]
    ret["recall", i] <- unlist(str_split(as.character(cm[["total"]][17]), " +"))[7]
    ret["F1", i] <- unlist(str_split(as.character(cm[["total"]][18]), " +"))[7]
    ret["prevalence", i] <- unlist(str_split(as.character(cm[["total"]][19]), " +"))[7]
    ret["detection_rate", i] <- unlist(str_split(as.character(cm[["total"]][20]), " +"))[7]
    ret["detection_prevalence", i] <- unlist(str_split(as.character(cm[["total"]][21]), " +"))[7]
    ret["balanced_accuracy", i] <- unlist(str_split(as.character(cm[["total"]][22]), " +"))[7]
    i <- i + 1
  }
  ret
}

