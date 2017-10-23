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
    cm <- read.delim2(file=file,sep="", header=FALSE)
    #if (length(cm) > 1) {
    #  ret["FALSEFALSE", i] <- cm$total[2]
    #  ret["FALSETRUE", i] <- cm$total[3]
    #  ret["TRUEFALSE", i] <- cm$total[4]
    #  ret["TRUETRUE", i] <- cm$total[5]
    #  ret["accuracy", i] <- cm$total[6]
    #  ret["Kappa", i] <- cm$total[7]
    #  ret["accuracyLower", i] <- cm$total[8]
    #  ret["accuracyUpper", i] <- cm$total[9]
    #  ret["accuracyNull", i] <- cm$total[10]
    #  ret["accuracyPValue", i] <- cm$total[11]
    #  ret["accuracyMcnemarPValue", i] <- cm$total[12]
    #  ret["sensitivity", i] <- cm$total[13]
    #  ret["specifity", i] <- cm$total[14]
    #  ret["pos_pred_value", i] <- cm$total[15]
    #  ret["neg_pred_value", i] <- cm$total[16]
    #  ret["precision", i] <- cm$total[17]
    #  ret["recall", i] <- cm$total[18]
    #  ret["F1", i] <- cm$total[19]
    #  ret["prevalence", i] <- cm$total[20]
    #  ret["detection_rate", i] <- cm$total[21]
    #  ret["detection_prevalence", i] <- cm$total[22]
    #  ret["balanced_accuracy", i] <- cm$total[23]
    #} else {
    line_offset <- 0
    if (is.na(cm[,length(cm)][2])) {line_offset <- 1}
    
      ret["FALSEFALSE", i] <- as.integer(as.vector(cm[,length(cm)][2 + line_offset]))
      ret["FALSETRUE", i] <- as.integer(as.vector(cm[,length(cm)][3 + line_offset]))
      ret["TRUEFALSE", i] <- as.integer(as.vector(cm[,length(cm)][4 + line_offset]))
      ret["TRUETRUE", i] <- as.integer(as.vector(cm[,length(cm)][5 + line_offset]))
      ret["accuracy", i] <- as.numeric(as.vector(cm[,length(cm)][6 + line_offset]))
      ret["Kappa", i] <- as.numeric(as.vector(cm[,length(cm)][7 + line_offset]))
      ret["accuracyLower", i] <- as.numeric(as.vector(cm[,length(cm)][8 + line_offset]))
      ret["accuracyUpper", i] <- as.numeric(as.vector(cm[,length(cm)][9 + line_offset]))
      ret["accuracyNull", i] <- as.numeric(as.vector(cm[,length(cm)][10 + line_offset]))
      ret["accuracyPValue", i] <- as.numeric(as.vector(cm[,length(cm)][11 + line_offset]))
      ret["accuracyMcnemarPValue", i] <- as.numeric(as.vector(cm[,length(cm)][12 + line_offset]))
      ret["sensitivity", i] <- as.numeric(as.vector(cm[,length(cm)][13 + line_offset]))
      ret["specifity", i] <- as.numeric(as.vector(cm[,length(cm)][14 + line_offset]))
      ret["pos_pred_value", i] <- as.numeric(as.vector(cm[,length(cm)][15 + line_offset]))
      ret["neg_pred_value", i] <- as.numeric(as.vector(cm[,length(cm)][16 + line_offset]))
      ret["precision", i] <- as.numeric(as.vector(cm[,length(cm)][17 + line_offset]))
      ret["recall", i] <- as.numeric(as.vector(cm[,length(cm)][18 + line_offset]))
      ret["F1", i] <- as.numeric(as.vector(cm[,length(cm)][19 + line_offset]))
      ret["prevalence", i] <- as.numeric(as.vector(cm[,length(cm)][20 + line_offset]))
      ret["detection_rate", i] <- as.numeric(as.vector(cm[,length(cm)][21 + line_offset]))
      ret["detection_prevalence", i] <- as.numeric(as.vector(cm[,length(cm)][22 + line_offset]))
      ret["balanced_accuracy", i] <- as.numeric(as.vector(cm[,length(cm)][23 + line_offset]))  
      
      #ret["FALSEFALSE", i] <- as.integer(as.vector(cm[["ret"]][2]))
      #ret["FALSETRUE", i] <- as.integer(as.vector(cm[["ret"]][3]))
      #ret["TRUEFALSE", i] <- as.integer(as.vector(cm[["ret"]][4]))
      #ret["TRUETRUE", i] <- as.integer(as.vector(cm[["ret"]][5]))
      #ret["accuracy", i] <- as.numeric(as.vector(cm[["ret"]][6]))
      #ret["Kappa", i] <- as.numeric(as.vector(cm[["ret"]][7]))
      #ret["accuracyLower", i] <- as.numeric(as.vector(cm[["ret"]][8]))
      #ret["accuracyUpper", i] <- as.numeric(as.vector(cm[["ret"]][9]))
      #ret["accuracyNull", i] <- as.numeric(as.vector(cm[["ret"]][10]))
      #ret["accuracyPValue", i] <- as.numeric(as.vector(cm[["ret"]][11]))
      #ret["accuracyMcnemarPValue", i] <- as.numeric(as.vector(cm[["ret"]][12]))
      #ret["sensitivity", i] <- as.numeric(as.vector(cm[["ret"]][13]))
      #ret["specifity", i] <- as.numeric(as.vector(cm[["ret"]][14]))
      #ret["pos_pred_value", i] <- as.numeric(as.vector(cm[["ret"]][15]))
      #ret["neg_pred_value", i] <- as.numeric(as.vector(cm[["ret"]][16]))
      #ret["precision", i] <- as.numeric(as.vector(cm[["ret"]][17]))
      #ret["recall", i] <- as.numeric(as.vector(cm[["ret"]][18]))
      #ret["F1", i] <- as.numeric(as.vector(cm[["ret"]][19]))
      #ret["prevalence", i] <- as.numeric(as.vector(cm[["ret"]][20]))
      #ret["detection_rate", i] <- as.numeric(as.vector(cm[["ret"]][21]))
      #ret["detection_prevalence", i] <- as.numeric(as.vector(cm[["ret"]][22]))
      #ret["balanced_accuracy", i] <- as.numeric(as.vector(cm[["ret"]][23]))  
    #}
    
    i <- i + 1
  }
  ret
}

