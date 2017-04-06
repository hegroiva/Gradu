source("GitHub/Gradu/pos_tagging.R")
get_POS_tags <- function(titles, load=TRUE) {
  if (!load) {
    ptm <- proc.time()
    print(paste0("starting POS-tagging for ", length(titles), " titles at ", date(), "."))
    tagged <- unlist(POStag_sentence(as.character(titles)))
    saveRDS(tagged, "C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\Titles\\tagged_titles3.RDS")
    print(paste0("POS-tagging finished at ", date()))
  } else {
    tagged <- readRDS("C:\\Users\\Hege\\Opiskelu\\Kurssit\\Gradu\\Titles\\tagged_titles3.RDS")
  }
}
