make_pic_comparison_bars_multiclass <- function(filepath=outputpath, 
                                    inputfile_patterns = c(""), 
                                    parameter_names = c(""), 
                                    outputfile = "", 
                                    main_title = "", 
                                    sub_title = "",
                                    x_title = "",
                                    y_title = "",
                                    group_names =c(""),
                                    legend_labels = c(""), 
                                    #x_tick_labels = c(""), 
                                    #x_tick_breaks = c(),
                                    legend_title_parentheses=c(""),
                                    total_width=550,
                                    space_between_bars=0.0,
                                    newschool=FALSE) {
  # Check that there's a pattern declared
  if (identical(inputfile_patterns,c(""))) {
    message("Please fill in inputfile_patterns also.")
    return()
  }
  
  # Get all the values for all the patterns
  # Add letter at the start of the param name just for alphabetic purposes
  rets <- list()
  for (i in 1:length(inputfile_patterns)) {
    rets[["pattern"]] <- aggregate_cm_multiclass(filepath=filepath, pattern=inputfile_patterns[i])
    if (length(rets[["pattern"]]) == 0) {
      msg <- paste0("MISSING files with pattern: ", filepath, "/", inputfile_patterns[i])
      message(msg)
    }
    if (length(grep("Class Unknown", group_names[i])) > 0) {
      vals <- t(calculate_multiclassifiers(rets$pattern$all_names, rets$pattern$all_values, c("unknown")))
    } else if (length(grep("Class Non-poetry", group_names[i])) > 0) {
      vals <- t(calculate_multiclassifiers(rets$pattern$all_names, rets$pattern$all_values, c("nonpoetry")))
    } else if ((length(grep("prevails", inputfile_patterns[i])) == 0) &
        (length(grep("hc", inputfile_patterns[i]))== 0) &
        (length(grep("fringe", inputfile_patterns[i], ignore.case = TRUE))== 0)) {
      vals <- t(calculate_multiclassifiers(rets$pattern$all_names, rets$pattern$all_values, c("poetry", "true")))
    } else {
      vals <- t(calculate_multiclassifiers(rets$pattern$all_names, rets$pattern$all_values, c("fringe", "hardcore")))
    }
    #params <- data.frame(matrix(ncol=length(parameter_names), nrow=length(rets[["pattern"]])),stringsAsFactors = FALSE)
    params <- data.frame(matrix(ncol=length(parameter_names), nrow=1),stringsAsFactors = FALSE)
    names(params) <- paste0(letters[i], "_", parameter_names)
    
    for (param in parameter_names) {
      params[paste0(letters[i], "_", param)] <- as.numeric(vals[param,])
    }
    
    if (i == 1) {
      all_params <- params
    } else {
      all_params <- cbind(all_params, params)
    }
  }
  
  df_kpl <- all_params
  colnames(df_kpl) <- names(all_params)
  
  df <- cbind(decade=row.names(df_kpl), df_kpl)
  data_long <- data.frame(x=unlist(lapply(group_names, FUN=function(group_name) {rep(group_name, length(parameter_names))})),
                          a=rep(parameter_names, length(group_names)),
                          values=t(df_kpl))
  data_long$percent <- percent(data_long$values, digits=1)

  if (space_between_bars != 0.0) {
    space_between_groups <- (space_between_bars * 2)
    bar_width <- ((1 - space_between_bars) - space_between_groups)
  } else {
    space_between_groups <- 0.1
    bar_width <- 0.9
  }
  
  # Bloody R uses alphabetical order by default
  data_long$a <- factor(data_long$a, parameter_names)
  data_long$x <- factor(data_long$x, group_names)
  
  p <- ggplot(data=data_long, aes(x=x, y=percent, fill=a)) +
    #geom_bar(stat="identity", position = "dodge", width = .9) +
    
  
    geom_bar(stat="identity", 
             position = position_dodge(width = (space_between_bars + bar_width)), 
             width = bar_width) +
    theme(legend.title=element_text(size=12, color="red"), 
          axis.title.x = element_text(size=18), 
          axis.title.y = element_text(size=18),
          legend.text = element_text(size=14), 
          axis.text.x = element_text(size=12), 
          axis.text.y = element_text(size=12),
          plot.title = element_text(size=20),
          plot.subtitle = element_text(size=14),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank()
    ) +
    
    geom_text(data=data_long, 
              aes(x=x, y=percent + 0.02 , group=a, label=as.character(percent)),
              position=position_dodge(width = space_between_bars + bar_width)) +
    
    #scale_fill_discrete("", labels=c("Fennica (printed anywhere)", "Kungliga (printed in Finland)", "In Kungliga, but not in Fennica")) +
    scale_fill_discrete("", labels=legend_labels) + 
    scale_y_continuous(breaks = percent(seq(0, 1, 0.1), digits=0), limits=c(0,1)) +
    labs(title=main_title, subtitle=sub_title, 
         x=x_title, y=y_title)
  png(filename = paste0(outputpath, "/", outputfile, ".png"), width = total_width)
  plot.new()
  plot(p)
#  text("Percentages on top of the bars\nindicate the potential \nincrease of Fennica records\nif Kungliga records were added.", x=0.82, y=0.8, adj=0, col="red")
  #text("indicate the potential increase of\nFennica records", x=0.8, y=0.75, adj=0, col="red")
  #text("if Kungliga records were added", x=0.8, y=0.7, adj=0, col="red")
  dev.off()
  #pdf(ret,file = "C:\\Users\\Hege\\Työ\\Kungliga\\Output\\Number of records in Fennica and Kungliga.pdf")
  
}

