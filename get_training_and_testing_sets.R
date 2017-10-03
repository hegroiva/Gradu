get_training_and_testing_sets <- function(features, 
                                          training_percent=50, 
                                          load=TRUE, 
                                          path="",
                                          filenamestem="df_") {
	if (path == "") {
		path <- paste0(bu_path, "/Titles/")
	}
  #tagged.training <- tagged[training_inds]
  #training <- df[training_inds,]
  #clean_titles.training <- clean_titles_all[training_inds]
  
  if (load) {
    features.training <- readRDS(paste0(path,filenamestem,".training.RDS"))
    features.testing <- readRDS(paste0(path,filenamestem,".testing.RDS"))
    training_inds <- readRDS(paste0(path, filenamestem, ".training_inds.RDS"))
  } else {
    sample_inds <- sample(1:nrow(features), size = ceiling((nrow(features) * training_percent) / 100))
    testing_inds <- setdiff(1:nrow(features), sample_inds)
    #print(training_inds[1:10])
#    features.training <- features[training_inds,]
#    features.testing <- features[setdiff(1:nrow(features), training_inds),]
    features.training <- features[sample_inds,]
    features.testing <- features[testing_inds,]
        #print(df.training$genre[1:10])
    #print(df.testing$genre[1:10])
    #saveRDS(features.training, paste0(path, filenamestem, ".training.RDS"))
    #saveRDS(features.testing, paste0(path, filenamestem, ".testing.RDS"))
    #saveRDS(training_inds, paste0(path, filenamestem, ".training_inds.RDS"))
                          
  }
  #test_inds <- setdiff(1:nrow(df.english_genres), training_inds)
  #df.tagged.test <- df.tagged[test_inds]
  #df.genres.test <- df.english_genres[test_inds,]
  #clean_titles.test <- clean_titles_all[test_inds]
  
  #return(list(training=, testing=, clean_titles_training=, clean_titles_testing=))
  return(list(training=features.training, testing=features.testing, training_inds=sample_inds))
}