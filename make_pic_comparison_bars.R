make_pic_comparison_bars <- function(filepath=outputpath, 
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
  
  #fennicas <- c(1833, 2005, 2054, 2354, 515, 576, 391, 552, 911, 1117, 2105, 4435, 9432)
  #finskit_kpl <- c(134,119,121,254,139,247,131,279,355,484,531,967,1416)
  #not_kpl <- c(10, 11, 11, 84, 96, 204,107,217,269,346,392,523,428)
  #df_kpl <- data.frame(Fennica=fennicas, Kungliga=finskit_kpl, prev_unknown=not_kpl)
  df_kpl <- all_params
  #row.names(df_kpl) <- c("1770", "1780", "1790", "1800", "1810", "1820", "1830", "1840", "1850", "1860", "1870", "1880", "1890") 
  colnames(df_kpl) <- names(all_params)
  
  #if (!identical(x_tick_breaks, c(""))) {
  #  row.names(df_kpl) <- x_tick_breaks
  #} else {
  #  row.names(df_kpl) <- 1:length(x_tick_labels)
  #}
  df <- cbind(decade=row.names(df_kpl), df_kpl)
  data_long <- data.frame(x=unlist(lapply(group_names, FUN=function(group_name) {rep(group_name, length(parameter_names))})),
                          a=rep(parameter_names, length(group_names)),
                          values=t(df_kpl))
  data_long$percent <- percent(data_long$values, digits=1)
  #data_long <- gather(df, a, kpl, 2:length(all_params), factor_key = TRUE )
  
  #colors <- c("red", "purple", "green", "blue", "brown", "grey", "black", "white", "yellow")[1:length(parameter_names)]
  
  
  #gain <- paste0(as.integer(10000 * (df$prev_unknown / (df$Fennica + df$prev_unknown))), "%")
  #data_add <- c("", "", "576", "", "", "391", "", "", "552", "", "", "911", "", "", "1117", "", "", "2105", "", "", "4435", "", "", "9432")
  #gain <- c("","", "0.5%", "", "", "0.5%", "", "", "0.5%", "", "", "3.4%", "", "", "15.7%", "", "", "26.2%", "", "", "21.5%", "", "", "28.2%", "", "", "22.8%", "", "", "23.7%", "", "", "15.7%", "", "", "10.5%", "", "", "4.3%")
  #data_long2 <- cbind(data_long, gain)
  
  if (space_between_bars != 0.0) {
    space_between_groups <- (space_between_bars * 2)
    bar_width <- ((1 - space_between_bars) - space_between_groups)
  } else {
    space_between_groups <- 0.1
    bar_width <- 0.9
  }
  
  # Bloody R uses alphabetical order by default
  data_long$a <- factor(data_long$a, parameter_names)
  
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
              aes(x=x, y=percent + 0.03 , group=a, label=as.character(percent)),
              position=position_dodge(0.9)) +
    
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

