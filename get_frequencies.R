library(tm)

get_frequencies <- function(titles, appearance_rate=0.05, max_count=NULL) {
  
  if (!is.null(max_count)) {
    #print(titles[1:3])
    titles <- gsub("([^[:lower:][:upper:] ])", "", titles)
    #print(titles[1:3])
    #print("-------")
    print(paste0("Starting termFreq at ", date()))
    fr <- termFreq(as.character(titles))
    print(fr)
    return(fr)
    print(paste0("Starting findMostFreqTerms at ", date()))
    frequent_words <- names(findMostFreqTerms(fr, n = max_count))
  } else {
    print(paste0("Starting to fill Corpus at ", date()))
    dfCorpus <- Corpus(VectorSource(titles))
    print(paste0("Starting to lowerCorpus at ", date()))
    lowerCorpus <- tm_map(dfCorpus, content_transformer(tolower))
    #stemmedCorpus <- tm_map(lowerCorpus, stemDocument)
    #sansStopwordsCorpus <- tm_map(stemmedCorpus, removeWords, stopwords("english"))
    print(paste0("Starting to removeStopwords at ", date()))
    sansStopwordsCorpus <- tm_map(lowerCorpus, removeWords, stopwords("english"))
    print(paste0("Starting to Matricize corpus at ", date()))
    m <- DocumentTermMatrix(sansStopwordsCorpus)
    appearance_integer <- ceiling(length(titles) * appearance_rate)
    print(paste0("Starting to findFreqterm at ", date()))
    frequent_words <- findFreqTerms(m, appearance_integer) # Find words that appear more than 6000 times -> additional stopwords
  }
  return(frequent_words)
}