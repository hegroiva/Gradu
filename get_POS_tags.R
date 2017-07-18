source("GitHub/Gradu/pos_tagging.R")
get_POS_tags <- function(titles, filename, load=TRUE) {
  if (!load) {
    ptm <- proc.time()
    print(paste0("starting POS-tagging for ", length(titles), " titles at ", date(), "."))
    tagged <- unlist(POStag_sentence(as.character(titles)))
    saveRDS(tagged, filename)
    print(paste0("POS-tagging finished at ", date()))
  } else {
    tagged <- readRDS(filename)
  }
  return (tagged)
}
