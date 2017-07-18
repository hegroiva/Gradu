# This code originated from 
# https://stackoverflow.com/questions/24509309/custom-metric-hmeasure-for-summaryfunction-caret-classification?rq=1

hmeasureCaret<-function (data, lev = NULL, model = NULL,...) 
{ 
  # adaptation of twoClassSummary
  require(hmeasure)
  if (!all(levels(data[, "pred"]) == levels(data[, "obs"]))) 
    stop("levels of observed and predicted data do not match")
  hObject <- try(hmeasure::HMeasure(data$obs, data[, lev[1]]),silent=TRUE)
  hmeasH <- if (class(hObject)[1] == "try-error") {
    NA
  } else {hObject$metrics[[1]]  #hObject$metrics[c('H')] returns a dataframe, need to return a vector 
  }
  out<-hmeasH 
  names(out) <- c("Hmeas")
  out 
}