
library(devtools)
library(ggplot2)
library(formattable)
library(stringr)
library(tm)
library(data.table)
library(e1071)
library(caret)
library(randomForest)
library(gridExtra)
library(party)
library(class)
library(OneR)
library(rpart)
library(RWeka)
library(gbm)
library(hmeasure)

options(scipen=3)

if (Sys.info()["nodename"] == "MOOTTORI") {
  bu_path <- "C:/Users/Hege/Opiskelu/Kurssit/Gradu/"
  outputpath <- "C:Users/Hege/Opiskelu/Kurssit/Gradu/Output"
  codepath <- "C:/Users/Hege/Documents/GitHub/Gradu"
  setwd(codepath)
} else if (Sys.info()["nodename"] =="LH6-FHKT3") {
  bu_path <- "C:/HY-Data/HEGROIVA/Gradu"
  outputpath <- "C:/HY-DATA/HEGROIVA/Gradu/Output"
  codepath <- "C:/HY-DATA/HEGROIVA/GitHub/Gradu"
  setwd(codepath)
} else {
  bu_path <- getwd()
  outputpath <-	paste0(bu_path, "/Output")
  codepath <- getwd()
}

#library(coreNLP)

#initCoreNLP(libLoc="C:\\Users\\Hege\\Downloads\\stanford-corenlp-full-2016-10-31\\stanford-corenlp-full-2016-10-31",
#            parameterFile = "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\coreNLP_parameters")

#source("pos_tagging.R")
#source("get_POS_tags.R")
#source("get_frequencies.R")
#source("get_poetry_inds.R")
#source("get_features.R")
source("get_subset.R")
source("get_training_and_testing_sets.R")
#source("pos_tagging.R")
#source("prepare_for_randomforest.R")
#source("get_dependency_relations.R")
source("split_training_set.R")
#source("get_POS_trigrams.R")
source("run_rf.R")
#source("run_rf_with_features.R")
source("run_rf_once.R")
#source("run_rf_with_mtry.R")
source("aggregate_confusion_matrix.R")
source("aggregate_aggregated_cm.R")
#source("get_genre_word_freqs_alt.R")
#source("get_genre_word_freqs.R")
source("run_svm.R")
source("run_svm_once.R")
source("run_knn.R")
source("run_knn_once.R")
source("run_oner.R")
source("run_oner_once.R")
source("run_rpart.R")
source("run_rpart_once.R")
source("run_c45.R")
source("run_c45_once.R")
source("run_PART.R")
source("run_PART_once.R")
source("run_gbm.R")
source("run_gbm_once.R")
source("run_naivebayes.R")
source("run_naivebayes_once.R")
source("run_LDA.R")
source("run_LDA_once.R")
source("run_caret_rf.R")
source("run_caret_rf_once.R")
source("add_customized_rf_model.R")
source("hmeasureCaret.R")
source("run_all_once.R")


df <- readRDS(paste0(bu_path, "/df.20170609.RDS"))
feats <- readRDS(paste0(bu_path, "/feats_poetry_whole_title100_20170515.RDS"))
