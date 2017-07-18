#install.packages("tagged")
#library(tagged)

get_POS_trigrams <- function(tagged_titles, no_of_levels=50) {
  
  # Get tags only
  tags_only <- str_extract_all(tagged_titles, "/[A-z.,:!?;]{1,3}")
  tags_only <- lapply(X = tags_only, FUN = function(t) {str_c(t, "", collapse=" ")})
  
  # Remove tailing period, as it has come from concatenation of fields
  tags_only <- gsub("(/[.,!?:;]) /[.]", "\\1", tags_only)
  tags_only <- gsub("/", "", tags_only)
  
  split_tags <- strsplit(tags_only, " ", fixed = TRUE)
  
  
  gram.counts <- c()
  heads <- list()

  # First tags with separators
  grams_sep <- list()
  for (i in 1:5) {
    grams_sep[[i]] <- lapply(X=split_tags, FUN=function(t) {paste(t[1:i], collapse=" ")})
    gram.counts[[i]] <- as.data.frame(xtabs(~unlist(grams_sep[[i]])))
    heads[[i]] <- head(gram.counts[[i]][[1]][order(gram.counts[[i]]$Freq, decreasing=TRUE)], no_of_levels)
    heads[[i]] <- droplevels(heads[[i]])
    grams_sep[[i]] <- lapply(grams_sep[[i]], FUN=function(t) {if (!(t %in% heads[[i]])) {paste("POS_", i, "_OTHER", sep="")} else {t}})
    grams_sep[[i]] <- unlist(grams_sep[[i]])
  }
  
  
  # Last tags with separators
  last_grams_sep <- list()
  for (i in 1:5) {
    last_grams_sep[[i]] <- lapply(X=split_tags, FUN=function(t) {paste(t[1:i], collapse=" ")})
    gram.counts[[i]] <- as.data.frame(xtabs(~unlist(last_grams_sep[[i]])))
    heads[[i]] <- head(gram.counts[[i]][[1]][order(gram.counts[[i]]$Freq, decreasing=TRUE)], no_of_levels)
    heads[[i]] <- droplevels(heads[[i]])
    last_grams_sep[[i]] <- lapply(last_grams_sep[[i]], FUN=function(t) {if (!(t %in% heads[[i]])) {paste("POS_", i, "_OTHER", sep="")} else {t}})
    last_grams_sep[[i]] <- unlist(last_grams_sep[[i]])
  }
  
  # First tags without separators
  tags_only <- gsub("[.:,!?;]", "", tags_only)
  split_tags <- strsplit(tags_only, " ", fixed = TRUE)
  grams <- list()
  for (i in 1:5) {
    grams[[i]] <- lapply(X=split_tags, FUN=function(t) {paste(t[1:i], collapse=" ")})
    gram.counts[[i]] <- as.data.frame(xtabs(~unlist(grams[[i]])))
    heads[[i]] <- head(gram.counts[[i]][[1]][order(gram.counts[[i]]$Freq, decreasing=TRUE)], no_of_levels)
    heads[[i]] <- droplevels(heads[[i]])
    grams[[i]] <- lapply(grams[[i]], FUN=function(t) {if (!(t %in% heads[[i]])) {paste("POS_", i, "_OTHER", sep="")} else {t}})
    grams[[i]] <- unlist(grams[[i]])
  }
  
  # Last tags without separators
  last_grams <- list()
  for (i in 1:5) {
    last_grams[[i]] <- lapply(X=split_tags, FUN=function(t) {paste(t[1:i], collapse=" ")})
    gram.counts[[i]] <- as.data.frame(xtabs(~unlist(last_grams[[i]])))
    heads[[i]] <- head(gram.counts[[i]][[1]][order(gram.counts[[i]]$Freq, decreasing=TRUE)], no_of_levels)
    heads[[i]] <- droplevels(heads[[i]])
    last_grams[[i]] <- lapply(last_grams[[i]], FUN=function(t) {if (!(t %in% heads[[i]])) {paste("POS_", i, "_OTHER", sep="")} else {t}})
    last_grams[[i]] <- unlist(last_grams[[i]])
  }
  
  return(data.frame(first_1=grams[[1]], first_2=grams[[2]], first_3=grams[[3]], first_4=grams[[4]], first_5=grams[[5]],
             last_1=last_grams[[1]], last_2=last_grams[[2]], last_3=last_grams[[3]], last_4=last_grams[[4]], last_5=last_grams[[5]],
             first_1_sep=grams_sep[[1]], first_2_sep=grams_sep[[2]], first_3_sep=grams_sep[[3]], first_4_sep=grams_sep[[4]], first_5_sep=grams_sep[[5]],
             last_1_sep=last_grams_sep[[1]], last_2_sep=last_grams_sep[[2]], last_3_sep=last_grams_sep[[3]], last_4_sep=last_grams_sep[[4]], last_5_sep=last_grams_sep[[5]]
             )
  )
  # Last tags
  #trigrams = lapply(X = split_tags, FUN= function(t) {
  #  trigrams <- vapply(ngrams(t, 3), paste, "", collapse = " ")
  #  trigram.counts = as.data.frame(xtabs(~trigrams))
  #  trigrams[1]
  #  trigrams[length(trigrams)]
  #})
  #head(trigram.counts[order(trigram.counts$Freq, decreasing = T),])
  
  #return (tags_only)
  
  
}
