library(data.table)

prepare_for_randomforest <- function(df) {
  titles <- df$whole_title_sans_edition
  freq <- get_frequencies(titles)
  df$tagged <- get_POS_tags(titles=titles, 
                            filename=paste0(bu_path, "/Titles/tagged_titles3.RDS"), 
                            load=TRUE)  
  POS_trigram_features <- get_POS_trigrams(df$tagged, no_of_levels=50)
  most_common_word_features <- get_unique_word_freqs(df$whole_title_sans_edition)
  saveRDS(most_common_word_features, paste0(bu_path, "/most_common_word_features.RDS"))  
  
  
  titles_only <- df$title
  #title_only_inds <- which(df$title_remainder !="" & !is.na(df$title_remainder) & df$title != "" & !is.na(df.title))
  
  df$tagged_title_only <- get_POS_tags(titles=titles_only, 
                                       filename=paste0(bu_path, "/Titles/tagged_titles_only_RERUN.RDS"),
                                       load=FALSE) 
  POS_trigram_features_title_only <- get_POS_trigrams(df$tagged_title_only, no_of_levels=50)
  # Then the same for poetry and non-poetry
  poetry_terms <- read.csv2(file=paste0(bu_path, "/poetry_genres.txt"), 
                            encoding = "UTF-8", 
                            header = FALSE,
                            stringsAsFactors = FALSE)[,1]
  non_poetry_terms <- read.csv2(file=paste0(bu_path, "/non_poetry_genres.txt"), 
                                encoding = "UTF-8", 
                                header = FALSE,
                                stringsAsFactors = FALSE)[,1]
  antique_names <- read.csv2(file=paste0(bu_path, "/metamorphoses_in_capitals.txt"), 
                             encoding="UTF-8",
                             header=FALSE,
                             stringsAsFactors = FALSE, 
                             quote = "")[,1]
  antique_names <- tolower(antique_names)
  poetry_inds <- get_poetry_inds(df=df, terms=poetry_terms, exact=FALSE)
  non_poetry_inds <- get_poetry_inds(df, non_poetry_terms, exact=TRUE)
  
  #poetry_titles <- df.english_genres$whole_title_sans_edition[which(as.character(df.english_extra$genre) %in% unlist(unname(poetry_terms)))]
  #non_poetry_titles <- df.english_genres$whole_title_sans_edition[which(as.character(df.english_extra$genre) %in% unlist(unname(non_poetry_terms)))]
  poetry_titles <- df$whole_title_sans_edition[poetry_inds]
  non_poetry_titles <- df$whole_title_sans_edition[non_poetry_inds]
  
  #freq_words_all <- get_frequencies(df$whole_titles_sans_edition, appearance_rate=0.05)
  #freq_words_all2 <- get_frequencies(df$whole_titles_sans_edition, appearance_rate=0.05, max_count = 50)
  #print(is.null(freq_words_all))
  #print(is.null(freq_words_all2))
  #print(is.null(freq))
  #return()
  freq_words_poetry <- get_frequencies(poetry_titles, max_count=50)
  freq_words_non_poetry <- get_frequencies(non_poetry_titles, max_count=50)
  freq_words_p <- freq_words_poetry[which(freq_words_poetry %in% freq_words_non_poetry == FALSE)]
  
  freq_words_p <- freq_words_p[which(freq_words_p %in% stopwords("english") == FALSE)]
  
  freq_words_non_p <- freq_words_non_poetry[which(freq_words_non_poetry %in% freq_words_poetry == FALSE)]
  freq_words_non_p <- freq_words_non_p[which(freq_words_non_p %in% stopwords("english") == FALSE)]
  
  clean_titles <- gsub("([^[:lower:][:upper:] ])", "", titles)
  fr_all <- termFreq(as.character(clean_titles))
  clean_titles_poetry <- gsub("([^[:lower:][:upper:] ])", "", poetry_titles)
  fr_poetry <- termFreq(as.character(clean_titles_poetry))
  clean_titles_non_poetry <- gsub("([^[:lower:][:upper:] ])", "", non_poetry_titles)
  fr_non_poetry <- termFreq(as.character(clean_titles_non_poetry))
  
  df.comp <- data.frame(word=names(fr_all), stringsAsFactors = FALSE)
  df.comp$freq_all <- unname(fr_all)
  df.poetry <- data.frame(word=names(fr_poetry), stringsAsFactors = FALSE)
  df.poetry$freq_poetry <- unname(fr_poetry)
  df.non_poetry <- data.frame(word=names(fr_non_poetry), stringsAsFactors = FALSE)
  df.non_poetry$freq_non_poetry <- unname(fr_non_poetry)
  #df.comp <- df.comp[which(df.comp$freq_all >= 10),]
  #df.poetry <- df.comp[which(df.poetry$freq_poetry >= 10),]
  #df.non_poetry <- df.comp[which(df.non_poetry$freq_non_poetry >= 10),]
  df.comp <- merge(df.comp, df.poetry, df.x="word", df.y="word", all=TRUE)
  df.comp <- merge(df.comp, df.non_poetry, df.x="word", df.y="word", all=TRUE)
  df.comp <- df.comp[which(df.comp$freq_all >= 100),]
  df.comp$poetry_share <- df.comp$freq_poetry / df.comp$freq_all
  df.comp$non_poetry_share <- df.comp$freq_non_poetry / df.comp$freq_all
  
  df.table <- data.table(df.comp[which(!is.na(df.comp$poetry_share)),], key="poetry_share")
  p50_words <- tail(df.table[, tail(.SD, 50), by=poetry_share]$word, 50)
  p50_words <- p50_words[which(p50_words %in% freq_words_p == FALSE)]
  
  p_next100 <- tail(df.table[, tail(.SD, 150), by=poetry_share]$word, 150)
  p_next100 <- p_next100[which(p_next100 %in% freq_words_p == FALSE)]
  p_next100 <- p_next100[which(p_next100 %in% p50_words == FALSE)]
  
  df.table <- data.table(df.comp[which(!is.na(df.comp$non_poetry_share)),], key="non_poetry_share")
  non_p50_words <- tail(df.table[, tail(.SD, 50), by=non_poetry_share]$word, 50)
  non_p50_words <- non_p50_words[which(non_p50_words %in% freq_words_non_p == FALSE)]
  
  non_p_next100 <- tail(df.table[, tail(.SD, 150), by=non_poetry_share]$word, 150)
  non_p_next100 <- non_p_next100[which(non_p_next100 %in% freq_words_non_p == FALSE)]
  non_p_next100 <- non_p_next100[which(non_p_next100 %in% non_p50_words == FALSE)]
  
  
  author_age <- as.integer(df$publication_year_from) - as.integer(df$author_birth)
  
  
  # + top 10 publication place
  # Mostly London! IGNORE!
  
  # + top 10 publisher
  # Not cleaned thoroughly and the most common ones are just a fraction. IGNORE!
  
  # + is_postume
  # Half of values missing! IGNORE!
  
  # + top 10 author name
  # Most common names are too infrequent! IGNORE!
  
  # + other word lists ???
  
  # + subject (poetry subjects?)
  
  # + repeated stems
  
  # + publication decades / centuries (is linear regression ok? maybe 
  
  # + n most common Nouns
  
  # + amount of <POS tag> / no_of_words
  
  # + singular nouns / plural nouns
  
  # + digit counts
  
  # Missing values must first be imputed: randomForest::rfImpute()
  
  
  # get_features for the training set
  features <- get_features(df=df, 
                           clean_titles=clean_titles, 
                           freq_words_p=freq_words_p, 
                           freq_words_non_p=freq_words_non_p, 
                           freq_words_all=freq, 
                           p50_words=p50_words, 
                           non_p50_words=non_p50_words, 
                           p_next100=p_next100, 
                           non_p_next100=non_p_next100,
                           antique_names=antique_names
  )
  
  # Prepare the response variable
  is_poetry <- rep("FALSE", nrow(df))
  is_poetry[poetry_inds] <- "TRUE"
  #is_poetry[which(as.character(df.genres.training$genre) %in% unlist(unname(non_poetry_terms)))] <- "FALSE"
  is_poetry <- as.factor(is_poetry)
  
  
  # Selecting features
  return (list(features=features,
               is_poetry=is_poetry,
               df=df))
  
}