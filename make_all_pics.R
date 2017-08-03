make_all_pics <- function() {
  
  # PIC OF ALT VS REGULAR POETRY
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry((50)|(100)|(200))_ntree250_mtry5_.*combined_no_cutoff.txt",
                                                   "poetry((50)|(100)|(200))_whole_title_alt_ntree250_mtry5_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of different methods in deciding the poetry words", 
                            main_title = "Effect of different methods for deciding the poetry words, ntree = 250, mtry=5", 
                            sub_title = "Features: 50, 100, 200 most common words in poetry book titles",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("50", "100", "200"), 
                            x_tick_breaks = c(50, 100, 200),
                            legend_title_parentheses=c("Method 1", "Method 2"))
  
  
  # PIC OF ALT VS REGULAR INCLUDING TITLE ONLY
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry((50)|(100)|(200))_ntree250_mtry5_.*combined_no_cutoff.txt",
                                                   "poetry((50)|(100)|(200))_whole_title_alt_ntree250_mtry5_.*combined_no_cutoff.txt",
                                                   "poetry((50)|(100)|(200))_title_only_alt_ntree250_mtry5_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of different methods in deciding the poetry words incl title only", 
                            main_title = "Effect of different methods for deciding the poetry words, ntree = 250, mtry=5", 
                            sub_title = "Features: 50, 100, 200 most common words in poetry book titles",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("50", "100", "200"), 
                            x_tick_breaks = c(50,100, 200),
                            legend_title_parentheses=c("Method 1", "Method 2", "Method 3"))
  
  
  
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("pos_((50per50)|(100per100)|(200per200)|(500per500))_whole_title_.*combined_no_cutoff.txt",
                                                   "pos_((50per50)|(100per100)|(200per200)|(500per500))_title_only_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of title definition on POS trigrams", 
                            main_title = "Effect of title definition on POS trigrams, ntree = 250, mtry=5", 
                            sub_title = "Features: 50, 100, 200, 500 most common POS trigrams",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("50/50", "100/100", "200/200", "500/500"), 
                            x_tick_breaks = c(50, 100, 200, 500),
                            legend_title_parentheses=c("Whole title", "Title only"))
}