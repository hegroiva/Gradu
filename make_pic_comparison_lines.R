library(tidyr)
library(ggplot2)
make_pic_comparison_lines <- function(filepath,
                                      inputfile_patterns=c(""), 
                                      parameter_names,
                                      outputfile,
                                      legend_title_parentheses=c(""),
                                      main_title="",
                                      sub_title,
                                      x_title="",
                                      y_title="",
                                      legend_labels=c(""),
                                      x_tick_labels=c("")) {
  # Check that there's a pattern declared
  if (identical(inputfile_patterns,c(""))) {
    message("Please fill in inputfile_patterns also.")
    return()
  }
  
  # Get all the values for all the patterns
  # Add letter at the start of the param name just for alphabetic purposes
  rets <- list()
  for (i in 1:length(inputfile_patterns)) {
    rets[["pattern"]] <- aggregate_aggregated_cm(filepath=filepath, pattern=inputfile_patterns[i])
    params <- data.frame(matrix(ncol=length(parameter_names), nrow=length(rets[["pattern"]])),stringsAsFactors = FALSE)
    names(params) <- paste0(letters[i], "_", parameter_names)
    #message(names(params))
    for (param in parameter_names) {
      params[paste0(letters[i], "_", param)] <- as.numeric(t(rets[["pattern"]][param,]))
    }
    if (i == 1) {
      all_params <- params
    } else {
      all_params <- cbind(all_params, params)
    }
  }
    # Fix this!!!
#  df_kpl <- data.frame(matrix(unlist(names(params)), unlist(params), nrow=1, ncol=length(params)))
  df_kpl <- all_params
  #rownames(df_kpl) <- as.character(point_values)
  colnames(df_kpl) <- names(all_params)
  
  row.names(df_kpl) <- 1:length(x_tick_labels)
  df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)
  
  linetypes <- c("solid", "dashed", "dotted", "longdash", "twodash")[1:length(inputfile_patterns)]
  override.linetype <- unlist(lapply(linetypes, FUN=function(linetype) {rep(linetype, length(parameter_names))}))

  colors <- c("red", "purple", "green", "blue", "brown", "grey", "black", "white", "yellow")[1:length(parameter_names)]
  override.colour <- rep(colors, length(inputfile_patterns))

  # This is it
  outputfilepath <- paste0(filepath, "/", outputfile, ".png")
  png(filename = outputfilepath, width = 200 * length(x_tick_labels))
  p <- ggplot(data=df, aes(x=n)) + 
    theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
          legend.text = element_text(size=14), 
          axis.text.x = element_text(size=12), 
          axis.text.y = element_text(size=12),
          plot.title = element_text(size=20),
          plot.subtitle = element_text(size=14), legend.key.width = unit(3, "cm")
    ) +
    scale_x_continuous(breaks=df$n, labels=x_tick_labels) +
    scale_y_continuous(labels=scales::percent) +
    labs(title=main_title, 
         x=x_title, y=y_title, 
         subtitle=sub_title) 
    
  for (j in 1:length(all_params)) {
    if (length(inputfile_patterns) > 1) {
      p <- p + geom_line(aes_string(y=names(all_params)[j], col=shQuote(letters[j]), linetype=shQuote(letters[j])))
    } else {
      p <- p + geom_line(aes_string(y=names(all_params)[j], col=shQuote(override.colour[j])))
    }
  } 
  
  final_legend_labels <- character(length(legend_title_parentheses) * length(legend_labels))
  l <- 1
  for (j in 1:length(legend_title_parentheses)) {
    for (k in 1:length(legend_labels)) {
      final_legend_labels[l] <- paste0(legend_labels[k], "  (", legend_title_parentheses[j], ")")
      l <- l + 1
    }
  }
  p <- p + scale_linetype_manual(name="", values = override.linetype, labels=final_legend_labels)
  p <- p + scale_color_manual(name="",values = override.colour, labels=final_legend_labels)
  
  for (j in 1:nrow(all_params)) {
    for (k in 1:length(all_params)) {
      p <- p + geom_point(aes_string(y=names(all_params[k])), size=3)
    }
  }
  plot.new()  
  plot(p)
  dev.off()
}