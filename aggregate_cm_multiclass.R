aggregate_cm_multiclass <- function(filepath, pattern, files=NULL) {
  
  if (is.null(files)) {
    files <- list.files(path=filepath, pattern=pattern, full.names = TRUE)
    filenames <- list.files(path=filepath, pattern=pattern, full.names = FALSE)
  } else {
    filenames <- files
    files <- paste0(filepath, "/", files)
  }

  all_values <- 0
  for (file in files) {
    cm <- read.delim2(file=file,sep="", header=FALSE, colClasses = c("character", NULL))
    all_names <- cm[grep("_as_", cm[,1]), 1]
    for (column in 2:length(cm)) {
      all_values <- (all_values + as.integer(cm[grep("_as_", cm[,1]), column]))
    }
  }
  
 data.frame(all_names=all_names, all_values=all_values) 

}