
# This code is borrowed from:
# http://www.martinschweinberger.de/blog/pos-tagging-with-r/


# Install  packages  we need or which  may be  useful
# (to  activate  just  delete  the #)

#install.packages ("openNLPmodels.en", repos = "http://datacube.wu.ac.at/", type = "source")
#install.packages ("openNLP")
#install.packages ("NLP")

### additional  packages
#install.packages ("tm")
#install.packages ("stringr")
#install.packages ("gsubfn")
#install.packages ("plyr")
# to  install  openNLPmodels , please  download  an  install: the  packages/models  directly  from http://datacube.wu.ac.at/.

# To  install  these  packages/models , simply  enter
# install.packages ("foo", repos = "http :// datacube.wu.ac.at/", type = "source ")
# into  your R console. E.g. enter:
#install.packages ("openNLPmodels.en", repos = "http://datacube.wu.ac.at/", type = "source")
# to  install  the  file "openNLPmodels.en_1.5-1.tar.gz"



# activate  packages
library(NLP)
library(openNLP)
library(openNLPmodels.en)
library(tm)
library(stringr)
library(gsubfn)
library(plyr)







# specify  path of  corpus
#pathname  <- "C:\\03 - MyProjects \\ PosTagging \\ TestCorpus"
#pathname <- "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\Titles\\"
# choose  files
#corpus.files = list.files(path = pathname, 
#                          pattern = NULL,
#                          all.files = T, 
#                          full.names = T, 
#                          recursive = T,
#                          ignore.case = T, 
#                          include.dirs = T)

# load  and  unlist  corpus
#corpus.tmp  <- lapply(corpus.files , function(x) {
#  scan(x, what = "char", sep = "\t", quiet = T, quote=NULL) 
#  })
# Paste  all  elements  of the  corpus  together
#corpus.tmp  <- lapply(corpus.tmp , function(x){
#  x <- paste(x, collapse = " ")
#  })
# Clean  corpus
#corpus.tmp  <- lapply(corpus.tmp , function(x) {
#  x <- enc2utf8(x) 
#  })
#corpus.tmp  <- gsub(" {2,}", " ", corpus.tmp)
# remove  spaces  at  beginning  and end of  strings
#corpus.tmp  <- str_trim(corpus.tmp , side = "both")
# convert  corpus  files  into  strings
#Corpus  <- lapply(corpus.tmp , function(x){
#  x <- as.String(x) 
#  })






# apply annotators to Corpus
#Corpus.tagged  <- lapply(Corpus , function(x){
#  sent_token_annotator  <- Maxent_Sent_Token_Annotator()
#  word_token_annotator  <- Maxent_Word_Token_Annotator()
#  pos_tag_annotator  <- Maxent_POS_Tag_Annotator()
#  y1 <- annotate(x, list(sent_token_annotator, word_token_annotator))
#  y2 <- annotate(x, pos_tag_annotator , y1)
#  # y3 <- annotate(x, Maxent_POS_Tag_Annotator(probs = TRUE), y1)
#  y2w  <- subset(y2 , type == "word")
#  tags  <- sapply(y2w$features , "[[", "POS")
#  r1 <- sprintf("%s/%s", x[y2w], tags)
#  r2 <- paste(r1 , collapse = " ")
#  return(r2)
#  })





# inspect  results
#Corpus.tagged






POStag  <- function(path = path){
  require("NLP")
  require("openNLP")
  require("openNLPmodels.en")
  corpus.files = list.files(path = path, 
                            pattern = NULL, 
                            all.files = T, 
                            full.names = T, 
                            recursive = T, 
                            ignore.case = T, 
                            include.dirs = T)
  corpus.tmp  <- lapply(corpus.files , function(x) {
    scan(x, what = "char", sep = "\t", quiet = T, quote=NULL)
    })
  corpus.tmp  <- lapply(corpus.tmp , function(x){
    x <- paste(x, collapse = " ") 
    })
  corpus.tmp  <- lapply(corpus.tmp , function(x) {
    x <- enc2utf8(x)
    })
  corpus.tmp  <- gsub(" {2,}", " ", corpus.tmp)
  corpus.tmp  <- str_trim(corpus.tmp, side = "both")
  Corpus  <- lapply(corpus.tmp , function(x){
    x <- as.String(x) 
    })
  sent_token_annotator  <- Maxent_Sent_Token_Annotator()
  word_token_annotator  <- Maxent_Word_Token_Annotator()
  pos_tag_annotator  <- Maxent_POS_Tag_Annotator()
  lapply(Corpus , function(x){
    y1 <- annotate(x, list(sent_token_annotator, word_token_annotator))
    y2 <- annotate(x, pos_tag_annotator, y1)
    # y3 <- annotate(x, Maxent_POS_Tag_Annotator(probs = TRUE), y1)
    y2w  <- subset(y2 , type == "word")
    tags  <- sapply(y2w$features , "[[", "POS")
    r1 <- sprintf("%s/%s", x[y2w], tags)
    r2 <- paste(r1 , collapse = " ")
    return(r2) 
  })
}


POStag_sentence <- function(sentence) {
  
  corpus.tmp  <- lapply(sentence , function(x) {
    x <- enc2utf8(x)
  })
  corpus.tmp  <- gsub(" {2,}", " ", corpus.tmp)
  corpus.tmp  <- str_trim(corpus.tmp, side = "both")
  Corpus  <- lapply(corpus.tmp , function(x){
    x <- as.String(x) 
  })
  sent_token_annotator  <- Maxent_Sent_Token_Annotator()
  word_token_annotator  <- Maxent_Word_Token_Annotator()
  pos_tag_annotator  <- Maxent_POS_Tag_Annotator()
  lapply(Corpus , function(x){
    if (x == "") {return(x)}
    y1 <- annotate(x, list(sent_token_annotator, word_token_annotator))
    y2 <- annotate(x, pos_tag_annotator, y1)
    # y3 <- annotate(x, Maxent_POS_Tag_Annotator(probs = TRUE), y1)
    y2w  <- subset(y2 , type == "word")
    tags  <- sapply(y2w$features , "[[", "POS")
    r1 <- sprintf("%s/%s", x[y2w], tags)
    r2 <- paste(r1 , collapse = " ")
    return(r2) 
  })
}




# test  the  function
#POStag(path = "C:\\03- MyProjects \\ PosTagging \\ TestCorpus")
#tagged <- POStag(path="C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\Titles")
#POStag_sentence("Hege is in a stupid state.")


