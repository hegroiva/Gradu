
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
#library(coreNLP)

#initCoreNLP(libLoc="C:\\Users\\Hege\\Downloads\\stanford-corenlp-full-2016-10-31\\stanford-corenlp-full-2016-10-31",
#            parameterFile = "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\coreNLP_parameters")

#source("GitHub/Gradu/pos_tagging.R")
#source("GitHub/Gradu/get_POS_tags.R")
#source("GitHub/Gradu/get_frequencies.R")
#source("GitHub/Gradu/get_poetry_inds.R")
#source("GitHub/Gradu/get_features.R")
source("GitHub/Gradu/get_subset.R")
source("GitHub/Gradu/get_training_and_testing_sets.R")
#source("GitHub/Gradu/pos_tagging.R")
#source("GitHub/Gradu/prepare_for_randomforest.R")
#source("GitHub/Gradu/get_dependency_relations.R")
source("GitHub/Gradu/split_training_set.R")
#source("GitHub/Gradu/get_POS_trigrams.R")
source("GitHub/Gradu/run_rf.R")
#source("GitHub/Gradu/run_rf_with_features.R")
source("GitHub/Gradu/run_rf_once.R")
#source("GitHub/Gradu/run_rf_with_mtry.R")
source("GitHub/Gradu/aggregate_confusion_matrix.R")
source("GitHub/Gradu/aggregate_aggregated_cm.R")
#source("GitHub/Gradu/get_genre_word_freqs_alt.R")
#source("GitHub/Gradu/get_genre_word_freqs.R")
source("GitHub/Gradu/run_svm.R")
source("GitHub/Gradu/run_svm_once.R")
source("GitHub/Gradu/run_knn.R")
source("GitHub/Gradu/run_knn_once.R")
source("GitHub/Gradu/run_oner.R")
source("GitHub/Gradu/run_oner_once.R")
source("GitHub/Gradu/run_rpart.R")
source("GitHub/Gradu/run_rpart_once.R")
source("GitHub/Gradu/run_c45.R")
source("GitHub/Gradu/run_c45_once.R")
source("GitHub/Gradu/run_PART.R")
source("GitHub/Gradu/run_PART_once.R")
source("GitHub/Gradu/run_gbm.R")
source("GitHub/Gradu/run_gbm_once.R")
source("GitHub/Gradu/run_naivebayes.R")
source("GitHub/Gradu/run_naivebayes_once.R")
source("GitHub/Gradu/run_LDA.R")
source("GitHub/Gradu/run_LDA_once.R")
source("GitHub/Gradu/run_caret_rf.R")
source("GitHub/Gradu/run_caret_rf_once.R")
source("GitHub/Gradu/add_customized_rf_model.R")
source("GitHub/Gradu/hmeasureCaret.R")
source("GitHub/Gradu/run_all_once.R")

if (Sys.info()["nodename"] == "MOOTTORI") {
	bu_path <- "C:/Users/Hege/Opiskelu/Kurssit/Gradu/"
	outputpath <- "C:Users/Hege/Opiskelu/Kurssit/Gradu/Output"
	codepath <- "C:/Users/Hege/Tiedostot/GitHub/Gradu"
} else if (Sys.info()["nodename"] =="LH6-FHKT3") {
	bu_path <- "C:/HY-Data/HEGROIVA/Gradu"
	outputpath <- "C:/HY-DATA/HEGROIVA/Gradu/Output"
	codepath <- "C:/HY-DATA/HEGROIVA/GitHub/Gradu"
} else {
	bu_path <- getwd()
	outputpath <-	paste0(bu_path, "/Output")
	codepath <- getwd()
}

df <- readRDS(paste0(bu_path, "/df.20170609.RDS"))
feats <- readRDS(paste0(bu_path, "/feats_poetry_whole_title100_20170515.RDS"))
