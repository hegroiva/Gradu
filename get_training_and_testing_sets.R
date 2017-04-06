get_training_and_testing_sets <- function(df, 
                                          training_percent=50, 
                                          load=TRUE, 
                                          path="C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\Titles\\",
                                          filenamestem="df_") {
  #tagged.training <- tagged[training_inds]
  #training <- df[training_inds,]
  #clean_titles.training <- clean_titles_all[training_inds]
  
  if (load) {
    df.training <- readRDS(paste0(path,filenamestem,".training.RDS"))
    df.testing <- readRDS(paste0(path,filenamestem,".testing.RDS"))
  } else {
    sample_inds <- sample(1:nrow(df), size = ceiling((nrow(df) * training_percent) / 100))
    training_inds <- setdiff(1:nrow(df), sample_inds)
    print(training_inds[1:10])
    df.training <- df[training_inds,]
    df.testing <- df[setdiff(1:nrow(df), training_inds),]
    print(df.training$genre[1:10])
    print(df.testing$genre[1:10])
    saveRDS(df.training, paste0(path, filenamestem, ".training.RDS"))
    saveRDS(df.testing, paste0(path, filenamestem, ".testing.RDS"))
                          
  }
  #test_inds <- setdiff(1:nrow(df.english_genres), training_inds)
  #df.tagged.test <- df.tagged[test_inds]
  #df.genres.test <- df.english_genres[test_inds,]
  #clean_titles.test <- clean_titles_all[test_inds]
  
  #return(list(training=, testing=, clean_titles_training=, clean_titles_testing=))
  return(list(training=df.training, testing=df.testing))
}