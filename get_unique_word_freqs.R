
get_unique_word_freqs <- function(titles) {
  
  titles <- tolower(titles)
  titles <- str_extract_all(titles, "[A-Za-z]+")
  
  
  freqs <- list()
  # common_words <- get_frequencies(titles=unlist(titles), max_count=100)
  
  # get 
  tab_freq <- table(unlist(titles))
  tab_freq <- as.data.frame(tab_freq)
  names(tab_freq) <- c("word", "freq")
  tab_freq <- tab_freq[order(tab_freq$freq, decreasing = TRUE),]
  tab_freq <- tab_freq[which(nchar(as.character(tab_freq$word)) >= 3),]
  common_words <- as.character(head(tab_freq$word, 100))

  #table(unlist(str_split(tolower(df.estc_genres$whole_title_sans_edition, " ")))
  freqs <- lapply(X = common_words, FUN= function(t) {
    ptm <- proc.time()
    print(paste0("starting get_unique_word_freq for '", t, "' at ", date(), "."))
    
    mod <- paste0("(^| )", t, "( |$)")
    fr <- lapply(X = titles, FUN=function(title) {
      length(which(title==t))
    })
    fr <- as.data.frame(unlist(fr))
    savefile <- paste0(bu_path, "/word_freqs/", t, ".RDS", sep="")
    saveRDS(fr, savefile)
    unlist(fr)
  })
  freqs <- as.data.frame(freqs)
  names(freqs) <- paste0("common_", common_words)
  
  return(freqs)
}