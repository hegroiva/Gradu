get_files_in_folder <- function(filepath, pattern, files=NULL) {
  if (is.null(files)) {
    files <- list.files(path=filepath, pattern=pattern, full.names = TRUE)
    filenames <- list.files(path=filepath, pattern=pattern, full.names = FALSE)
  } else {
    filenames <- files
    files <- paste0(filepath, "/", files)
  }
  
  return(filepaths=files, filenames=filenames)
}