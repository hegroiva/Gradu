arrange_pics <- function(images, outputfile, columns, rows) {
  
  if (length(images)==1) {
    filenames <- list.files(path=outputpath, pattern=images, full.names = TRUE)
    print(filenames)
    rl = lapply(filenames, readPNG)
    
    #rl = lapply(sprintf(paste0(outputpath, "/", images)), png::readPNG)
    
  } else {
    print(images)
    images <- paste0(outputpath, "/", images)
    print(images)
    rl = lapply(images, png::readPNG)
    filenames <- paste0(outputpath, images)
  }
  
  #imgs <- list()
  #for (fil in mixedsort(filenames)) {
  #  imgs[[fil]] <- rasterGrob(as.raster(readPNG(fil)), interpolate = TRUE)
  #}
  #imgs <- unlist(imgs)
  #print(imgs)
  #grid.arrange(imgs[1], imgs[2], imgs[3], imgs[4], sncol=columns, nrow=rows)
 
  
  gl = lapply(rl, grid::rasterGrob)
  print(length(gl))
  
  gridExtra::grid.arrange(grobs=gl, ncol=columns, nrow=rows, interpolate=FALSE) 
}