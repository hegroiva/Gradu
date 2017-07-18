aggregate_confusion_matrix <- function(cm_list) {

  aggregated <- mapply(cm_list, FUN = function(cm) {
    data.frame(
      FALSEFALSE = ave(unname(unlist(cm[2])[1])),
      FALSETRUE = ave(unname(unlist(cm[2])[2])),
      TRUEFALSE = ave(unname(unlist(cm[2])[3])),
      TRUETRUE = ave(unname(unlist(cm[2])[4])),
      
      accuracy = ave(unname(unlist(cm[3])[1])),
      Kappa = ave(unname(unlist(cm[3])[2])),
      accuracyLower = ave(unname(unlist(cm[3])[3])),
      accuracyUpper = ave(unname(unlist(cm[3])[4])),
      accuracyNull = ave(unname(unlist(cm[3])[5])),
      accuracyPValue = ave(unname(unlist(cm[3])[6])),
      accuracyMcnemarPValue = ave(unname(unlist(cm[3])[7])),
      
      sensitivity = ave(unname(unlist(cm[4])[1])),
      specificity = ave(unname(unlist(cm[4])[2])),
      pos_pred_value = ave(unname(unlist(cm[4])[3])),
      neg_pred_value = ave(unname(unlist(cm[4])[4])),
      precision = ave(unname(unlist(cm[4])[5])),
      recall = ave(unname(unlist(cm[4])[6])),
      F1 = ave(unname(unlist(cm[4])[7])),
      prevalence = ave(unname(unlist(cm[4])[8])),
      detection_rate = ave(unname(unlist(cm[4])[9])),
      detection_prevalence = ave(unname(unlist(cm[4])[10])),
      balanced_accuracy = ave(unname(unlist(cm[4])[11]))
    )
  })
  # Calculate means. There's probably a neat way to this, but it remains a mystery to me.
  means <- list()
  for (i in 1:nrow(aggregated)) {
    if (i <= 4) {
      means[[i]] <- round(mean(unlist(aggregated[i,])))
    } else {
      means[[i]] <- as.numeric(mean(unlist(aggregated[i,])))
    }
  }
  aggregated <- cbind(aggregated, total=means)
  
  return (aggregated)
}