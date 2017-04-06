get_subset <- function(language) {
  
  df.tmp <- df.estc_genres[which(df.estc_genres$language==language),]
  df.tmp_genres <- df.tmp[which(df.tmp$genre!= ""),]
  df.tmp_no_genres <- df.tmp[which(df.tmp$genre== ""),]
  df.tmp.genres <- as.character(df.tmp$genre)
  df.tmp.genres[which(df.tmp.genres=="")] <- as.character(df.tmp$topic_person_sub_form[which(df.tmp.genres=="")])
  df.tmp.genres[which(df.tmp.genres=="")] <- as.character(df.tmp$topic_sub_form[which(df.tmp.genres=="")])
  df.tmp.genres[which(df.tmp.genres=="")] <- as.character(df.tmp$topic_corporate_sub_form[which(df.tmp.genres=="")])
  df.tmp.genres[which(df.tmp.genres=="")] <- as.character(df.tmp$topic_uniform_sub_form[which(df.tmp.genres=="")])
  
  inds_tmp_genres <- union(which(df.tmp$genre!= ""), which(df.tmp.genres!=""))
  df.tmp_extra_genres <- data.frame(author_name=df.tmp$author_name[inds_tmp_genres],
                                    whole_title=df.tmp$whole_title[inds_tmp_genres],
                                    genre=df.tmp.genres[inds_tmp_genres])
  rm(inds_tmp_genres)
  rm(df.tmp.genres)
  
  ret <- data.frame(language=language, 
                    records=nrow(df.tmp),
                    genres_annotated=nrow(df.tmp_genres),
                    genres_not_annotated=nrow(df.tmp_no_genres),
                    extra_genres=nrow(df.tmp_extra_genres),
                    extra_records=nrow(df.tmp_extra_genres) - nrow(df.tmp_genres),
                    language_percentage=percent(nrow(df.tmp) / nrow(df.estc_genres), digits = 1),
                    annotated_percentage=percent(nrow(df.tmp_genres) / nrow(df.estc_genres),digits = 1),
                    extra_percentage=percent(nrow(df.tmp_extra_genres) / nrow(df.estc_genres),digits = 1),
                    annotated_percentage_language=percent(nrow(df.tmp_genres) / nrow(df.tmp), digits = 1),
                    extra_percentage_language=percent(nrow(df.tmp_extra_genres) / nrow(df.tmp), digits = 1),
                    unique_genres=length(unique(df.tmp$genre)),
                    unique_extra_genres=length(unique(df.tmp_extra_genres$genre)),
                    added_genres=length(unique(df.tmp_extra_genres$genre)) - length(unique(df.tmp$genre))
  )
  print(ret)
  return(list(df.genres=df.tmp_genres, df.extra=df.tmp_extra_genres, stats=ret))
}
