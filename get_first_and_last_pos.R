get_first_and_last_pos <- function(pos_tags, minvalue=2, maxvalue=5, offset, is_poetry) {
  
  for (i in minvalue:maxvalue) {
    # FIRST: START NGRAMS
    pattern <- paste0("^(([A-Z]+)( |$)){", i, "}")
    ngrams_start <- str_extract_all(pos_tags, pattern, simplify = TRUE)
    ngrams_start <- str_trim(ngrams_start, side = "both")
    
    start_table <- table(ngrams_start)
    start_table <- start_table[which(start_table>=offset)]
    
    feats <- lapply(names(start_table), FUN=function(x) {
      feat <- str_detect(pos_tags, paste0("^", x))
      feat[which(feat==FALSE)] <- 0
      feat[which(feat==TRUE)] <- 1
      feat
    })
    df_feats <- as.data.frame(feats, col.names=str_replace(names(start_table), " ", "_"))
    feats$is_poetry <- is_poetry
    
    saveRDS(feats, paste0(bu_path, "/feats_start", i, ".RDS"))
    
    
    # REPEAT FOR THE END NGRAMS
    pattern <- paste0("((^| )([A-Z]+)){", i, "}$")
    ngrams_end <- str_extract_all(pos_tags, pattern, simplify = TRUE)
    ngrams_end <- str_trim(ngrams_end, side = "both")
    
    end_table <- table(ngrams_end)
    end_table <- end_table[which(end_table>=offset)]
    
    feats <- lapply(names(end_table), FUN=function(x) {
      feat <- str_detect(pos_tags, paste0(x, "$"))
      feat[which(feat==FALSE)] <- 0
      feat[which(feat==TRUE)] <- 1
      feat
    })
    df_feats <- as.data.frame(feats, col.names=str_replace(names(end_table), " ", "_"))
    feats$is_poetry <- is_poetry
    
    saveRDS(feats, paste0(bu_path, "/feats_end", i, ".RDS"))
  }
  

}
