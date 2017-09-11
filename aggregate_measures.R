library(stringr)
aggregate_measures <- function(filepath, pattern, files=NULL) {
  
    if (is.null(files)) {
      files <- list.files(path=filepath, pattern=pattern, full.names = TRUE)
      filenames <- list.files(path=filepath, pattern=pattern, full.names = FALSE)
    } else {
      filenames <- files
      files <- paste0(filepath, "/", files)
    }
    
    ret <- data.frame(t(data.frame(H=rep(NA, length(files)), 
                                   Gini=rep(NA, length(files)),
                                   AUC=rep(NA, length(files)), 
                                   AUCH=rep(NA, length(files)), 
                                   KS=rep(NA, length(files)), 
                                   MER=rep(NA, length(files)),
                                   MWL=rep(NA, length(files)), 
                                   Spec.Sens95=rep(NA, length(files)), 
                                   Sens.Spec95=rep(NA, length(files)), 
                                   ER=rep(NA, length(files)), 
                                   Sens=rep(NA, length(files)), 
                                   Spec=rep(NA, length(files)), 
                                   Precision=rep(NA, length(files)), 
                                   Recall=rep(NA, length(files)), 
                                   TPR=rep(NA, length(files)),
                                   FPR=rep(NA, length(files)), 
                                   F=rep(NA, length(files)), 
                                   Youden=rep(NA, length(files)), 
                                   TP=rep(NA, length(files)), 
                                   FP=rep(NA, length(files)), 
                                   TN=rep(NA, length(files)), 
                                   FN=rep(NA, length(files)))))
    names(ret) <- filenames
    i <- 1
    for (file in mixedsort(files)) {
      cm <- read.delim(file=file)
      ret["H", i] <- unlist(str_split(as.character(cm[["scores"]][1]), " +"))[2]
      ret["Gini", i] <- unlist(str_split(as.character(cm[["scores"]][2]), " +"))[2]
      ret["AUC", i] <- unlist(str_split(as.character(cm[["scores"]][3]), " +"))[2]
      ret["AUCH", i] <- unlist(str_split(as.character(cm[["scores"]][4]), " +"))[2]
      ret["KS", i] <- unlist(str_split(as.character(cm[["scores"]][5]), " +"))[2]
      ret["MER", i] <- unlist(str_split(as.character(cm[["scores"]][6]), " +"))[2]
      ret["MWL", i] <- unlist(str_split(as.character(cm[["scores"]][7]), " +"))[2]
      ret["Spec.Sens95", i] <- unlist(str_split(as.character(cm[["scores"]][8]), " +"))[2]
      ret["Sens.Spec95", i] <- unlist(str_split(as.character(cm[["scores"]][9]), " +"))[2]
      ret["ER", i] <- unlist(str_split(as.character(cm[["scores"]][10]), " +"))[2]
      ret["Sens", i] <- unlist(str_split(as.character(cm[["scores"]][11]), " +"))[2]
      ret["Spec", i] <- unlist(str_split(as.character(cm[["scores"]][12]), " +"))[2]
      ret["Precision", i] <- unlist(str_split(as.character(cm[["scores"]][13]), " +"))[2]
      ret["Recall", i] <- unlist(str_split(as.character(cm[["scores"]][14]), " +"))[2]
      ret["TPR", i] <- unlist(str_split(as.character(cm[["scores"]][15]), " +"))[2]
      ret["FPR", i] <- unlist(str_split(as.character(cm[["scores"]][16]), " +"))[2]
      ret["F", i] <- unlist(str_split(as.character(cm[["scores"]][17]), " +"))[2]
      ret["Youden", i] <- unlist(str_split(as.character(cm[["scores"]][18]), " +"))[2]
      ret["TP", i] <- unlist(str_split(as.character(cm[["scores"]][19]), " +"))[2]
      ret["FP", i] <- unlist(str_split(as.character(cm[["scores"]][20]), " +"))[2]
      ret["TN", i] <- unlist(str_split(as.character(cm[["scores"]][21]), " +"))[2]
      ret["FN", i] <- unlist(str_split(as.character(cm[["scores"]][22]), " +"))[2]
      i <- i + 1
    }
    ret
  }
  
  
  
