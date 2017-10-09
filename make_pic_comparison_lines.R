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
                                      x_tick_labels=c(""),
                                      x_tick_breaks=c(""),
                                      newschool=FALSE,
                                      plot_width=NULL,
                                      highlight_max=c("")){
  # Check that there's a pattern declared
  if (identical(inputfile_patterns,c(""))) {
    message("Please fill in inputfile_patterns also.")
    return()
  }

  if (identical(highlight_max,c(""))) {
    highlight_max <- rep(FALSE, length(parameter_names))
  }
  # Get all the values for all the patterns
  # Add letter at the start of the param name just for alphabetic purposes
  rets <- list()
  for (i in 1:length(inputfile_patterns)) {
    if (length(grep("__measures", inputfile_patterns[i])) > 0)  {
      rets[["pattern"]] <- aggregate_measures(filepath=filepath, pattern=inputfile_patterns[i])
    } else if (newschool==FALSE) {
      rets[["pattern"]] <- aggregate_aggregated_cm(filepath=filepath, pattern=inputfile_patterns[i])
    }  else {
      rets[["pattern"]] <- aggregate_aggregated_cm_newschool(filepath=filepath, pattern=inputfile_patterns[i])
    }  
    
    params <- data.frame(matrix(ncol=length(parameter_names), nrow=length(rets[["pattern"]])),stringsAsFactors = FALSE)
    names(params) <- paste0(letters[i], "_", parameter_names)
  
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
  
  if (!identical(x_tick_breaks, c(""))) {
    row.names(df_kpl) <- x_tick_breaks
  } else {
    row.names(df_kpl) <- 1:length(x_tick_labels)
  }
  df <- cbind(n=as.integer(row.names(df_kpl)), df_kpl)
  
  linetypes <- c("solid", "dashed", "dotted", "longdash", "twodash")[1:length(inputfile_patterns)]
  override.linetype <- unlist(lapply(linetypes, FUN=function(linetype) {rep(linetype, length(parameter_names))}))

  colors <- c("red", "purple", "green", "blue", "brown", "grey", "black", "white", "yellow")[1:length(parameter_names)]
  override.colour <- rep(colors, length(inputfile_patterns))

  # This is it
  if (is.null(plot_width)) {
    plot_width <- (200 * length(x_tick_labels)) + 400
  }
  outputfilepath <- paste0(filepath, "/", outputfile, ".png")
  png(filename = outputfilepath, width = plot_width)
  p <- ggplot(data=df, aes(x=n)) + 
    theme(legend.title=element_blank(), axis.title.x = element_text(size=18), axis.title.y = element_text(size=18),
          legend.text = element_text(size=14), 
          axis.text.x = element_text(size=12), 
          axis.text.y = element_text(size=12),
          plot.title = element_text(size=20),
          plot.subtitle = element_text(size=14), legend.key.width = unit(3, "cm"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_line(color="black")
    ) +
    scale_x_continuous(breaks=df$n, labels=x_tick_labels) +
    scale_y_continuous(labels=scales::percent) +
    labs(title=main_title, 
         x=x_title, y=y_title, 
         subtitle=sub_title) 
    
  for (j in 1:length(all_params)) {
      p <- p + geom_line(aes_string(y=names(all_params)[j], col=shQuote(letters[j]), linetype=shQuote(letters[j])), size=1.3)
  } 
  
  final_legend_labels <- character(length(legend_title_parentheses) * length(legend_labels))
  l <- 1
  for (j in 1:length(legend_title_parentheses)) {
    for (k in 1:length(legend_labels)) {
      if (identical(legend_title_parentheses, c(""))) {
        final_legend_labels[l] <- legend_labels[k]
      } else {
        final_legend_labels[l] <- paste0(legend_labels[k], "  (", legend_title_parentheses[j], ")")
      }
      l <- l + 1
    }
  }
  p <- p + scale_linetype_manual(name="", values = override.linetype, labels=final_legend_labels)
  p <- p + scale_color_manual(name="",values = override.colour, labels=final_legend_labels)
  
  max_values <- list()
  max_inds <- list()
  for (k in 1:length(all_params)) {
    max_values[[k]] <- all_params[which(max(all_params[k]) == all_params[k]),k]
    max_inds[[k]] <- which(max(all_params[k]) == all_params[k])
  }
  
  # Add points separately for highlights and the rest
  for (j in 1:nrow(all_params)) {
    for (k in 1:length(all_params)) {
      if (highlight_max[k]==FALSE | (j %in% max_inds[k]==FALSE)) {
        #p <- p + geom_point(aes_string(x=df$n[j], y=names(all_params[k])), size=3)
        p <- p + geom_point(aes_string(x=df$n[j], y=all_params[j,k]), size=3)
      }
      if (highlight_max[k]==TRUE & (j %in% max_inds[k])) {
        p <- p + geom_point(aes_string(x=df$n[j], y=max_values[[k]]), color="red", size=6)
      }
    }
  }
  plot.new()  
  plot(p)
  dev.off()
}