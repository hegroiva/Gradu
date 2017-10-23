calculate_multiclassifiers <- function(all_value_names, all_values, good_names) {
  
  A <- 0
  B <- 0
  C <- 0
  D <- 0
  
  goodnames <- paste0("(", good_names, ")")
  goodnames <- str_c(goodnames, collapse="|")
  goodnames <- paste0("(", goodnames, ")")
  
  # Get the correct A-D
  for (i in 1:length(all_value_names)) {
    if (length(grep(paste0(goodnames, "_as_", goodnames), all_value_names[i]) > 0)) {
      A <- A + all_values[i]
    } else if (length(grep(paste0(goodnames, "_as_"), all_value_names[i]) > 0)) {
      C <- C + all_values[i]
    } else if (length(grep(paste0("_as_", goodnames), all_value_names[i]) > 0)) {
      B <- B + all_values[i]
    } else {
      D <- D + all_values[i]
    }
  }
  
  # RECALL
  recall <- A / (A + C)
  
  # PRECISION
  precision <- A / (A + B)
  
  # SPECIFICITY
  specificity <- D / (B + D)
  
  # SENSITIVITY
  sensitivity <- recall
  
  # F1
  F1 <- (2 * precision * recall) / (precision + recall)
  
  # BALANCED ACCURACY
  balanced_accuracy <- (sensitivity + specificity) / 2
  ret <- data.frame(precision=precision, recall=recall, specificity=specificity, F1=F1, balanced_accuracy=balanced_accuracy)
  ret
}

