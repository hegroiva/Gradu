
library(devtools)
library(ggplot2)
library(formattable)
library(stringr)
library(tm)
library(data.table)
library(e1071)
library(caret)
library(randomForest)
library(party)

library(coreNLP)

initCoreNLP(libLoc="C:\\Users\\Hege\\Downloads\\stanford-corenlp-full-2016-10-31\\stanford-corenlp-full-2016-10-31",
            parameterFile = "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\coreNLP_parameters")

source("GitHub/Gradu/pos_tagging.R")
source("GitHub/Gradu/get_POS_tags.R")
source("GitHub/Gradu/get_frequencies.R")
source("GitHub/Gradu/get_poetry_inds.R")
source("GitHub/Gradu/get_features.R")
source("GitHub/Gradu/get_subset.R")
source("GitHub/Gradu/get_training_and_testing_sets.R")
source("GitHub/Gradu/pos_tagging.R")
source("GitHub/Gradu/prepare_for_randomforest.R")
source("GitHub/Gradu/get_dependency_relations.R")
source("GitHub/Gradu/split_training_set.R")
source("GitHub/Gradu/get_POS_trigrams.R")
source("GitHub/Gradu/run_random_forest.R")
source("GitHub/Gradu/run_rf_with_features.R")
source("GitHub/Gradu/run_rf_once.R")
source("GitHub/Gradu/run_rf_with_mtry.R")
source("GitHub/Gradu/aggregate_confusion_matrix.R")
source("GitHub/Gradu/aggregate_aggregated_cm.R")
source("GitHub/Gradu/get_genre_word_freqs_alt.R")
source("GitHub/Gradu/get_genre_word_freqs.R")
df.estc_genres <- read.csv2("../Desktop/estc_genres2.txt", sep = "\t", header = FALSE)

names(df.estc_genres)[1:18] <- c("system_control_number", "language", "author_name",
                             "title", "title_remainder", "edition_statement",
                             "publication_time", "publication_place", "publisher", 
                             "genre", "genre_source", "genre_ind1", "genre_ind2", 
                             "topic", "topic_sub_form", 
                             "topic_corporate_sub_form", "topic_person_sub_form", 
                             "topic_uniform_sub_form"
                             )
df.estc_genres$whole_title = paste0(df.estc_genres$title, ". ", df.estc_genres$title_remainder, ". ", df.estc_genres$edition_statement)
df.estc_genres$whole_title_sans_edition = paste0(df.estc_genres$title, ". ", df.estc_genres$title_remainder)

# Read preprocessed ESTC and merge it with genres
df.preprocessed <- readRDS("../Työ/Kungliga/Aineisto/Kungliga/estc_df.Rds")
df.estc_genres <- merge(df.estc_genres, df.preprocessed, by.x="system_control_number", by.y="system_control_number")

# Again! Again!
# Stupid yes, but I'm too lazy to make this properly
names(df.estc_genres)[1:18] <- c("system_control_number", "language", "author_name",
                                 "title", "title_remainder", "edition_statement",
                                 "publication_time", "publication_place", "publisher", 
                                 "genre", "genre_source", "genre_ind1", "genre_ind2", 
                                 "topic", "topic_sub_form", 
                                 "topic_corporate_sub_form", "topic_person_sub_form", 
                                 "topic_uniform_sub_form"
                                 )

# clean up the genre fields
df.estc_genres$genre <- gsub("[^a-zA-Z0-9 :,]$", "", df.estc_genres$genre)
df.estc_genres$topic_sub_form <- gsub("[^a-zA-Z0-9 :,]$", "", df.estc_genres$topic_sub_form)
df.estc_genres$topic_corporate_sub_form <- gsub("[^a-zA-Z0-9 :,]$", "", df.estc_genres$topic_corporate_sub_form)
df.estc_genres$topic_uniform_sub_form <- gsub("[^a-zA-Z0-9 :,]$", "", df.estc_genres$topic_uniform_sub_form)
df.estc_genres$topic_person_sub_form <- gsub("[^a-zA-Z0-9 :,]$", "", df.estc_genres$topic_person_sub_form)
df.estc_genres$topic <- gsub("[^a-zA-Z0-9 :,]$", "", df.estc_genres$topic)

# Get the feature list
listAll <- prepare_for_randomforest(df.estc_genres)
features_all <- listAll$features
df.estc_genres <- listAll$df
is_poetry_all <- listAll$is_poetry
features_all$is_poetry <- is_poetry_all

#saveRDS(features_all, "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\features_all_20170425.RDS")
#saveRDS(features_all, "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\features_all_20170427.RDS")
#saveRDS(df.estc_genres, "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\df.estc_genres_20170425.RDS")

features_all <- readRDS("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\features_all_20170427.RDS")
df.estc_genres <- readRDS("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\df.estc_genres_20170425.RDS")
# Start here

df.estc_genres <- readRDS("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\df.estc_genres_20170420.RDS")
i <- 469
features_all <- readRDS("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\features_all.RDS")
features_more <- readRDS(paste0("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\features_", 468, "_more_no_NER.RDS"))
while (i < (nrow(df.estc_genres) / 1000)) {
  
    lowerbound <- ((i * 1000) + 1)
  if ((lowerbound + 1000) < nrow(df.estc_genres)) {
    upperbound <- ((i * 1000) + 1000)
  } else {
    upperbound <- nrow(df.estc_genres)
  }
  #if ((i %% 100) == 0) {  
    ptm <- proc.time()
    print(paste0("starting deprelling for ", lowerbound, ":", upperbound, " at ", date(), "."))
  #}
  features_more_next <- get_dependency_relations(df=df.estc_genres[lowerbound:upperbound,], load=FALSE)
  
  if (i == 0) {
    features_more <- features_more_next
  } else {
    features_more <- rbind(features_more, features_more_next)
  }
  #if ((i %% 10) == 0) {
    saveRDS(features_more, paste0("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\features_", i, "_more_no_NER.RDS"))
  #}
  i <- i + 1
  detach("package:coreNLP", unload=TRUE)
  gc()
  library(coreNLP)
  initCoreNLP(libLoc="C:\\Users\\Hege\\Downloads\\stanford-corenlp-full-2016-10-31\\stanford-corenlp-full-2016-10-31",
              parameterFile = "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\coreNLP_parameters")
}
saveRDS(features_more, "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\features_more_483334.RDS")
# COMBINE THE TWO FEATURE MATRICES


df.english <- get_subset("eng", df.estc_genres)
df.english.genres <- df.english$df.genres
feature_subset <-as.data.frame(POS_trigram_features_title_only, features_all$is_poetry)
#df.english_genres$tagged <- get_POS_tags(df.english_genres$whole_title_sans_edition,load = TRUE)
df.english.genres.sets <- get_training_and_testing_sets(df=df.english.genres, 
                                                        training_percent=50, 
                                                        filenamestem="df.english.genres2", 
                                                        load=FALSE
                                                        )
features.training <- features_all[df.english.genres.sets$training_inds,]
features.testing <- features_all[-df.english.genres$training_inds,]

# This is for testing POS_trigram_features in whole title vs. regular title only
features.training <- feature_subset[df.english.genres.sets$training_inds,]
features.testing <- feature_subset[-df.english.genres.sets$training_inds,]

df.english.genres.training <- df.english.genres.sets$training
df.english.training.split <- split_training_set(df=df.english.genres.training, features=features.training, parts=5)
df.english.training.split.df <- df.english.training.split$df
features.split <- df.english.training.split$features

df.english.genres.testing <- df.english.genres.sets$testing

#df.english_extra <- df.english$df.extra
#df.english.extra.sets <- get_training_and_testing_sets(df=df.english_extra, 
#                                                       training_percent=50, 
#                                                       filenamestem="df.english.extra",
#                                                       load=FALSE
#                                                      )
#df.english.extra.training <- df.english.extra.sets$training
#df.english.extra.testing <- df.english.extra.sets$testing

english_stats <- df.english$stats
rm(df.english)
rm(df.english_genres)
#rm(df.english_extra)
rm(df.english.genres.sets)
#rm(df.english.extra.sets)

for (set_no in 1:length(df.english.training.split)) {
  #listRet <- df.english.training.split$df[rbindlist(df.english.training.split$df[-set_no], use.names=TRUE),]
  #listRet <- rbindlist(df.english.training.split$df[-set_no], use.names=TRUE)
  #features <- features_all[rbindlist(df.english.training.split[-set_no], use.names=TRUE),]
  #ids <- rbindlist(POS_trigram_features_title_only[df.english.training.split$features[-set_no],], use.names=TRUE)
  features <- rbindlist(features.split[-set_no], use.names=TRUE)
  #features <- df.english.training.split$features[rbindlist(df.english.training.split$features[-set_no], use.names=TRUE),]
  
  #df <- listRet$df
  #is_poetry <- rbindlist(df.english.training.split$features[-set_no], use.names=TRUE)$is_poetry
  is_poetry <- rbindlist(features.split[-set_no], use.names=TRUE)$is_poetry
  features$is_poetry <- is_poetry
  varNames <- names(features)[!names(features) %in% c("is_poetry")]
  varNames1 <- paste(varNames, collapse="+")
  rfForm <- as.formula(paste("is_poetry", varNames1, sep=" ~ "))
  retRF <- randomForest::randomForest(rfForm, features, ntree=500, importance=TRUE)
  #plot(retRF)
  #varImpPlot(retRF, sort=TRUE, main="Variable importance")
  #prediction <- predict(retRF, features)
  #df$is_poetry <- is_poetry
  #confusionMatrix(data=prediction, reference=df$is_poetry)
  #listRet2 <- listAll[df=df.english.training.split[[set_no]]]
  #features2 <- listRet2$features
  features2 <- rbindlist(features.split[set_no])
  #df2 <- listRet2$df
  is_poetry2 <- features2$is_poetry
  
  #features2$is_poetry <- is_poetry2
  varNames_2 <- names(features2)[!names(features2) %in% c("is_poetry")]
  varNames1_2 <- paste(varNames_2, collapse="+")
  rfForm2 <- as.formula(paste("is_poetry", varNames1_2, sep=" ~ "))
  retRF2 <- randomForest::randomForest(rfForm2, features2, ntree=500, importance=TRUE)
  
  #plot(retRF2)
  
  varImpPlot(retRF2, sort=TRUE, main="Variable importance")
  
  #df2$is_poetry <- is_poetry2
  prediction2 <- predict(retRF, features2)
  
  cm <- confusionMatrix(data=prediction2, reference=is_poetry2)
  print(cm)
  print("--------------------------------------------------------------------------------------------")
  print(date())
}



listRet <- prepare_for_randomforest(df=df.english.genres.training)
#saveRDS(listRet$df, "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\df.english.genres.training.20170406.RDS")
features <- listRet$features
df <- listRet$df
is_poetry <- listRet$is_poetry

features$is_poetry <- is_poetry
varNames <- names(features[!names(features) %in% c("is_poetry")])
varNames1 <- paste(varNames, collapse="+")
rfForm <- as.formula(paste("is_poetry", varNames1, sep=" ~ "))
#retRF <- randomForest::randomForest(features, y=is_poetry, ntree=500)
retRF <- randomForest::randomForest(rfForm, features, ntree=500, importance=TRUE)

plot(retRF)

varImpPlot(retRF, sort=TRUE, main="Variable importance")

prediction <- predict(retRF, features)
df$is_poetry <- is_poetry
confusionMatrix(data=prediction, reference=df$is_poetry)




# Then the same with testing set
listRet2 <- prepare_for_randomforest(df=df.english.genres.testing)
saveRDS(listRet2$df, "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\df.english.genres.testing.20170406.RDS")
features2 <- listRet2$features
df2 <- listRet2$df
is_poetry2 <- listRet2$is_poetry

#features2$is_poetry <- is_poetry2
#varNames_2 <- names(features2[!names(features2) %in% c("is_poetry")])
#varNames1_2 <- paste(varNames_2, collapse="+")
#rfForm2 <- as.formula(paste("is_poetry", varNames1_2, sep=" ~ "))
#retRF2 <- randomForest::randomForest(rfForm2, features2, ntree=500, importance=TRUE)

plot(retRF2)

varImpPlot(retRF2, sort=TRUE, main="Variable importance")

df2$is_poetry <- is_poetry2
prediction2 <- predict(retRF, features2)

confusionMatrix(data=prediction2, reference=df2$is_poetry, positive="FALSE")


# Maybe later: the same for Latin & French

#df.latin <- get_subset("lat")
#df.latin_extra <- df.latin$df.extra
#df.latin_genres <- df.latin$df.genres
#latin_stats <- df.latin$stats
#rm(df.latin)

#df.french <- get_subset("fre")
#df.french_extra <- df.french$df.extra
#df.french_genres <- df.french$df.genres
#french_stats <- df.french$stats
#rm(df.french)

#all_stats <- rbind(english_stats, latin_stats, french_stats)
#print(all_stats)



# Dead code, I think
#df.english_genres$author_name <- as.factor(df.english_genres$author_name)
#df.english_genres$title <- as.factor(df.english_genres$title)
#df.english_genres$title_remainder <- as.factor(df.english_genres$title_remainder)
#df.english_genres$edition_statement <- as.factor(df.english_genres$edition_statement)
#df.english_genres$publication_time <- as.factor(df.english_genres$publication_time)
#df.english_genres$publication_place <- as.factor(df.english_genres$publication_place)
#df.english_genres$publisher <- as.factor(df.english_genres$publisher)
#df.english_genres$genre <- as.factor(df.english_genres$genre)
#df.english_genres$genre_source <- as.factor(df.english_genres$genre_source)
#df.english_genres$genre_ind1 <- as.factor(df.english_genres$genre_ind1)
#df.english_genres$genre_ind2 <- as.factor(df.english_genres$genre_ind2)
#df.english_genres$topic <- as.factor(df.english_genres$topic)
#df.english_genres$topic_corporate_sub_form <- as.factor(df.english_genres$topic_corporate_sub_form)
#df.english_genres$topic_person_sub_form <- as.factor(df.english_genres$topic_person_sub_form)
#df.english_genres$topic_uniform_sub_form <- as.factor(df.english_genres$topic_uniform_sub_form)
#df.english_genres$topic_sub_form <- as.factor(df.english_genres$topic_sub_form)
#df.english_genres$whole_title <- as.factor(df.english_genres$whole_title)
#df.english_genres$whole_title_sans_edition <- as.factor(df.english_genres$whole_title_sans_edition)


# Ignore vowel/consonant ratio, as English to IPA seems too hard to find
# 1) Photransedit won't allow text files as input
# 2) http://clarin.phonetik.uni-muenchen.de/BASWebServices/#/services/Grapheme2Phoneme produces crappy results

# Get the most frequent stuff

#all_titles <- df.english_genres$whole_title_sans_edition




