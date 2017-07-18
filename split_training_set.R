split_training_set <- function(features, parts=5) {
  #no_inds <- nrow(df)
  no_inds <- nrow(features)
  inds_all <- 1:no_inds
  inds <- list()
  #ret <- list()
  feats <- list()
  for (i in 1:(parts-1)) {
    inds[[i]] <- sample(inds_all, size = ceiling(no_inds / parts))
    inds[[i]] <- inds[[i]][order(inds[[i]])]
    #ret[[i]] <- df[inds[[i]],]
    inds_all <- setdiff(inds_all, inds[[i]])
    feats[[i]] <- features[inds[[i]][order(inds[[i]])],]
  }
  inds[[parts]] <- inds_all
  #ret[[parts]] <- df[inds[[parts]],]
  feats[[parts]] <- features[inds[[parts]],]
  #names(ret) <- paste0("part", 1:parts)
  names(feats) <- paste0("features", 1:parts)
  #return(list(df=ret, features=feats))
  return(features=feats)
}
