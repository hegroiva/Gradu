library(stringr)
aggregate_aggregated_cm_newschool <- function(filepath, pattern, files=NULL) {
  
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
    cm <- read.delim(file=file,sep="")
    ret["FALSEFALSE", i] <- cm$total[2]
    ret["FALSETRUE", i] <- cm$total[3]
    ret["TRUEFALSE", i] <- cm$total[4]
    ret["TRUETRUE", i] <- cm$total[5]
    ret["accuracy", i] <- cm$total[6]
    ret["Kappa", i] <- cm$total[7]
    ret["accuracyLower", i] <- cm$total[8]
    ret["accuracyUpper", i] <- cm$total[9]
    ret["accuracyNull", i] <- cm$total[10]
    ret["accuracyPValue", i] <- cm$total[11]
    ret["accuracyMcnemarPValue", i] <- cm$total[12]
    ret["sensitivity", i] <- cm$total[13]
    ret["specifity", i] <- cm$total[14]
    ret["pos_pred_value", i] <- cm$total[15]
    ret["neg_pred_value", i] <- cm$total[16]
    ret["precision", i] <- cm$total[17]
    ret["recall", i] <- cm$total[18]
    ret["F1", i] <- cm$total[19]
    ret["prevalence", i] <- cm$total[20]
    ret["detection_rate", i] <- cm$total[21]
    ret["detection_prevalence", i] <- cm$total[22]
    ret["balanced_accuracy", i] <- cm$total[23]
    i <- i + 1
  }
  ret
}

