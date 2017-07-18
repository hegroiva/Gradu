get_tags_only <- function(tagged_texts, ignore_punctuation=FALSE) {
  tags_only <- str_extract_all(string = tagged_texts, pattern = "/([^ ]+)")
  tags_only <- lapply(tags_only, FUN=function(x) {ret <- paste0(x, collapse=" "); ret})
  tags_only <- gsub("/", "", tags_only)
  tags_only <- gsub("[.] [.]", ".", tags_only)
  if (ignore_punctuation) {
    tags_only <- str_extract_all(str = tagged_texts, pattern = "[A-Z]+")
    tags_only <- lapply(tags_only, FUN=function(x) {ret <- paste0(x, collapse=" "); ret})
  }
  tags_only <- gsub(" ([A-Z][a-z]+)+", " ", tags_only)
  return(tags_only)
}