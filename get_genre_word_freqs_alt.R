get_genre_word_freqs_alt <- function(genre_titles, prefix, all_titles, exclude_titles=NULL, max_count=100, diff=3) {
  
  genre_titles <- tolower(genre_titles)
  genre_titles <- str_extract_all(genre_titles, "[A-Za-z]+")
  
  all_titles <- tolower(all_titles)
  all_titles <- str_extract_all(all_titles, "[A-Za-z]+")
  
  freqs <- list()
  
  # get 
  tab_freq <- table(unlist(genre_titles))
  tab_freq <- as.data.frame(tab_freq)
  names(tab_freq) <- c("word", "freq")
  total_include <- sum(tab_freq$freq)
  tab_freq <- tab_freq[order(tab_freq$freq, decreasing = TRUE),]
  tab_freq <- tab_freq[which(nchar(as.character(tab_freq$word)) >= 3),]
  common_words <- as.character(head(tab_freq$word, max_count * 5))
  
  
  if (!is.null(exclude_titles)) {
    exclude_titles <- tolower(exclude_titles)
    exclude_titles <- str_extract_all(exclude_titles, "[A-Za-z]+")
    
    tab_freq_exclude <- table(unlist(exclude_titles))
    tab_freq_exclude <- as.data.frame(tab_freq_exclude)
    names(tab_freq_exclude) <- c("word", "freq")
    total_exclude <- sum(tab_freq_exclude$freq)
    tab_freq_exclude <- tab_freq_exclude[order(tab_freq_exclude$freq, decreasing = TRUE),]
    tab_freq_exclude <- tab_freq_exclude[which(nchar(as.character(tab_freq_exclude$word)) >= 3),]
    exclude_words <- as.character(head(tab_freq_exclude$word, max_count * 5))
    
    
    freqs_exclude <- unlist(lapply(common_words, FUN=function(common_word) {
      ret <- tab_freq_exclude$freq[which(tab_freq_exclude$word==common_word)] / total_exclude
      if (length(ret) == 0) {ret <- 0}
      ret
      }))
    freqs_include <- unlist(lapply(common_words, FUN=function(common_word) {
      ret <- tab_freq$freq[which(tab_freq$word==common_word)] / total_include
      if (length(ret) == 0) {ret <- 0}
      ret
    }))
    
    common_words <- common_words[which((freqs_exclude * diff) < freqs_include)]
    
    if (length(common_words) > max_count) {
      common_words <- common_words[1:max_count]
    }
    
    
  }
  
  freqs <- lapply(X = common_words, FUN= function(t) {
    ptm <- proc.time()
    
    savefile <- paste0(bu_path, "/word_freqs/", prefix, "_20170531_", t, ".RDS", sep="")
    
    if (file.exists(savefile)) {
      print(paste0("  get_unique_word_freq: retrieving '", t, "' at ", date(), "."))
      fr <- readRDS(savefile)
    } else {
      print(paste0("get_unique_word_freq: counting freqs for '", t, "' at ", date(), "."))
      mod <- paste0("(^| )", t, "( |$)")
      fr <- lapply(X = all_titles, FUN=function(title) {
        length(which(title==t))
      })
      fr <- as.data.frame(unlist(fr))
    
      saveRDS(fr, savefile)
    }
    unlist(fr)
  })
  freqs <- as.data.frame(freqs)
  names(freqs) <- paste0(prefix, "_", common_words)
  
  return(freqs)
}