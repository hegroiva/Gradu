get_topic_features <- function(df) {
  
  all_topics <- df$topic
  all_topics[which(all_topics=="")] <- df$topic_sub_form[which(all_topics=="")]
  all_topics[which(all_topics=="")] <- df$topic_uniform_sub_form[which(all_topics=="")]
  all_topics[which(all_topics=="")] <- df$topic_corporate_sub_form[which(all_topics=="")]
  all_topics[which(all_topics=="")] <- df$topic_person_sub_form[which(all_topics=="")]
  
  all_topics <- str_split(all_topics, pattern=":::")
  
  feats <- get_genre_word_freqs_alt(genre_titles=all_topics[which(df$is_poetry=="TRUE")] , 
                           prefix="topics", 
                           all_titles=all_topics,
                           max_count <- 100,
                           use_phrases = TRUE)
  feats$is_poetry <- df$is_poetry
  feats
}