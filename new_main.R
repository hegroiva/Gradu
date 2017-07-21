
# Get top 100 freq of poetry
poetry_inds <- which(feats100per100$is_poetry==TRUE)
non_poetry_inds <- which(df.estc$genre!="" & feats100per100$is_poetry==FALSE)

feats_poetry_whole_title100 <- get_genre_word_freqs(df$whole_title_sans_edition[poetry_inds], 
                                                    prefix="poetry", all_titles=df$whole_title_sans_edition, 
                                                    exclude_titles=df$whole_title_sans_edition[non_poetry], 
                                                    max_count=100)
feats100 <- cbind(feats_poetry_whole_title100, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title100, paste0(bu_path, "/feats_poetry_whole_title100_20170515.RDS"))


saveRDS(feats_poetry_whole_title, paste0(bu_path, "/feats_poetry_whole_title200_20170515.RDS"))

# Get top 300 freq of poetry
feats_poetry_whole_title300 <- get_genre_word_freqs(df$whole_title_sans_edition[poetry_inds], 
                                                    prefix="poetry", all_titles=df$whole_title_sans_edition, 
                                                    exclude_titles=df$whole_title_sans_edition[non_poetry], 
                                                    max_count=300)
feats300 <- cbind(feats_poetry_whole_title300, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title300, paste0(bu_path, "/feats_poetry_whole_title300_20170515.RDS"))
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100", ntree = 500, mtry=5)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300", ntree = 500, mtry=5)

# Get top 50 freq of poetry
feats_poetry_whole_title50 <- get_genre_word_freqs(df$whole_title_sans_edition[poetry_inds], 
                                                    prefix="poetry", all_titles=df$whole_title_sans_edition, 
                                                    exclude_titles=df$whole_title_sans_edition[non_poetry], 
                                                    max_count=50)
feats50 <- cbind(feats_poetry_whole_title50, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title50, paste0(bu_path, "/feats_poetry_whole_title50_20170515.RDS"))
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50", ntree = 500, mtry=5)

# Get top 25 freq of poetry
feats_poetry_whole_title25 <- get_genre_word_freqs(df$whole_title_sans_edition[poetry_inds], 
                                                   prefix="poetry", all_titles=df$whole_title_sans_edition, 
                                                   exclude_titles=df$whole_title_sans_edition[non_poetry], 
                                                   max_count=25)
feats25 <- cbind(feats_poetry_whole_title25, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title25, paste0(bu_path, "/feats_poetry_whole_title25_20170515.RDS"))
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25", ntree = 500, mtry=5)

qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_mtry10", ntree = 500, mtry=10)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_mtry10", ntree = 500, mtry=10)

qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_mtry15", ntree = 500, mtry=15)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_mtry15", ntree = 500, mtry=15)

qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree750_mtry5", ntree = 750, mtry=5)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree750_mtry5", ntree = 750, mtry=5)

qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree750_mtry5", ntree = 750, mtry=5)

# START POS ROUNDS
# 1000 poetry POS not in 1000 non_poetry POS
feats_pos_trigrams <- cbind(freqs, is_poetry=features$is_poetry)
names(feats_pos_trigrams) <- gsub(" ", "_", names(feats_pos_trigrams))
saveRDS(feats_pos_trigrams, paste0(bu_path, "/feats_pos_trigrams_top1000_fixed.RDS"))
qqq <- run_rf_once(df=df, features=feats_pos_trigrams, language="eng", filenamestem="pos_trigrams_top1000_ntree500_mtry5", ntree=750, mtry=5)

# save feature sets
names(feats50per50_pos) <- gsub(" ", "_", names(feats50per50_pos))
names(feats50per100_pos) <- gsub(" ", "_", names(feats50per100_pos))

names(feats100per50_pos) <- gsub(" ", "_", names(feats100per50_pos))
names(feats100per100_pos) <- gsub(" ", "_", names(feats100per100_pos))
names(feats100per200_pos) <- gsub(" ", "_", names(feats100per200_pos))
#names(feats100per500_pos) <- gsub(" ", "_", names(feats100per500_pos))
#names(feats100per1000_pos) <- gsub(" ", "_", names(feats100per1000_pos))

names(feats200per200_pos) <- gsub(" ", "_", names(feats200per200_pos))
names(feats200per500_pos) <- gsub(" ", "_", names(feats200per500_pos))
#names(feats200per1000_pos) <- gsub(" ", "_", names(feats200per1000_pos))
names(feats500per500_pos) <- gsub(" ", "_", names(feats500per500_pos))
names(feats500per1000_pos) <- gsub(" ", "_", names(feats500per1000_pos))

saveRDS(feats50per50_pos, paste0(bu_path, "/feats_pos_trigrams_50per50_titles_only.RDS"))
saveRDS(feats50per100_pos, paste0(bu_path, "/feats_pos_trigrams_50per100_titles_only.RDS"))

saveRDS(feats100per50_pos, paste0(bu_path, "/feats_pos_trigrams_100per50_titles_only.RDS"))
saveRDS(feats100per100_pos, paste0(bu_path, "/feats_pos_trigrams_100per100_titles_only.RDS"))
saveRDS(feats100per200_pos, paste0(bu_path, "/feats_pos_trigrams_100per200_titles_only.RDS"))
#saveRDS(feats100per500_pos, paste0(bu_path, "/feats_pos_trigrams_100per500_titles_only.RDS"))
#saveRDS(feats100per1000_pos, paste0(bu_path, "/feats_pos_trigrams_100per1000_titles_only.RDS"))

saveRDS(feats200per200_pos, paste0(bu_path, "/feats_pos_trigrams_200per200_titles_only.RDS"))
saveRDS(feats200per500_pos, paste0(bu_path, "/feats_pos_trigrams_200per500_titles_only.RDS"))
#saveRDS(feats200per1000_pos, paste0(bu_path, "/feats_pos_trigrams_200per1000_titles_only.RDS"))
saveRDS(feats500per500_pos, paste0(bu_path, "/feats_pos_trigrams_500per500.RDS"))
saveRDS(feats500per1000_pos, paste0(bu_path, "/feats_pos_trigrams_500per1000_titles_only.RDS"))

# 50 per 50
qqq <- run_rf_once(df=df, features=feats50per50_pos, language="eng", filenamestem="pos_trigrams_50per50_titles_only", ntree=750, mtry=5)

# 50 per 100
qqq <- run_rf_once(df=df, features=feats50per100_pos, language="eng", filenamestem="pos_trigrams_50per100_titles_only", ntree=750, mtry=5)

# 100 per 50
qqq <- run_rf_once(df=df, features=feats100per50_pos, language="eng", filenamestem="pos_trigrams_100per50_titles_only", ntree=750, mtry=5)

# 100 per 100
qqq <- run_rf_once(df=df, features=feats100per100_pos, language="eng", filenamestem="pos_trigrams_100per100_titles_only", ntree=750, mtry=5)

# 100 per 200
qqq <- run_rf_once(df=df, features=feats100per200_pos, language="eng", filenamestem="pos_trigrams_100per200_titles_only", ntree=750, mtry=5)

# 100 per 500
#qqq <- run_rf_once(df=df, features=feats100per500_pos, language="eng", filenamestem="pos_trigrams_100per500_titles_only", ntree=750, mtry=5)

# 100 per 1000
#qqq <- run_rf_once(df=df, features=feats100per1000_pos, language="eng", filenamestem="pos_trigrams_100per1000_titles_only", ntree=750, mtry=5)

# 200 per 200
qqq <- run_rf_once(df=df, features=feats200per200_pos, language="eng", filenamestem="pos_trigrams_200per200_titles_only", ntree=750, mtry=5)

# 200 per 500
qqq <- run_rf_once(df=df, features=feats200per500_pos, language="eng", filenamestem="pos_trigrams_200per500_titles_only", ntree=750, mtry=5)

# 200 per 1000
#qqq <- run_rf_once(df=df, features=feats200per1000_pos, language="eng", filenamestem="pos_trigrams_200per1000_titles_only", ntree=750, mtry=5)

# 500 per 500
qqq <- run_rf_once(df=df, features=feats500per500_pos, language="eng", filenamestem="pos_trigrams_500per500_titles_only", ntree=750, mtry=5)

# 500 per 1000
qqq <- run_rf_once(df=df, features=feats500per1000_pos, language="eng", filenamestem="pos_trigrams_500per1000_titles_only", ntree=750, mtry=5)



# Gather everything into one file
pattern <- "pos_trigrams_[0-9]+per[0-9]+.*.txt"
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern)

names_ret <- str_extract(string = names(ret), pattern="[0-9]+per[0-9]+")
names_ret <- str_replace(string=names_ret, pattern="per", replacement = " / ")
names(ret) <- names_ret

png(filename = paste0(outputpath, "/all_pos_trigrams.png"), width = 2000)
grid.table(ret)
dev.off()



# Gather mtry variance into one file
pattern <- "^mtry.*.txt"
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern)

names_ret <- str_extract(string=names(ret), pattern="_([0-9])+conf")
names_ret <- str_replace(string=names_ret, pattern="_", replacement="")
names_ret <- str_replace(string=names_ret, pattern="conf", replacement="")
names(ret) <- names_ret

png(filename = paste0(outputpath, "/mtry_values_ntree100_all_feats.png"), width = 2000)
grid.table(ret)
dev.off()





# Gather poetry
pattern <- "^poetry[0-9]+_confusionMatrix_combined.txt"
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern)

names_ret <- str_extract(string=names(ret), pattern="[0-9]+")
names(ret) <- names_ret

png(filename = paste0(outputpath, "/poetry_values_bagofwords.png"), width = 2000)
grid.table(ret)
dev.off()




# Gather ntree/mtry variance
files <- c("poetry50_confusionMatrix_combined.txt",
           "poetry50_mtry10_confusionMatrix_combined.txt", 
           "poetry50_mtry15_confusionMatrix_combined.txt",
           "poetry50_ntree750_mtry5_confusionMatrix_combined.txt")
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern, files=files)

names_ret <- c("500 / 5", "500 / 10", "500 / 15", "750 / 5")
names(ret) <- names_ret

png(filename = paste0(outputpath, "/poetry_bagofwords_ntree_and_mtry.png"), width = 2000)
grid.table(ret)
dev.off()


# start SVM
# 50 per 50
qqq <- run_svm_once(df = df, features = feats50per50_pos, filenamestem = "svm_pos_50per50", language = "eng")

# 50 per 100
qqq <- run_svm_once(df = df, features = feats50per100_pos, filenamestem = "svm_pos_50per100", language = "eng")

# 100 per 50
qqq <- run_svm_once(df = df, features = feats100per50_pos, filenamestem = "svm_pos_100per50", language = "eng")

# 100 per 100
qqq <- run_svm_once(df = df, features = feats100per100_pos, filenamestem = "svm_pos_100per100", language = "eng")

# 100 per 200
qqq <- run_svm_once(df = df, features = feats100per200_pos, filenamestem = "svm_pos_100per200", language = "eng")

# 200 per 200
qqq <- run_svm_once(df = df, features = feats200per200_pos, filenamestem = "svm_pos_200per200", language = "eng")

# 200 per 500
qqq <- run_svm_once(df = df, features = feats200per500_pos, filenamestem = "svm_pos_200per500", language = "eng")

# 500 per 500
qqq <- run_svm_once(df = df, features = feats500per500_pos, filenamestem = "svm_pos_500per500", language = "eng")

# 500 per 1000
qqq <- run_svm_once(df = df, features = feats500per1000_pos, filenamestem = "svm_pos_500per1000", language = "eng")




# plot graph: 
# 1: bag-of-words
library(tidyr)
library(ggplot2)
sensitivity <- c(39.9, 45.4, 46.0, 44.2, 42.3)
pred_value <- c(68.3, 62.1, 60.8, 61.9, 57.1)
balanced <- c(69.3, 71.9, 72.1, 71.2, 70.1)
df_kpl <- data.frame(sensitivity=sensitivity, pred_value=pred_value, balanced=balanced)
row.names(df_kpl) <- c("25", "50", "100", "200", "300")
df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)


# This is it
png(filename = paste0(outputpath, "/Effect of word count in bag-of-words.png"), width = 1000)
p <- ggplot(data=df, aes(n)) + 
  theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
        legend.text = element_text(size=14), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12),
        plot.title = element_text(size=20),
        plot.subtitle = element_text(size=14)
  ) +
  scale_x_continuous(breaks=df$n, labels=df$n) +
  scale_y_continuous(breaks=c(40,50,60,70), labels=c("40%", "50%", "60%", "70%")) +
  labs(title="Effect of word count in bag-of-words", 
       x="Size of bag-of-words", y="") +
  geom_line(aes(y=sensitivity, col="Sensitivity"), size=2) + 
  geom_line(aes(y=pred_value, col="Predictive value"), size=2) + 
  geom_line(aes(y=balanced, col="Balanced accuracy"), size=2) +
  geom_point(aes(y=balanced), size=3) +
  geom_point(aes(y=pred_value), size=3) +
  geom_point(aes(y=sensitivity), size=3)
plot(p)
dev.off()

# 2: POS trigrams
library(tidyr)
library(ggplot2)
sensitivity <- c(19.5, 20.2, 24.9, 20.1, 15.8)
pred_value <- c(35.7, 35.9, 32.1, 27.3, 33.0)
balanced <- c(58.6, 58.9, 60.8, 58.3, 56.9)
df_kpl <- data.frame(sensitivity=sensitivity, pred_value=pred_value, balanced=balanced)
row.names(df_kpl) <- c("50", "100", "200", "500", "1000")
df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)


# This is it
png(filename = paste0(outputpath, "/Effect of trigram count in POS trigrams.png"), width = 1000)
p <- ggplot(data=df, aes(n)) + 
  theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
        legend.text = element_text(size=14), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12),
        plot.title = element_text(size=20),
        plot.subtitle = element_text(size=14)
  ) +
  scale_x_continuous(breaks=df$n, labels=c("50\n16", "100\n24", "200\n45", "500\n119", "1000\n225")) +
  scale_y_continuous(breaks=c(20, 30, 40,50,60), labels=c("20%", "30%", "40%", "50%", "60%")) +
  labs(title="Effect of trigram count in POS trigrams", 
       x="Trigram count for poetry == trigram count of non-poetry", y="", 
       subtitle="The number under n represents the remaining number of features after non-poetry POS tags were removed") +
  geom_line(aes(y=sensitivity, col="Sensitivity"), size=2) + 
  geom_line(aes(y=pred_value, col="Predictive value"), size=2) + 
  geom_line(aes(y=balanced, col="Balanced accuracy"), size=2) +
  geom_point(aes(y=balanced), size=3) +
  geom_point(aes(y=pred_value), size=3) +
  geom_point(aes(y=sensitivity), size=3) 
plot.new()  
plot(p)
#text("The number under n represents the remaining number of features after non-poetry POS tags were removed")
dev.off()


# 3: Effect of mtry 3-16
library(tidyr)
library(ggplot2)
sensitivity <- c(68.4, 67.7, 67.3, 66.7, 65.9, 66.4, 65.1, 66.5, 64.9, 64.9, 65.2, 65.1, 64.9, 65.0)
pred_value <- c(39.1, 39.7, 39.8, 40.4, 40.7, 40.2, 39.4, 39.9, 39.6, 39.4, 39.5, 38.9, 38.6, 38.6)
balanced <- c(80.8, 80.5, 80.4, 80.2, 79.9, 80.0, 79.3, 80.0, 79.3, 79.2, 79.4, 79.2, 79.2, 79.2)
df_kpl <- data.frame(sensitivity=sensitivity, pred_value=pred_value, balanced=balanced)
row.names(df_kpl) <- c("3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16")
df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)


# This is it
png(filename = paste0(outputpath, "/Effect of adjusting mtry value.png"), width = 1000)
p <- ggplot(data=df, aes(n)) + 
  theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
        legend.text = element_text(size=14), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12),
        plot.title = element_text(size=20),
        plot.subtitle = element_text(size=14)
  ) +
  scale_x_continuous(breaks=df$n, labels=df$n) +
  scale_y_continuous(breaks=c(40,50,60,70, 80), labels=c("40%", "50%", "60%", "70%", "80%")) +
  labs(title="Effect of adjusting mtry value", 
       x="Mtry (Number of features tried in each bootstrap)", y="", 
       subtitle="All the features (Best of)") +
  geom_line(aes(y=sensitivity, col="Sensitivity"), size=2) + 
  geom_line(aes(y=pred_value, col="Predictive value"), size=2) + 
  geom_line(aes(y=balanced, col="Balanced accuracy"), size=2) +
  geom_point(aes(y=balanced), size=3) +
  geom_point(aes(y=pred_value), size=3) +
  geom_point(aes(y=sensitivity), size=3) 
plot.new()  
plot(p)
#text("The number under n represents the remaining number of features after non-poetry POS tags were removed")
dev.off()



# 4: Effect of changing the non-poetry bag-of-words count
library(tidyr)
library(ggplot2)
sensitivity <- c(32.9, 20.2, 15.0)
pred_value <- c(24.1, 35.9, 60.1)
balanced <- c(63.1, 58.9, 57.2)
df_kpl <- data.frame(sensitivity=sensitivity, pred_value=pred_value, balanced=balanced)
row.names(df_kpl) <- c("50", "100", "200")
df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)


# This is it
png(filename = paste0(outputpath, "/Effect of non-poetry POS trigram size.png"), width = 1000)
p <- ggplot(data=df, aes(n)) + 
  theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
        legend.text = element_text(size=14), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12),
        plot.title = element_text(size=20),
        plot.subtitle = element_text(size=14)
  ) +
  scale_x_continuous(breaks=df$n, labels=c("50\n51", "100\n24", "200\n8")) +
  scale_y_continuous(breaks=c(20, 30, 40,50,60), labels=c("20%", "30%", "40%", "50%", "60%")) +
  labs(title="Effect of non-poetry POS trigrams size", 
       x="POS trigram count of non-poetry\nwhen POS trigram count of poetry = 100", y="", 
       subtitle="The number under n represents the remaining number of features after non-poetry POS tags were removed") +
  
  geom_line(aes(y=sensitivity, col="Sensitivity"), size=2) + 
  geom_line(aes(y=pred_value, col="Predictive value"), size=2) + 
  geom_line(aes(y=balanced, col="Balanced accuracy"), size=2) +
  geom_point(aes(y=balanced), size=3) +
  geom_point(aes(y=pred_value), size=3) +
  geom_point(aes(y=sensitivity), size=3) 
plot.new()  
plot(p)
#text("The number under n represents the remaining number of features after non-poetry POS tags were removed")
dev.off()




# 4: Effect of changing the non-poetry bag-of-words count
library(tidyr)
library(ggplot2)
sensitivity <- c(32.9, 20.2, 15.0)
pred_value <- c(24.1, 35.9, 60.1)
balanced <- c(63.1, 58.9, 57.2)
sensitivity_svm <- c(12.5, 9.5, 5.4)
pred_value_svm <- c(75.6, 73.4, 67.3)
balanced_svm <- c(56.1, 54.6, 52.6)
df_kpl <- data.frame(sensitivity=sensitivity, pred_value=pred_value, balanced=balanced, 
                     sensitivity_svm=sensitivity_svm, pred_value_svm=pred_value_svm, balanced_svm=balanced_svm)
row.names(df_kpl) <- c("50", "100", "200")
df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)

override.linetype <- c("solid","solid","solid","dashed","dashed","dashed")
override.colour <- c("red","purple","green","red","purple","green")
# This is it
png(filename = paste0(outputpath, "/Effect of non-poetry POS trigram size with SVM.png"), width = 1000)
p <- ggplot(data=df, aes(x=n)) + 
  theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
        legend.text = element_text(size=14), 
        axis.text.x = element_text(size=12), 
        axis.text.y = element_text(size=12),
        plot.title = element_text(size=20),
        plot.subtitle = element_text(size=14), legend.key.width = unit(3, "cm")
  ) +
  scale_x_continuous(breaks=df$n, labels=c("50\n51", "100\n24", "200\n8")) +
  scale_y_continuous(breaks=c(10,20, 30, 40,50,60, 70, 80), labels=c("10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%")) +
  labs(title="Effect of non-poetry POS trigrams size", 
       x="POS trigram count of non-poetry\nwhen POS trigram count of poetry = 100", y="", 
       subtitle="The number under n represents the remaining number of features after non-poetry POS tags were removed") +
  #guides(colour=guide_legend(keywidth = 3)) +
  
  geom_line(aes(y=sensitivity, col="asensitivity", linetype="asensitivity"), size=1.0) + 
  geom_line(aes(y=pred_value, col="bpred_value", linetype="bpred_value"), size=1.0) + 
  geom_line(aes(y=balanced, col="cbalanced", linetype="cbalanced"), size=1.0) +
  geom_line(aes(y=sensitivity_svm, col="dsensitivity_svm", linetype="dsensitivity_svm"), size=1.0) + 
  geom_line(aes(y=pred_value_svm, col="epred_value_svm", linetype="epred_value_svm"), size=1.0) + 
  geom_line(aes(y=balanced_svm, col="fbalanced_svm", linetype="fbalanced_svm"), size=1.0) +
  #scale_color_manual(values=override.colour)+
  scale_linetype_manual(name="", values = override.linetype, labels=c("Sensitivity (RF)", "Predictive value (RF)", "Balanced accuracy (RF)",
                                                              "Sensitivity (SVM)", "Predictive value (SVM)", "Balanced accuracy (SVM)")) +
  scale_color_manual(name="",values = override.colour, labels=c("Sensitivity (RF)", "Predictive value (RF)", "Balanced accuracy (RF)",
                                                         "Sensitivity (SVM)", "Predictive value (SVM)", "Balanced accuracy (SVM)")) +
  
  geom_point(aes(y=balanced), size=3) +
  geom_point(aes(y=pred_value), size=3) +
  geom_point(aes(y=sensitivity), size=3) +
  geom_point(aes(y=balanced_svm), size=3) +
  geom_point(aes(y=pred_value_svm), size=3) +
  geom_point(aes(y=sensitivity_svm), size=3) 
plot.new()  
plot(p)
#text("The number under n represents the remaining number of features after non-poetry POS tags were removed")
dev.off()





# Back to Bag-of-words, with two new twists
# 1: get_genre_word_freqs_alt
# 2: whole title vs. title only


poetry_inds <- which(feats$is_poetry==TRUE)
non_poetry_inds <- which(df$genre!="" & feats$is_poetry==FALSE)


# Get top 100 (whole title)
feats_poetry_whole_title100 <- get_genre_word_freqs_alt(df.estc$whole_title_sans_edition[poetry_inds], 
                                                    prefix="poetry_alt", all_titles=df.estc$whole_title_sans_edition, 
                                                    exclude_titles=df.estc$whole_title_sans_edition[non_poetry_inds], 
                                                    max_count=100)
feats_poetry_whole_title100 <- cbind(feats_poetry_whole_title100, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title100, paste0(bu_path, "/feats_poetry_whole_title_alt_100_20170531.RDS"))

# Get top 50 (whole title)
feats_poetry_whole_title50 <- get_genre_word_freqs_alt(df.estc$whole_title_sans_edition[poetry_inds], 
                                                       prefix="poetry_alt", all_titles=df.estc$whole_title_sans_edition, 
                                                       exclude_titles=df.estc$whole_title_sans_edition[non_poetry_inds], 
                                                       max_count=50)
feats_poetry_whole_title50 <- cbind(feats_poetry_whole_title50, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title50, paste0(bu_path, "/feats_poetry_whole_title_alt_50_20170531.RDS"))

# Get top 150 (whole title)
feats_poetry_whole_title150 <- get_genre_word_freqs_alt(df.estc$whole_title_sans_edition[poetry_inds], 
                                                        prefix="poetry_alt", all_titles=df.estc$whole_title_sans_edition, 
                                                        exclude_titles=df.estc$whole_title_sans_edition[non_poetry_inds], 
                                                        max_count=150)
feats_poetry_whole_title150 <- cbind(feats_poetry_whole_title150, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title150, paste0(bu_path, "/feats_poetry_whole_title_alt_150_20170531.RDS"))

# Get top 200 (whole title)
feats_poetry_whole_title200 <- get_genre_word_freqs_alt(df.estc$whole_title_sans_edition[poetry_inds], 
                                                        prefix="poetry_alt", all_titles=df.estc$whole_title_sans_edition, 
                                                        exclude_titles=df.estc$whole_title_sans_edition[non_poetry_inds], 
                                                        max_count=200)
feats_poetry_whole_title200 <- cbind(feats_poetry_whole_title200, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_whole_title200, paste0(bu_path, "/feats_poetry_whole_title_alt_200_20170531.RDS"))


# AGAIN. Now title only
# Get top 50 (title only)
feats_poetry_title_only50 <- get_genre_word_freqs_alt(df.estc$title[poetry_inds], 
                                                      prefix="poetry_alt_title", all_titles=df.estc$title, 
                                                      exclude_titles=df.estc$title[non_poetry_inds], 
                                                      max_count=50)
feats_poetry_title_only50 <- cbind(feats_poetry_title_only50, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_title_only50, paste0(bu_path, "/feats_poetry_title_only_alt_50_20170531.RDS"))

# Get top 100 (title only)
feats_poetry_title_only100 <- get_genre_word_freqs_alt(df.estc$title[poetry_inds], 
                                                       prefix="poetry_alt_title", all_titles=df.estc$title, 
                                                       exclude_titles=df.estc$title[non_poetry_inds], 
                                                       max_count=100)
feats_poetry_title_only100 <- cbind(feats_poetry_title_only100, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_title_only100, paste0(bu_path, "/feats_poetry_title_only_alt_100_20170531.RDS"))

# Get top 150 (title only)
feats_poetry_title_only150 <- get_genre_word_freqs_alt(df.estc$title[poetry_inds], 
                                                       prefix="poetry_alt_title", all_titles=df.estc$title, 
                                                       exclude_titles=df.estc$title[non_poetry_inds], 
                                                       max_count=150)
feats_poetry_title_only150 <- cbind(feats_poetry_title_only150, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_title_only150, paste0(bu_path, "/feats_poetry_title_only_alt_150_20170531.RDS"))

# Get top 200 (title only)
feats_poetry_title_only200 <- get_genre_word_freqs_alt(df.estc$title[poetry_inds], 
                                                       prefix="poetry_alt_title", all_titles=df.estc$title, 
                                                       exclude_titles=df.estc$title[non_poetry_inds], 
                                                       max_count=200)
feats_poetry_title_only200 <- cbind(feats_poetry_title_only200, is_poetry=feats$is_poetry)
saveRDS(feats_poetry_title_only200, paste0(bu_path, "/feats_poetry_title_only_alt_200_20170531.RDS"))


# THEN, THE ACTUAL RUNS
# Get top 50 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_whole_title50, filenamestem = "poetry50_alt")

# Get top 100 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_whole_title100, filenamestem = "poetry100_alt")

# Get top 150 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_whole_title150, filenamestem = "poetry150_alt")

# Get top 200 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_whole_title200, filenamestem = "poetry200_alt")


# NOW. AGAIN. But with title only
# Get top 50 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_title_only50, filenamestem = "poetry50_alt_title")

# Get top 100 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_title_only100, filenamestem = "poetry100_alt_title")

# Get top 150 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_title_only150, filenamestem = "poetry150_alt_title")

# Get top 200 freq of poetry
qqq <- run_rf_once(df=df.estc, features=feats_poetry_title_only200, filenamestem = "poetry200_alt_title")


# Get an aggregated table (alt, whole title)
pattern <- "^poetry[0-9]+_alt_confusionMatrix_combined.txt"
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern)
names_ret <- str_extract(string=names(ret), pattern="[0-9]+")
names(ret) <- names_ret
png(filename = paste0(outputpath, "/poetry_values_alt_whole_title.png"), width = 2000)
grid.table(ret)
dev.off()

# Get an aggregated table (alt, title only)
pattern <- "^poetry[0-9]+_alt_title_confusionMatrix_combined.txt"
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern)
names_ret <- str_extract(string=names(ret), pattern="[0-9]+")
names(ret) <- names_ret
png(filename = paste0(outputpath, "/poetry_values_alt_title_only.png"), width = 2000)
grid.table(ret)
dev.off()

# Get an aggregated table (alt + regular)
pattern <- "^poetry[0-9]+_(alt_title_)?confusionMatrix_combined.txt"
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern)
names_ret <- str_extract(string=names(ret), pattern="[0-9]+_(alt)?")
names(ret) <- names_ret
png(filename = paste0(outputpath, "/poetry_values_alt_vs_regular.png"), width = 2000)
grid.table(ret)
dev.off()

# Get an aggregated table (alt, whole title vs. title only)
pattern <- "^poetry[0-9]+_alt_(title_)?confusionMatrix_combined.txt"
filepath <- outputpath

ret <- aggregate_aggregated_cm(filepath=filepath, pattern=pattern)
names_ret <- str_replace(string=names(ret), pattern="^poetry([0-9]+)_alt_(title)?.*", replacement="\\1\\2")
names(ret) <- names_ret
png(filename = paste0(outputpath, "/poetry_values_alt_wholetitle_versus_titleonly.png"), width = 2000)
grid.table(ret)
dev.off()


#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_

#*_*_*_*_*_*_*_*_*_*_*_*_*     TODO

#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
#*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_

## 1. KNN
# https://www.analyticsvidhya.com/blog/2015/08/learning-concept-knn-algorithms-programming/

## 2. OneR
# https://cran.r-project.org/web/packages/OneR/vignettes/OneR.html


## 3. ROC curves (Cutoffs)

## 4. Automated comparison pics

## 5. Fringe genres

## 6. Automating the actually best features

## 7. H-measure
# https://cran.r-project.org/web/packages/hmeasure/hmeasure.pdf

## 8. Strobl: unbiased RF variable metrics

## 9. Effect of sample size

## 10. Automate several methods on the same data
  # http://machinelearningmastery.com/compare-the-performance-of-machine-learning-algorithms-in-r/



qqq <- run_all_once(df=df.estc, features = feats_poetry_whole_title100, k=7, oner_method="infogain", filenamestem = "ALL_poetry100")

qqq2 <- run_all_once(df=df.estc, features = feats_poetry_whole_title150, k=7, oner_method="infogain", filenamestem = "ALL_poetry150")

qqq3 <- run_all_once(df=df.estc, features = feats_poetry_whole_title200, k=7, oner_method="infogain", filenamestem = "ALL_poetry200")

feats_poetry200 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title200_20170511.RDS"))
feats_poetry200$is_poetry <- feats$is_poetry
qqq <- run_all_once(df=df, features=feats_poetry200, filenamestem = "ALL_20170609_poetry200", k=7,startpoint = 1)

feats_poetry_whole_title150_alt <- readRDS(paste0(bu_path, "/feats_poetry_whole_title_alt_150_20170531.RDS"))
qqq <- run_all_once(df=df, features=feats_poetry, filenamestem = "ALL_20170608_alt_poetry150", k=7,startpoint = 10)


# WHILE IN MALMÖ
feats_poetry_whole_title25 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title25_20170618.RDS"))
qqq <- run_caret_rf_once(df=df, features=feats_poetry_whole_title25, filenamestem = "Poetry25_20170619b", get_pairwise_comparison = TRUE)

feats_poetry_whole_title50 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title50_20170618.RDS"))
qqq <- run_caret_rf_once(df=df, features=feats_poetry_whole_title50, filenamestem = "Poetry50_20170619b", get_pairwise_comparison = TRUE)

feats_poetry_whole_title100 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title100_20170618.RDS"))
qqq <- run_caret_rf_once(df=df, features=feats_poetry_whole_title100, filenamestem = "Poetry100_20170619b", get_pairwise_comparison = TRUE)

feats_poetry_whole_title200 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title200_20170618.RDS"))
qqq <- run_caret_rf_once(df=df, features=feats_poetry_whole_title200, filenamestem = "Poetry200_20170619b", get_pairwise_comparison = TRUE)

feats_poetry_whole_title300 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title300_20170618.RDS"))
qqq <- run_caret_rf_once(df=df, features=feats_poetry_whole_title300, filenamestem = "Poetry300_20170619b", get_pairwise_comparison = TRUE)


# Back in Helsinki
# Start with mtry & ntree variants
feats_poetry_whole_title25 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title25_20170618.RDS"))
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree250_mtry5", ntree = 250, mtry=5)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree250_mtry10", ntree = 250, mtry=10)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree250_mtry15", ntree = 250, mtry=15)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree500_mtry5", ntree = 500, mtry=5)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree500_mtry10", ntree = 500, mtry=10)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree500_mtry15", ntree = 500, mtry=15)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree750_mtry5", ntree = 750, mtry=5)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree750_mtry10", ntree = 750, mtry=10)
qqq <- run_rf_once(df=df, features=feats25, language="eng", filenamestem = "poetry25_ntree750_mtry15", ntree = 750, mtry=15)

feats_poetry_whole_title50 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title50_20170618.RDS"))
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree250_mtry5", ntree = 250, mtry=5)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree250_mtry10", ntree = 250, mtry=10)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree250_mtry15", ntree = 250, mtry=15)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree500_mtry5", ntree = 500, mtry=5)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree500_mtry10", ntree = 500, mtry=10)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree500_mtry15", ntree = 500, mtry=15)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree750_mtry5", ntree = 750, mtry=5)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree750_mtry10", ntree = 750, mtry=10)
qqq <- run_rf_once(df=df, features=feats50, language="eng", filenamestem = "poetry50_ntree750_mtry15", ntree = 750, mtry=15)

feats_poetry_whole_title100 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title100_20170618.RDS"))
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree250_mtry5", ntree = 250, mtry=5)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree250_mtry10", ntree = 250, mtry=10)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree250_mtry15", ntree = 250, mtry=15)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree500_mtry5", ntree = 500, mtry=5)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree500_mtry10", ntree = 500, mtry=10)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree500_mtry15", ntree = 500, mtry=15)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree750_mtry5", ntree = 750, mtry=5)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree750_mtry10", ntree = 750, mtry=10)
qqq <- run_rf_once(df=df, features=feats100, language="eng", filenamestem = "poetry100_ntree750_mtry15", ntree = 750, mtry=15)

feats_poetry_whole_title200 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title200_20170618.RDS"))
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree250_mtry5", ntree = 250, mtry=5)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree250_mtry10", ntree = 250, mtry=10)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree250_mtry15", ntree = 250, mtry=15)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree500_mtry5", ntree = 500, mtry=5)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree500_mtry10", ntree = 500, mtry=10)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree500_mtry15", ntree = 500, mtry=15)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree750_mtry5", ntree = 750, mtry=5)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree750_mtry10", ntree = 750, mtry=10)
qqq <- run_rf_once(df=df, features=feats200, language="eng", filenamestem = "poetry200_ntree750_mtry15", ntree = 750, mtry=15)

feats_poetry_whole_title300 <- readRDS(paste0(bu_path, "/feats_poetry_whole_title300_20170618.RDS"))
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree250_mtry5", ntree = 250, mtry=5)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree250_mtry10", ntree = 250, mtry=10)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree250_mtry15", ntree = 250, mtry=15)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree500_mtry5", ntree = 500, mtry=5)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree500_mtry10", ntree = 500, mtry=10)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree500_mtry15", ntree = 500, mtry=15)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree750_mtry5", ntree = 750, mtry=5)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree750_mtry10", ntree = 750, mtry=10)
qqq <- run_rf_once(df=df, features=feats300, language="eng", filenamestem = "poetry300_ntree750_mtry15", ntree = 750, mtry=15)




