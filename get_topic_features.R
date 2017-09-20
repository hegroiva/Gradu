get_topic_features <- function(df, max_count=100, prefix="topics") {
  
  all_topics <- df$topic
  all_topics[which(all_topics=="")] <- df$topic_sub_form[which(all_topics=="")]
  all_topics[which(all_topics=="")] <- df$topic_uniform_sub_form[which(all_topics=="")]
  all_topics[which(all_topics=="")] <- df$topic_corporate_sub_form[which(all_topics=="")]
  all_topics[which(all_topics=="")] <- df$topic_person_sub_form[which(all_topics=="")]
  
  all_topics <- str_split(all_topics, pattern=":::")
  
  feats <- get_genre_word_freqs_alt(genre_titles=all_topics[which(df$is_poetry=="TRUE")], 
                                    exclude_titles=all_topics[which(df$is_poetry=="FALSE")], 
                                    prefix=prefix, 
                                    all_titles=all_topics,
                                    max_count=max_count,
                                    use_phrases = TRUE)
  feats$is_poetry <- df$is_poetry
  feats
}