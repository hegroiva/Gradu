convert_cm_to_df <- function(cm) {
  
  i <- 1
  all_names <- rep("", length(unlist(cm)))

  # First: $positive
  all_names[i] <- "positive"  
  i <- i + 1
  
  # Second: $table
  for (colname in colnames(cm$table)) {
    for (rowname in row.names(cm$table)) {
      all_names[i] <- paste0(colname, "_as_", rowname)
      i <- i + 1
    }
  }
  
  # Third: $overall
  for (name in names(cm$overall)) {
    all_names[i] <- name
    i <- i + 1
  }
  
  # Fourth: $byClass
  for (colname in colnames(cm$byClass)) {
    for (rowname in row.names(cm$byClass)) {
      rowname <- gsub("Class: ", "", rowname)
      all_names[i] <- paste0(colname, "_", rowname)
      i <- i + 1
    }
  }
  
  # Fifth: $mode
  all_names[i] <- "mode"
  
  all_names <- gsub(" ", "_", all_names)
  all_names <- tolower(all_names)

  ret <- unlist(cm)
  names(ret) <- all_names
  data.frame(ret, stringsAsFactors = FALSE)
  
}