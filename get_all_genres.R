get_all_genres <- function(genres) {
  genres <- unique(unlist(str_split(genres, ":::")))
  genres <- gsub("[.]$", "", genres)
  poetry_terms <- read.csv2(file="C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\poetry_genres.txt", 
                            encoding = "UTF-8", 
                            header = FALSE,
                            stringsAsFactors = FALSE)[,1]
  non_poetry_terms <- read.csv2(file="C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\non_poetry_genres.txt", 
                                encoding = "UTF-8", 
                                header = FALSE,
                                stringsAsFactors = FALSE)[,1]
  
  poetry_terms <- tolower(poetry_terms)
  non_poetry_terms <- tolower(non_poetry_terms)
  i = 1
  inds <- rep(FALSE, length(genres))
  for (genre in tolower(genres)) {
    if (!(genre %in% poetry_terms)) {
      if (!(genre %in% non_poetry_terms)) {
        inds[i] <- TRUE
      }
    }
    i <- i + 1
  }
  print(inds[1:20])
  print(genres[1:20])
  write.csv2(genres[which(inds==TRUE)],file = "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\new_genres.txt", fileEncoding = "UTF-8",
             row.names =FALSE,
             quote=FALSE
            )
  
}