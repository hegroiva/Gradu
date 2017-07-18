get_poetry_inds <- function(df, terms, exact=FALSE) {
  ret <- NA
  genre <- gsub("\\(", "", df$genre)
  genre <- gsub("\\)", "", genre)
  genre <- gsub("\\[", "", genre)
  genre <- gsub("\\]", "", genre)
  genre <- gsub("[.]", "", genre)
  genre <- tolower(genre)
  terms <- tolower(terms)
  for (term in terms) {
    term <- gsub("\\(", "", term)
    term <- gsub("\\)", "", term)
    term <- gsub("\\[", "", term)
    term <- gsub("\\]", "", term)
    
    if (exact) {
      to_grep <- term
    } else {
      to_grep <- paste0("(^|:::)", term, "(:::|$)")
    }
    ret <- union(grep(to_grep, genre, ignore.case=TRUE), ret)
  }
  ret <- ret[which(!is.na(ret))]
  ret
}