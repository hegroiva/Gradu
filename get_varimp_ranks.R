get_varimp_ranks <- function(filepath, 
                             filenamestem,
                             outputfile="",
                             thresholds=c(0.01,0.015,100,100,100,100)) {
  
  if (outputfile=="") {
    outputfilepath <- paste0(filepath, "/", filenamestem, "_all_varimps.csv" )
  } else {
    outputfilepath <- paste0(filepath, "/", outputfile)
  }
  
  if (file.exists(paste0(filepath, "/", filenamestem, "__variable_importance_caret.txt"))) {
    caret_file <- paste0(filepath, "/", filenamestem, "__variable_importance_caret.txt")
  } else {
    caret_file <- paste0(filepath, "/", filenamestem, "_caret_ntree250_mtry10__variable_importance_caret.txt")
  }
  # Caret rank
  tmp <- read.csv2(file = caret_file, 
            header = TRUE,
            quote = "",
            sep = "",
            stringsAsFactors = FALSE,
            row.names = 1
            )
  df_tmp <- data.frame(tmp, stringsAsFactors = FALSE)
  df_tmp$caret_rank <- NA
  order.scores <- order(df_tmp$NONPOETRY, row.names(df_tmp))
  df_tmp$caret_rank[order.scores] <- 1:nrow(df_tmp)
  df_tmp$caret_threshold <- ""
  df_tmp$caret_threshold[which(df_tmp$NONPOETRY >= thresholds[1])] <- "TRUE"
  measures <- df_tmp
  
  
  # Conditional rank
  if (file.exists(paste0(filepath, "/", filenamestem, "__variable_importance_conditional.txt"))) {
    conditional_file <- paste0(filepath, "/", filenamestem, "__variable_importance_conditional.txt")
  } else {
    conditional_file <- paste0(filepath, "/", filenamestem, "_caret_ntree250_mtry10__variable_importance_conditional.txt")
  }
  tmp <- read.csv2(file = conditional_file, 
                   header = TRUE,
                   quote = "",
                   sep = "",
                   stringsAsFactors = FALSE,
                   row.names = 1
  )
  df_tmp <- data.frame(tmp, stringsAsFactors = FALSE)
  df_tmp$conditional_rank <- NA
  order.scores <- order(df_tmp$conditional_importance, row.names(df_tmp))
  df_tmp$conditional_rank[order.scores] <- 1:nrow(df_tmp)
  df_tmp$conditional_threshold <- ""
  df_tmp$conditional_threshold[which(df_tmp$conditional_importance >= thresholds[2])] <- "TRUE"
  
  measures$conditional_importance <- df_tmp$conditional_importance
  measures$conditional_rank <- df_tmp$conditional_rank
  measures$conditional_threshold <- df_tmp$conditional_threshold
  # randomForest ranks
  if (file.exists(paste0(filepath, "/", filenamestem, "__variable_importance_randomForest_no_cut.txt"))) {
    rf_file <- paste0(filepath, "/", filenamestem, "__variable_importance_randomForest_no_cut.txt")
  } else {
    rf_file <- paste0(filepath, "/", filenamestem, "_caret_ntree250_mtry10__variable_importance_randomForest_no_cut.txt")
  }
  tmp <- read.csv2(file = rf_file, 
                   header = TRUE,
                   quote = "",
                   sep = "",
                   stringsAsFactors = FALSE,
                   row.names = 1
  )
  df_tmp <- data.frame(tmp, stringsAsFactors = FALSE)
  
  # NONPOETRY
  df_tmp$nonpoetry_rank <- NA
  order.scores <- order(as.numeric(df_tmp$NONPOETRY), row.names(df_tmp))
  df_tmp$nonpoetry_rank[order.scores] <- 1:nrow(df_tmp)
  df_tmp$nonpoetry_threshold <- ""
  df_tmp$nonpoetry_threshold[which(as.integer(df_tmp$NONPOETRY) >= thresholds[3])] <- "TRUE"
  
  measures$nonpoetry <- df_tmp$NONPOETRY
  measures$nonpoetry_rank <- df_tmp$nonpoetry_rank
  measures$nonpoetry_threshold <- df_tmp$nonpoetry_threshold
  
  # POETRY
  df_tmp$poetry_rank <- NA
  order.scores <- order(as.numeric(df_tmp$POETRY), row.names(df_tmp))
  df_tmp$poetry_rank[order.scores] <- 1:nrow(df_tmp)
  df_tmp$poetry_threshold <- ""
  df_tmp$poetry_threshold[which(as.integer(df_tmp$POETRY) >= thresholds[4])] <- "TRUE"
  
  measures$poetry <- df_tmp$POETRY
  measures$poetry_rank <- df_tmp$poetry_rank
  measures$poetry_threshold <- df_tmp$poetry_threshold
  
  # MeanDecreaseAccuracy
  df_tmp$MDA_rank <- NA
  order.scores <- order(as.numeric(df_tmp$MeanDecreaseAccuracy), row.names(df_tmp))
  df_tmp$MDA_rank[order.scores] <- 1:nrow(df_tmp)
  df_tmp$MDA_threshold <- ""
  df_tmp$MDA_threshold[which(as.integer(df_tmp$MeanDecreaseAccuracy) >= thresholds[5])] <- "TRUE"
  
  measures$MDA <- df_tmp$MeanDecreaseAccuracy
  measures$MDA_rank <- df_tmp$MDA_rank
  measures$MDA_threshold <- df_tmp$MDA_threshold
  
  # MeanDecreaseGini
  df_tmp$MDG_rank <- NA
  order.scores <- order(as.numeric(df_tmp$MeanDecreaseGini), row.names(df_tmp))
  df_tmp$MDG_rank[order.scores] <- 1:nrow(df_tmp)
  df_tmp$MDG_threshold <- ""
  df_tmp$MDG_threshold[which(as.integer(df_tmp$MeanDecreaseGini) >= thresholds[6])] <- "TRUE"
  
  measures$MDG <- df_tmp$MeanDecreaseGini
  measures$MDG_rank <- df_tmp$MDG_rank
  measures$MDG_threshold <- df_tmp$MDG_threshold
  
  write.csv2(measures, outputfilepath, quote=FALSE, row.names = TRUE)
  return(measures)
  
}