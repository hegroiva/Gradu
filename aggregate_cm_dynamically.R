aggregate_cm_dynamically <- function(cm_list) {
  
  aggregated <- cm_list[[1]]
  for (i in 2:length(cm_list)) {
    aggregated <- cbind(aggregated, cm_list[[i]])
  }
  means <- list()
  
  options(warn=-1)
  for (i in 1:nrow(aggregated)) {
    if (any(is.na(as.numeric(aggregated[i,])))) {
      means[[i]] <- "NA"
    } else if (all(as.numeric(aggregated[i,])%%1==0)) {
      means[[i]] <- round(mean(unlist(as.numeric(aggregated[i,]))))
    } else {
      means[[i]] <- as.numeric(mean(unlist(as.numeric(aggregated[i,]))))
    }
  }
  aggregated <- cbind(aggregated, total=unlist(means))
  
  options(warn=0)
  return (aggregated)
}