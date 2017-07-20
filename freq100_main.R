saveRDS(qqq2, paste0(bu_path, "/feats_freq100_probably.RDS"))

# Run against most common 100 words
www <- mapply(feats_freq100[,1:100], FUN=function(x) {y <- x / features_all$no_of_words; y})
qqq <- data.frame(www)
qqq2 <- cbind(qqq, is_poetry=features_all$is_poetry)
df <- features_all
qqq <- run_rf_once(features=qqq2, df=df, language="eng", filenamestem="freq100_bunch", ntree=500, mtry=5)

feats_common_bunch <- data.frame(bunch1 = rowSums(qqq2[,1:10]),
                                 bunch2 = rowSums(qqq2[,11:20]),
                                 bunch3 = rowSums(qqq2[,21:30]),
                                 bunch4 = rowSums(qqq2[,31:40]),
                                 bunch5 = rowSums(qqq2[,41:50]),
                                 bunch6 = rowSums(qqq2[,51:60]),
                                 bunch7 = rowSums(qqq2[,61:70]),
                                 bunch8 = rowSums(qqq2[,71:80]),
                                 bunch9 = rowSums(qqq2[,81:90]),
                                 bunch10 = rowSums(qqq2[,91:100]),
                                 is_poetry = qqq2$is_poetry)
qqq <- run_rf_once(features=feats_common_bunch, df=df, language="eng", filenamestem="freq100_bunch", ntree=500, mtry=5)

q <- list()
feats_common_existing <- for (i in 1:(length(qqq2)-1)) {
  q[i] <- lapply(qqq2[,i], FUN=function(x) {x[x!=0] <- 1; x})
}
