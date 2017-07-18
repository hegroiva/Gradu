library(stringr)

get_features <- function(df, 
                         clean_titles,
                         freq_words_p,
                         freq_words_non_p,
                         freq_words_all,
                         p50_words,
                         non_p50_words,
                         p_next100,
                         non_p_next100,
                         antique_names
                         ) {
  #message(paste0("freq_words_p: ", is.null(freq_words_p)))
  
  
  # Prepare the word lists, so that the words will be exact matches
  #freq_words_p <- paste0("(^| )", freq_words_p, "( |$)")
  #freq_words_non_p <- paste0("(^| )", freq_words_non_p, "( |$)")
  #freq_words_all <- paste0("(^| )", freq_words_all, "( |$)")
  #p50_words <- paste0("(^| )", p50_words, "( |$)")
  #non_p50_words <- paste0("(^| )", non_p50_words, "( |$)")
  #p_next100 <- paste0("(^| )", p_next100, "( |$)")
  #non_p_next100 <- paste0("(^| )", non_p_next100, "( |$)")
  #antique_names <- paste0("(^| )", antique_names, "( |$)")
  
  # Start preparing the features
  no_of_chars <- nchar(as.character(df$whole_title_sans_edition))
  no_of_words <- str_count(as.character(df$whole_title_sans_edition), " ") + 1
  no_of_verbs <- str_count(df$tagged, "/VB")
  no_of_interjections <- str_count(df$tagged, "/UH")
  no_of_adjectives <- str_count(df$tagged, "/JJ")
  no_of_adverbs <- str_count(df$tagged, "/RB")
  no_of_foreign_words <- str_count(df$tagged, "/RB")
  no_of_proper_nouns <- str_count(df$tagged, "/NNP")
  no_of_pronouns <- str_count(df$tagged, "/PRP")
  no_of_gerunds <- str_count(df$tagged, "/VBG")
  no_of_verbs_past <- str_count(df$tagged, "/VBD|/VBN")
  no_of_chars_title_only <- nchar(as.character(df$title))
  no_of_words_title_only <- str_count(as.character(df$title), " ") + 1
  len_words <- str_count(as.character(df$whole_title), " ") / nchar(as.character(df$whole_title_sans_edition))
  no_of_chars_remainder <- nchar(as.character(df$title_remainder))
  no_of_words_remainder <- str_count(as.character(df$title_remainder), " ") + 1
  #no_of_poetry_words <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, freq_words_p))}))
  #no_of_non_poetry_words <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, freq_words_non_p))}))
  #no_of_common_words <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, freq_words_all))}))
  #no_of_poetry_words_share50 <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, p50_words))}))
  #no_of_poetry_words_share100 <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, p_next100))}))
  #no_of_non_poetry_words_share50 <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, non_p50_words))}))
  #no_of_non_poetry_words_share100 <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, non_p_next100))}))
  #no_of_antique_names <- unlist(lapply(X = clean_titles, FUN = function(t) {sum(str_count(t, antique_names))}))
  
  
  no_of_question_marks <- str_count(as.character(df$whole_title_sans_edition), "[?]")
  no_of_exclamation_marks <- str_count(as.character(df$whole_title_sans_edition), "[!]")
  no_of_sentences <- str_count(as.character(df$whole_title_sans_edition), "[?!.]")
  no_of_commas <- str_count(as.character(df$whole_title_sans_edition), "[,]")
  no_of_poetry_words <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% freq_words_p))}))
  no_of_non_poetry_words <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% freq_words_non_p))}))
  no_of_common_words <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% freq_words_all))}))
  no_of_poetry_words_share50 <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% p50_words))}))
  no_of_poetry_words_share100 <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% p_next100))}))
  no_of_non_poetry_words_share50 <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% non_p50_words))}))
  no_of_non_poetry_words_share100 <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% non_p_next100))}))
  no_of_antique_names <- unlist(lapply(X = clean_titles, FUN = function(t) {
    length(which(unlist(str_split(t, " ")) %in% antique_names))}))
  
  
  author_age <- as.integer(df$publication_year_from) - as.integer(df$author_birth)
  pagecount <- df$pagecount
  physical_extent <- df$gatherings
  publication_year <- df$publication_year_from
  
  # Fix NAs: Which is a correct way to do this?
  author_age[which(is.na(author_age))] <- median.default(author_age, na.rm=TRUE)
  pagecount[which(is.na(pagecount))] <- median.default(pagecount, na.rm=TRUE)
  publication_year[which(is.na(publication_year))] <- median.default(publication_year, na.rm=TRUE)
  
  return (data.frame(no_of_chars=no_of_chars,
                     no_of_words=no_of_words,
                     no_of_verbs=no_of_verbs,
                     no_of_interjections=no_of_interjections,
                     no_of_adjectives=no_of_adjectives,
                     no_of_adverbs=no_of_adverbs,
                     no_of_foreign_words=no_of_foreign_words,
                     no_of_proper_nouns=no_of_proper_nouns,
                     no_of_pronouns=no_of_pronouns,
                     no_of_gerunds=no_of_gerunds,
                     no_of_verbs_past=no_of_verbs_past,
                     no_of_chars_title_only=no_of_chars_title_only,
                     no_of_words_title_only=no_of_words_title_only,
                     len_words=len_words,
                     no_of_chars_remainder=no_of_chars_remainder,
                     no_of_words_remainder=no_of_words_remainder,
                     no_of_question_marks=no_of_question_marks,
                     no_of_exclamation_marks=no_of_exclamation_marks,
                     no_of_sentences=no_of_sentences,
                     no_of_commas=no_of_commas,
                     no_of_poetry_words=no_of_poetry_words,
                     no_of_non_poetry_words=no_of_non_poetry_words,
                     no_of_common_words=no_of_common_words,
                     no_of_poetry_words_share50=no_of_poetry_words_share50,
                     no_of_non_poetry_words_share50=no_of_non_poetry_words_share50,
                     no_of_poetry_words_share100=no_of_poetry_words_share100,
                     no_of_non_poetry_words_share100=no_of_non_poetry_words_share100,
                     no_of_antique_names=no_of_antique_names,
                     author_age=author_age,
                     pagecount=pagecount,
                     physical_extent=physical_extent,
                     publication_year=publication_year
  ))
}
