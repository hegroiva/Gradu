is_known_author <- function(author_names, poetry_authors, ignore_NA=TRUE) {
  
  ret <- rep(FALSE, length(author_names))
  poetry_authors <- unique(poetry_authors)
  ret[which(author_names %in% poetry_authors)] <- TRUE 
  if (ignore_NA) {
    ret[which(is.na(author_names))] <- FALSE
  }
  ret
  
}