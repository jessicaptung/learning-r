#https://flowingdata.com/2012/07/03/a-variety-of-area-charts-with-r/
# A Variety of Area Charts with R

getwd()
setwd("/Users/jessicatung/Documents/FlowingData/streamgraph-tutorial/data")
list.files()

# Fake data frame
numCols <- 20
numLayers <- 5
fakeData <- data.frame(matrix(ncol=numCols, nrow=numLayers))
fakeData

for (i in 1:numLayers) {
  #heights <-  runif(numCols, 0, 1) #runif: uniform #runif(n, min=0, max=1)
  fakeData[i, ] <- heights
  heights <- 1 / runif(numCols, 0, 1)
  newRow <- heights * exp(-heights * heights)
  fakeData[i, ] <- newRow
}