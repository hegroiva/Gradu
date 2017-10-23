make_all_pics <- function() {
  
  # ALT VS REGULAR POETRY
  # This fails and is unnecessary
#  make_pic_comparison_lines(filepath=outputpath, 
#                            inputfile_patterns = c("poetry((50)|(100)|(200))_ntree250_mtry5_.*combined_no_cutoff.txt",
#                                                   "poetry((50)|(100)|(200))_whole_title_alt_ntree250_mtry5_.*combined_no_cutoff.txt") , 
#                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
#                            outputfile = "Effect of different methods in deciding the poetry words 50-200", 
#                            main_title = "Effect of different methods for deciding the poetry words, ntree = 250, mtry=5", 
#                            sub_title = "Features: 50, 100, 200 most common words in poetry book titles",
#                            x_title = "", 
#                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
#                            x_tick_labels = c("50", "100", "200"), 
#                            x_tick_breaks = c(50, 100, 200),
#                            legend_title_parentheses=c("Method 1", "Method 2"))
  
  
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
#  make_pic_comparison_lines(filepath=outputpath, 
#                            inputfile_patterns = c("pos_((50per50)|(100per100)|(200per200)|(500per500))_whole_title_.*combined_no_cutoff.txt",
#                                                   "pos_((50per50)|(100per100)|(200per200)|(500per500))_title_only_.*combined_no_cutoff.txt") , 
#                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
#                            outputfile = "Effect of title definition on POS trigrams", 
#                            main_title = "Effect of title definition on POS trigrams, ntree = 250, mtry=5", 
#                            sub_title = "Features: 50, 100, 200, 500 most common POS trigrams",
#                            x_title = "", 
#                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
#                            x_tick_labels = c("50/50", "100/100", "200/200", "500/500"), 
#                            x_tick_breaks = c(50, 100, 200, 500),
#                            legend_title_parentheses=c("Whole title", "Title only"))

  # EFFECT OF EXCLUSION CORPUS ON POS TRIGRAMS
#  make_pic_comparison_lines(filepath=outputpath, 
#                            inputfile_patterns = c("pos_((100per50)|(100per100)|(100per200))_whole_title_.*combined_no_cutoff.txt") , 
#                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
#                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 100", 
#                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
#                            sub_title = "Features: 100 most common POS trigrams",
#                            x_title = "", 
#                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
#                            x_tick_labels = c("50", "100", "200"), 
#                            x_tick_breaks = c(50, 100, 200))
  
#  make_pic_comparison_lines(filepath=outputpath, 
#                            inputfile_patterns = c("pos_((200per200)|(200per500))_whole_title_.*combined_no_cutoff.txt") , 
#                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
#                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 200", 
#                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
#                            sub_title = "Features: 200 most common POS trigrams",
#                            x_title = "", 
#                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
#                            x_tick_labels = c("200", "500"), 
#                            x_tick_breaks = c(200, 500))
  
#  make_pic_comparison_lines(filepath=outputpath, 
#                            inputfile_patterns = c("pos_((50per50)|(50per100))_whole_title_.*combined_no_cutoff.txt") , 
#                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
#                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 50", 
#                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
#                            sub_title = "Features: 50 most common POS trigrams",
#                            x_title = "", 
#                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
#                            x_tick_labels = c("50", "100"), 
#                            x_tick_breaks = c(50, 100))
  
#  make_pic_comparison_lines(filepath=outputpath, 
#                            inputfile_patterns = c("pos_((500per500)|(500per1000))_whole_title_.*combined_no_cutoff.txt") , 
#                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
#                            outputfile = "Effect of size of the exclusion corpus on POS trigrams 500", 
#                            main_title = "Effect of size of the exclusion corpus on POS trigrams, ntree = 250, mtry=5", 
#                            sub_title = "Features: 500 most common POS trigrams",
#                            x_title = "", 
#                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
#                            x_tick_labels = c("500", "1000"), 
#                            x_tick_breaks = c(500, 1000))
  
#  arrange_pics(images=c("Effect of size of the exclusion corpus on POS trigrams 50.png",
#                        "Effect of size of the exclusion corpus on POS trigrams 100.png",
#                        "Effect of size of the exclusion corpus on POS trigrams 200.png",
#                        "Effect of size of the exclusion corpus on POS trigrams 500.png"),
#               filepath="Effect of size of the exclusion crpus in POS trigrams ALL.png",
#               columns=2,
#               rows=2)
  
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
  # Effect of mtry and ntree
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
  
  # Effect of number of words in poetry BOW
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry[0-9]+_ntree250_mtry10.*combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of BOW size", 
                            main_title = "Effect of BOW size: Method 1", 
                            sub_title = "Features: 25, 50, 100, 200, 300 most common words in poetry book titles. Ntree = 250, mtry = 10",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("25", "50", "100", "200", "300"), 
                            x_tick_breaks = c(25, 50, 100, 200, 300),
                            legend_title_parentheses=c(""))
  
  # The same for alt
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry[0-9]+_whole_title_alt_ntree250_mtry10.*no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy"), 
                            outputfile = "Effect of BOW size alt", 
                            main_title = "Effect of BOW size: Method 2", 
                            sub_title = "Features: 25, 50, 100, 200, 300 most common words in poetry book titles. Ntree = 250, mtry = 10",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy"), 
                            x_tick_labels = c("25", "50", "100", "200", "300"), 
                            x_tick_breaks = c(25, 50, 100, 200, 300),
                            legend_title_parentheses=c(""))
  
  # The same for alt, main title
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("poetry[0-9]+_title_only_alt_ntree250_mtry10.*no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy", "f1"), 
                            outputfile = "Effect of BOW size alt title only", 
                            main_title = "Effect of BOW size: Method 3", 
                            sub_title = "Features: 25, 50, 100, 200, 300 most common words in poetry book titles. Ntree = 250, mtry = 10",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                            x_tick_labels = c("25", "50", "100", "200", "300"), 
                            x_tick_breaks = c(25, 50, 100, 200, 300),
                            legend_title_parentheses=c(""))
  # POS tags
  # check which POS is the best
  make_pic_comparison_bars(filepath=outputpath, 
                            inputfile_patterns = c("pos_caret_whole_title.*_mtry10__measures.txt",
                                                   "pos_caret_title_only.*_mtry10__measures.txt") , 
                            parameter_names = c("H", "Precision", "Recall", "F"), 
                            group_names = c("Whole title", "Title only"),
                            outputfile = "Qualification - POS tags", 
                            main_title = "Qualification - POS tags", 
                            sub_title = "Features: POS tags from the title, subtitle included or excluded",
                            x_title = "", 
                            y_title = "",
                            legend_labels = c("H", "Precision", "Recall", "F1"), 
                            #x_tick_labels = c("Main title only", "Whole title"), 
                            #x_tick_breaks = c(1,2),
                            legend_title_parentheses=c(""),
                           total_width = 700,
                           space_between_bars = 0.1)
  # POS tags II
  # check which mtry is the best
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_whole_title_ntree250_mtry5_confusionMatrix_combined_no_cutoff.txt",
                                                  "pos_whole_title_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                           group_names = c("Mtry 5", "Mtry 10"),
                           outputfile = "Qualification - POS tags and the effect of mtry", 
                           main_title = "Qualification - POS tags and the effect of mtry", 
                           sub_title = "Features: POS tags from the whole title",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                           #x_tick_labels = c("Mtry 5", "Mtry 10"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""), 
                           total_width = 700,
                           space_between_bars = 0.1,
                           newschool = TRUE)
  # POS trigrams
  # check which POS trigrams are the best
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_trigrams_caret_whole_title.*_mtry10__measures.txt",
                                                  "pos_trigrams_caret_title_only.*_mtry10__measures.txt") , 
                           parameter_names = c("H", "Precision", "Recall", "F"), 
                           group_names = c("Whole title", "Title only"),
                           outputfile = "Qualification - POS trigrams", 
                           main_title = "Qualification - POS trigrams", 
                           sub_title = "Features: POS trigrams from the title, subtitle included or excluded",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("H", "Precision", "Recall", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width = 700,
                           space_between_bars = 0.1)
  # POS trigrams II
  # check which mtry is the best
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_trigrams_whole_title_ntree250_mtry5_confusionMatrix_combined_no_cutoff.txt",
                                                  "pos_trigrams_whole_title_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                           group_names = c("Mtry 5", "Mtry 10"),
                           outputfile = "Qualification - POS trigrams and the effect of mtry", 
                           main_title = "Qualification - POS trigrams and the effect of mtry", 
                           sub_title = "Features: POS trigrams from the whole title",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                           #x_tick_labels = c("Mtry 5", "Mtry 10"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width = 700,
                           space_between_bars = 0.1,
                           newschool = TRUE)

  # POS vs. POS trigrams
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_caret_whole_title_ntree250_mtry10__measures.txt",
                                                  "pos_trigrams_caret_whole_title_ntree250_mtry10__measures.txt") , 
                           parameter_names = c("H", "Precision", "Recall", "F"), 
                           group_names = c("POS tags", "POS trigrams"),
                           outputfile = "POS tags versus POS trigrams", 
                           main_title = "POS tags versus POS trigrams", 
                           sub_title = "Mtry values 10, ntree 250",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("H", "Precision", "Recall", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width = 700,
                           space_between_bars = 0.1
                           )
  
  # Bow6 vs. bow15 vs. bow19
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("basic_bow6_caret_whole_title_ntree250_mtry10__measures.txt",
                                                  "basic_bow15_caret_whole_title_ntree250_mtry10__measures.txt",
                                                  "basic_bow19_caret_whole_title_ntree250_mtry10__measures.txt") , 
                           parameter_names = c("H", "Precision", "Recall", "F"), 
                           group_names = c("Bow6", "Bow15", "Bow19"),
                           outputfile = "Bow size", 
                           main_title = "Bow size", 
                           sub_title = "Mtry values 10, ntree 250",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("H", "Precision", "Recall", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width = 700,
                           space_between_bars = 0.1
                           )
  
  # Basic_bow19 + additionals
  #make_pic_comparison_bars(filepath=outputpath, 
  #                         inputfile_patterns = c("basic_bow19_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
  #                                                "basic_bow19_stopmarks_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
  #                                                "basic_bow19_antique_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
  #                                                "basic_bow19_marc_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
  #                                                "basic_bow19_nlp_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt") , 
  #                         parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
  #                         group_names = c("Vanilla", "with stopmarks", "with antique", "with MARC", "with NLP"),
  #                         outputfile = "Basic Bow and additions", 
  #                         main_title = "Basic, Bag-of-words, and additions", 
  #                         sub_title = "Mtry values 10, ntree 250",
  #                         x_title = "", 
  #                         y_title = "",
  #                         legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
  #                         #x_tick_labels = c("Main title only", "Whole title"), 
  #                         #x_tick_breaks = c(1,2),
  #                         legend_title_parentheses=c(""),
  #                         total_width=850,
  #                         space_between_bars = 0.15,
  #                         newschool = TRUE)
  # Qualification comparison
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("pos_caret_whole_title_ntree250_mtry10__measures.txt",
                                                  "pos_trigrams_caret_whole_title_ntree250_mtry10__measures.txt",
                                                  "nlp_caret_ntree250_mtry4__measures.txt",
                                                  "poetry100caret_whole_title_alt_ntree250_mtry10_B__measures.txt",
                                                  "topic100_caret_ntree250_mtry10__measures.txt") , 
                           parameter_names = c("H", "Precision", "Recall", "F"), 
                           group_names = c("POS tags", "POS trigrams", "Dependency relation", "Poetry100", "Topic"),
                           outputfile = "QualificationComparison", 
                           main_title = "Comparison of different predictor sets", 
                           sub_title = "Mtry values 10, ntree 250, except for dependency relations mtry=4",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("H", "Precision", "Recall", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width = 1000,
                           space_between_bars = 0.15)  
  
  # Qualification comparison for NLP
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("basic_bow19_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
                                                  "basic_bow19_nlp1_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
                                                  "basic_bow19_nlp4_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
                                                  "basic_bow19_NLP7_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                           group_names = c("without NLP", "with NLP1", "with NLP4", "with NLP7"),
                           outputfile = "QualificationNLPComparison", 
                           main_title = "Basic, Bag-of-words and NLP bunches", 
                           sub_title = "Mtry values 10, ntree 250",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width=1000,
                           space_between_bars = 0.15,
                           newschool = TRUE)
  
  
  # Basic + Bow19 + additions comparison
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("basic_bow19_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
                                                  "basic_bow19_punctuation_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
                                                  "basic_bow19_antique_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
                                                  "basic_bow19_marc_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt",
                                                  "basic_bow19_NLP7_ntree250_mtry10_confusionMatrix_combined_no_cutoff.txt") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                           group_names = c("no additions", "with punctuation", "with antique", "with MARC", "with NLP"),
                           outputfile = "Basic_Bow19_and_additions", 
                           main_title = "Features: Basic, Bag-of-words19 and additions", 
                           sub_title = "Mtry values 10, ntree 250",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width=1000,
                           space_between_bars = 0.15,
                           newschool = TRUE)  

  
  
  # Effect of split size
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("FINAL_split[0-9]+_confusionMatrix_combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                            outputfile = "Effect of final split", 
                            main_title = "Effect of training set size (in percentages)", 
                            sub_title = "Final feature set: Ntree=250, mtry=10",
                            x_title = "", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                            x_tick_labels = c("10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"), 
                            x_tick_breaks = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100),
                            legend_title_parentheses=c(""),
                            newschool=TRUE,
                            highlight_max = c(FALSE, FALSE, TRUE, TRUE),
                            plot_width = 1000)

  
  # Effect of mtry on final features
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("FINAL_mtry[0-9]+_confusionMatrix_combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                            outputfile = "Effect of final mtry", 
                            main_title = "Effect of mtry", 
                            sub_title = "Final feature set: Ntree=250, full training set",
                            x_title = "Mtry value", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                            x_tick_labels = c("3", "4", "5", "6", "7", "8", "9", "10", "11",
                                              "12", "13", "14", "15", "16", "17", "18", "19", "20",
                                              "25", "30", "35", "40", "45", "50"), 
                            x_tick_breaks = c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 25, 30, 35, 40, 45, 50),
                            legend_title_parentheses=c(""),
                            newschool=TRUE,
                            plot_width=1500,
                            highlight_max = c(FALSE, FALSE, TRUE, TRUE))
  
  # Effect of ntree on final features
  make_pic_comparison_lines(filepath=outputpath, 
                            inputfile_patterns = c("FINAL_ntree[0-9]+_confusionMatrix_combined_no_cutoff.txt") , 
                            parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                            outputfile = "Effect of final ntree", 
                            main_title = "Effect of ntree", 
                            sub_title = "Final feature set: Mtry=10, full training set",
                            x_title = "Ntree values", 
                            legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                            x_tick_labels = c("50", "100", "150", "200", "250", "300", 
                                              "400", "500", "750", "1000"), 
                            x_tick_breaks = c(50, 100, 150, 200, 250, 300, 400, 500, 750, 1000),
                            legend_title_parentheses=c(""),
                            newschool=TRUE,
                            plot_width = 1000,
                            highlight_max = c(FALSE, FALSE, TRUE, TRUE))

  # Compare cross-validated 100% vs. 50/50 split
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("FINAL_split100_confusionMatrix_combined_no_cutoff.txt",
                                                  "^FINALFINALconfusionMatrix_combined_no_cutoff.txt") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                           group_names = c("cross-validated 80/20", "split 50/50"),
                           outputfile = "FINALFINAL", 
                           main_title = "Features: final set", 
                           sub_title = "Mtry=18, ntree=250",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width=700,
                           space_between_bars = 0.15,
                           newschool = TRUE)    
  
  # FINAL: random forest vs. SVM vs. others
  make_pic_comparison_bars(filepath=outputpath, 
                           inputfile_patterns = c("FINAL_split100",
                                                  "FINAL_svm",
                                                  "FINAL_PART",
                                                  "FINAL_C45",
                                                  "FINAL_naivebayes") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                           group_names = c("random forest", "SVM", "PART", "C45", "Naive Bayes"),
                           outputfile = "FINAL_MethodComparison", 
                           main_title = "Features: final set (optimized for random forest)", 
                           sub_title = "",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width=1200,
                           space_between_bars = 0.15,
                           newschool = TRUE)    
  
  
  make_pic_comparison_bars_multiclass(filepath=outputpath, 
                                      inputfile_patterns = c("FINAL_split100",
                                                             "FINAL_hc_prevails1",
                                                             "FINAL_hc_prevails2",
                                                             "FINAL_fringe_prevails1",
                                                             "FINAL_fringe_prevails2") , 
                           parameter_names = c("precision", "recall", "balanced_accuracy", "F1"), 
                           group_names = c("Standard definition", "HC prevails1", "HC prevails2", "Fringe prevails1", "Fringe prevails2"),
                           outputfile = "FINAL_is_poetry_comparison", 
                           main_title = "Features: final set, different poetry declaration", 
                           sub_title = "",
                           x_title = "", 
                           y_title = "",
                           legend_labels = c("Precision", "Recall", "Balanced accuracy", "F1"), 
                           #x_tick_labels = c("Main title only", "Whole title"), 
                           #x_tick_breaks = c(1,2),
                           legend_title_parentheses=c(""),
                           total_width=1200,
                           space_between_bars = 0.15,
                           newschool = TRUE)    
  
}


