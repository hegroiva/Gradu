library(tm)

get_frequencies <- function(titles, appearance_rate=0.05, max_count=NULL) {
  
  if (!is.null(max_count)) {
    #print(titles[1:3])
    titles <- gsub("([^[:lower:][:upper:] ])", "", titles)
    #print(titles[1:3])
    #print("-------")
    fr <- termFreq(as.character(titles))
    frequent_words <- names(findMostFreqTerms(fr, n = max_count))
  } else {
    dfCorpus <- Corpus(VectorSource(titles))
    lowerCorpus <- tm_map(dfCorpus, content_transformer(tolower))
    #stemmedCorpus <- tm_map(lowerCorpus, stemDocument)
    #sansStopwordsCorpus <- tm_map(stemmedCorpus, removeWords, stopwords("english"))
    sansStopwordsCorpus <- tm_map(lowerCorpus, removeWords, stopwords("english"))
    m <- DocumentTermMatrix(sansStopwordsCorpus)
    appearance_integer <- ceiling(length(titles) * appearance_rate)
    frequent_words <- findFreqTerms(m, appearance_integer) # Find words that appear more than 6000 times -> additional stopwords
  }
  return(frequent_words)
}