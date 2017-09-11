make_all_pics <- function() {
  
  # ALT VS REGULAR POETRY
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry((50)|(100)|(200))_ntree250_mtry5_.*combined_no_cutoff.txt",
                                                   "poetry((50)|(100)|(200))_whole_title_alt_ntree250_mtry5_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of different methods in deciding the poetry words", 
                            main_title = "Effect of different methods for deciding the poetry words, ntree = 250, mtry=5", 
                            sub_title = "Features: 25, 50, 100, 200, 300 most common words in poetry book titles",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("25", "50", "100", "200", "300"), 
                            x_tick_breaks = c(25, 50, 100, 200, 300),
                            legend_title_parentheses=c("Method 1", "Method 2"))
  
  
  # ALT VS REGULAR INCLUDING TITLE ONLY
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry((50)|(100)|(200))_ntree250_mtry5_.*combined_no_cutoff.txt",
                                                   "poetry((50)|(100)|(200))_whole_title_alt_ntree250_mtry5_.*combined_no_cutoff.txt",
                                                   "poetry((50)|(100)|(200))_title_only_alt_ntree250_mtry5_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of different methods in deciding the poetry words incl title only", 
                            main_title = "Effect of different methods for deciding the poetry words, ntree = 250, mtry=5", 
                            sub_title = "Features: 25, 50, 100, 200, 300 most common words in poetry book titles",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("25", "50", "100", "200", "300"), 
                            x_tick_breaks = c(25, 50, 100, 200, 300),
                            legend_title_parentheses=c("Method 1", "Method 2", "Method 3"))
  
  
  # POS TRIGRAMS
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

  # EFFECT OF EXCLUSION CORPUS ON POS TRIGRAMS
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("pos_((100per50)|(100per100)|(100per200))_whole_title_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 100", 
                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
                            sub_title = "Features: 100 most common POS trigrams",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("50", "100", "200"), 
                            x_tick_breaks = c(50, 100, 200))
  
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("pos_((200per200)|(200per500))_whole_title_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 200", 
                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
                            sub_title = "Features: 200 most common POS trigrams",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("200", "500"), 
                            x_tick_breaks = c(200, 500))
  
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("pos_((50per50)|(50per100))_whole_title_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 50", 
                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
                            sub_title = "Features: 50 most common POS trigrams",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("50", "100"), 
                            x_tick_breaks = c(50, 100))
  
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("pos_((500per500)|(500per1000))_whole_title_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 500", 
                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
                            sub_title = "Features: 500 most common POS trigrams",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("500", "1000"), 
                            x_tick_breaks = c(500, 1000))
  
  arrange_pics(images=c("Effect of size of the exclusion corpus on POS trigrams 50.png",
                        "Effect of size of the exclusion corpus on POS trigrams 100.png",
                        "Effect of size of the exclusion corpus on POS trigrams 200.png",
                        "Effect of size of the exclusion corpus on POS trigrams 500.png"),
               filepath="Effect of size of the exclusion crpus in POS trigrams ALL.png",
               columns=2,
               rows=2)
  
  # EFFECT OF NTREE
  # check first which poetry set is the best
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry100_ntree.*_mtry5_.*combined_no_cutoff.txt",
                                                   "poetry100_ntree.*_mtry10_.*combined_no_cutoff.txt",
                                                   "poetry100_ntree.*_mtry15_.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of ntree", 
                            main_title = "Effect of ntree", 
                            sub_title = "Features: 100 most common words in poetry book titles",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("250", "500", "750"), 
                            x_tick_breaks = c(250, 500, 750),
                            legend_title_parentheses=c("Mtry=5", "Mtry=10", "Mtry=15"))
  
  # EFFECT OF MTRY
  # check first which poetry is the best
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry100_ntree250_mtry.*combined_no_cutoff.txt",
                                                   "poetry100_ntree500_mtry.*combined_no_cutoff.txt",
                                                   "poetry100_ntree750_mtry.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of mtry", 
                            main_title = "Effect of mtry", 
                            sub_title = "Features: 100 most common words in poetry book titles",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("5", "10", "15"), 
                            x_tick_breaks = c(5, 10, 15),
                            legend_title_parentheses=c("Ntree=250", "Ntree=500", "Ntree=750"))
  
  # EFFECT OF DIFFERENT SETS
  # check which poetry is the best
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry100_ntree250_mtry.*combined_no_cutoff.txt",
                                                   "poetry100_ntree500_mtry.*combined_no_cutoff.txt",
                                                   "poetry100_ntree750_mtry.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of mtry", 
                            main_title = "Effect of mtry", 
                            sub_title = "Features: 100 most common words in poetry book titles",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("5", "10", "15"), 
                            x_tick_breaks = c(5, 10, 15),
                            legend_title_parentheses=c("Ntree=250", "Ntree=500", "Ntree=750"))
  
  # POS tags
  # check which POS is the best
  make_pic_comparison_bars(filepath=outputpath, 
                            inputfile_patterns = c("pos_caret_whole_title.*_mtry10__measures.txt",
                                                   "pos_caret_title_only.*_mtry10__measures.txt") , 
                            parameter_names = c("H", "Precision", "Recall"), 
                            group_names = c("Whole title", "Title only"),
                            outputfile = "Qualification - POS tags", 
                            main_title = "Qualification - POS tags", 
                            sub_title = "Features: POS tags from the title, subtitle included or excluded",
                            x_title = "", 
                            y_title = "",
                            legend_labels = c("H", "Precision", "Recall"), 
                            #x_tick_labels = c("Main title only", "Whole title"), 
                            #x_tick_breaks = c(1,2),
                            legend_title_parentheses=c(""))
  # POS tags II
  # check which mtry is the best
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_whole_title_ntree250_mtry5_confusionMatrix_combined_no_cutoff.txt",
                                                  "pos_whole_title_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy"), 
                           group_names = c("Mtry 5", "Mtry 10"),
                           outputfile = "Qualification - POS tags and the effect of mtry", 
                           main_title = "Qualification - POS tags and the effect of mtry", 
                           sub_title = "Features: POS tags from the whole title",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                           #x_tick_labels = c("Mtry 5", "Mtry 10"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""), 
                           newschool = TRUE)
  # POS trigrams
  # check which POS trigrams are the best
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_trigrams_caret_whole_title.*_mtry10__measures.txt",
                                                  "pos_trigrams_caret_title_only.*_mtry10__measures.txt") , 
                           parameter_names = c("H", "Precision", "Recall"), 
                           group_names = c("Whole title", "Title only"),
                           outputfile = "Qualification - POS trigrams", 
                           main_title = "Qualification - POS trigrams", 
                           sub_title = "Features: POS trigrams from the title, subtitle included or excluded",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("H", "Precision", "Recall"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""))
  # POS trigrams II
  # check which mtry is the best
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_trigrams_whole_title_ntree250_mtry5_confusionMatrix_combined_no_cutoff.txt",
                                                  "pos_trigrams_whole_title_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy"), 
                           group_names = c("Mtry 5", "Mtry 10"),
                           outputfile = "Qualification - POS trigrams and the effect of mtry", 
                           main_title = "Qualification - POS trigrams and the effect of mtry", 
                           sub_title = "Features: POS trigrams from the whole title",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                           #x_tick_labels = c("Mtry 5", "Mtry 10"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""), 
                           newschool = TRUE)

  # POS vs. POS trigrams
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_caret_whole_title_ntree250_mtry10__measures.txt",
                                                  "pos_trigrams_caret_whole_title_ntree250_mtry10__measures.txt") , 
                           parameter_names = c("H", "Precision", "Recall"), 
                           group_names = c("POS tags", "POS trigrams"),
                           outputfile = "POS tags versus POS trigrams", 
                           main_title = "POS tags versus POS trigrams", 
                           sub_title = "Mtry values 10, ntree 250",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("H", "Precision", "Recall"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""))
}
