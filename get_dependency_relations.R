library(stringr)
get_dependency_relations <- function(df, load=TRUE, outputfile=NA) {

  
  
  if (load) {
    dependency_list <- readRDS
  } else {
    dependency_list <- lapply(X = df$whole_title_sans_edition, FUN=function(x) {
      x_annotated <- annotateString(x, "obj")
      x_dependencies <- getDependency(x_annotated)
      x_root_index_in_sentence <- min(x_dependencies$depIndex[x_dependencies$type=="root" & x_dependencies$sentence==1])
      x_no_of_root <- length(which(x_dependencies$type=="root"))
      x_no_of_dependents <- length(which(x_dependencies$govIndex==x_root_index_in_sentence))
      x_no_of_sentences <- max(x_dependencies$sentence)
      
      x_token <- getToken(x_annotated)
      x_root_pos <- x_token$POS[x_root_index_in_sentence]
      #x_no_of_persons <- length(which(x_token$NER=="PERSON"))
      #x_no_of_locations <- length(which(x_token$NER=="LOCATION"))
      x_root_offset_characters <- x_token$CharacterOffsetBegin[x_root_index_in_sentence]
      x_no_of_inflected_words <- length(which(x_token$token != x_token$lemma))
      
      dd <- data.frame(root_of_index_in_sentence=x_root_index_in_sentence,
           no_of_root=x_no_of_root,
           no_of_dependents=x_no_of_dependents,
           no_of_sentences=x_no_of_sentences,
           root_pos=x_root_pos,
           #no_of_persons=x_no_of_persons,
           #no_of_locations=x_no_of_locations,
           root_offset_characters=x_root_offset_characters,
           x_no_of_inflected_words=x_no_of_inflected_words,
           stringsAsFactors = FALSE)
      dd
      })
  }
  column_names <- names(dependency_list[[1]])
  ret <- data.frame(matrix(unlist(dependency_list), nrow=nrow(df), byrow=TRUE), stringsAsFactors=FALSE)
  for (i in c(1:4,6:7)) {
    ret[,i] <- as.integer(ret[,i])
  }
  names(ret) <- column_names
  
  return(ret)
  
}