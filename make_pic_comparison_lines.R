library(tidyr)
library(ggplot2)
make_pic_comparison_lines <- function(filepath="C:/Users/Hege/Opiskelu/Kurssit/Gradu/Output",
                                      inputfile_patterns=c(""), 
                                      fileprefix,
                                      parameter_names,
                                      outputfile,
                                      legend_title_parentheses=c(""),
                                      main_title="",
                                      sub_title,
                                      x_title="",
                                      legend_labels=c("") {
  # Check that there's a pattern declared
  if (inputfile_patterns==c("")) {
    message("Please fill in inputfile_patterns also.")
    return()
  }
  
  # Get all the values for all the patterns
  # Add letter at the start of the param name just for alphabetic purposes
  rets <- list()
  params <- list()
  letters <- "a":"z"
  for (i in 1:length(inputfile_patterns)) {
    rets[["pattern"]] <- aggregate_aggregated_cm(filepath=filepath, pattern=inputfile_patterns[i])
    for (param in parameter_names) {
      params[[paste0(letters[i], "_", param[i], "_", legend_title_parentheses[i])]] <- (rets[["pattern"],]
    }
  }
#  sensitivity <- c(32.9, 20.2, 15.0)
#  pred_value <- c(24.1, 35.9, 60.1)
#  balanced <- c(63.1, 58.9, 57.2)
#  sensitivity_svm <- c(12.5, 9.5, 5.4)
#  pred_value_svm <- c(75.6, 73.4, 67.3)
#  balanced_svm <- c(56.1, 54.6, 52.6)
#  df_kpl <- data.frame(sensitivity=sensitivity, pred_value=pred_value, balanced=balanced, 
#                       sensitivity_svm=sensitivity_svm, pred_value_svm=pred_value_svm, balanced_svm=balanced_svm)
  
  # Fix this!!!
  df_kpl <- data.frame(matrix(unlist(names(params)), unlist(params), nrow=1, ncol=length(params)))
  rownames(df_kpl) <- as.character(point_values)
  colnames(df_kpl) <- names(params)
  
  #row.names(df_kpl) <- c("50", "100", "200")
  df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)
  
  linetypes <- c("solid", "dashed", "dotted", "longdash", "twodash")[1:length(inputfile_patterns)]
  override.linetype <- vapply(linetypes, FUN=function(linetype) {rep(linetype, length(parameter_names))})
  #override.linetype <- rep("solid", length(inputfile_patterns)) + rep("dashed", length(inputfile_patterns))
  #override.linetype <- c("solid","solid","solid","dashed","dashed","dashed")

  colors <- c("red", "purple", "green", "blue", "brown", "grey", "black", "white")[1:length(parameter_names)]
  override.colour <- rep(colors, length(inputfile_patterns))
  #override.colour <- c("red","purple","green","red","purple","green")
  
  # This is it
  outputfilepath <- paste0(filepath, "/", outputfile, ".png")
  png(filename = outputfilepath, width = 1000)
  p <- ggplot(data=df, aes(x=n)) + 
    theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
          legend.text = element_text(size=14), 
          axis.text.x = element_text(size=12), 
          axis.text.y = element_text(size=12),
          plot.title = element_text(size=20),
          plot.subtitle = element_text(size=14), legend.key.width = unit(3, "cm")
    ) +
    #scale_x_continuous(breaks=df$n, labels=c("50\n51", "100\n24", "200\n8")) +
    scale_x_continuous(breaks=df$n, labels=c(df$n)) +
    scale_y_continuous(labels=scales::percent) +
    #scale_y_continuous(breaks=c(10,20, 30, 40,50,60, 70, 80), labels=c("10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%")) +
    labs(title=main_title, 
         x=x_title, y=y_title, 
         subtitle=sub_title) 
    
  p <- p + unlist(lapply(seq_along(params), FUN=function(param, list, names) {
      # FIX THIS!
      geom_line(aes(y=names(param), col=param, linetype=param), size=1.0)
    }, list=params, names=names(params)))
    
    #geom_line(aes(y=sensitivity, col="asensitivity", linetype="asensitivity"), size=1.0) + 
    #geom_line(aes(y=pred_value, col="bpred_value", linetype="bpred_value"), size=1.0) + 
    #geom_line(aes(y=balanced, col="cbalanced", linetype="cbalanced"), size=1.0) +
    #geom_line(aes(y=sensitivity_svm, col="dsensitivity_svm", linetype="dsensitivity_svm"), size=1.0) + 
    #geom_line(aes(y=pred_value_svm, col="epred_value_svm", linetype="epred_value_svm"), size=1.0) + 
    #geom_line(aes(y=balanced_svm, col="fbalanced_svm", linetype="fbalanced_svm"), size=1.0) +
    #scale_color_manual(values=override.colour)+
  p <- p + scale_linetype_manual(name="", values = override.linetype, labels=legend_labels) +
           scale_color_manual(name="",values = override.colour, labels=legend_labels)

  p <- p + unlist(lapply(seq_along(params), FUN=function(param, list, names) {
    # FIX THIS!
    geom_point(aes(y=names(param)), size=3)
  }, list=params, names=names(params)))
    #geom_point(aes(y=balanced), size=3) +
    #geom_point(aes(y=pred_value), size=3) +
    #geom_point(aes(y=sensitivity), size=3) +
    #geom_point(aes(y=balanced_svm), size=3) +
    #geom_point(aes(y=pred_value_svm), size=3) +
    #geom_point(aes(y=sensitivity_svm), size=3) 
  plot.new()  
  plot(p)
  #text("The number under n represents the remaining number of features after non-poetry POS tags were removed")
  dev.off()
}