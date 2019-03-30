#https://flowingdata.com/2013/04/29/small-multiples-in-r/

getwd()
list.files("/Users/jessicatung/Documents/FlowingData/201304multiples-tutorial/data")
setwd("/Users/jessicatung/Documents/FlowingData/201304multiples-tutorial/data")

# Load data
causes <- read.csv("12s0121-truncated.txt", sep="\t", header=TRUE)
head(causes)
summary(causes)

# One bar chart
i <- 1
firstCause <- causes[i, 2:12]
firstCause
barplot(as.numeric(firstCause))

# Make more plots
# par(): set up a grid layout and margins
# mfrow=c(10, 9): a grid with 10 rows and 9 columns
# mar(bottom, left, top, right): margin around each 

# Bar plot for each cause
par(mfrow=c(10, 9), mar=c(1,1,1,1))

# Iterate through each row of data using a for loop
# The ocunts for each age bracket for the current causes are pased to barplot
for (i in 1: length(causes[,1])) {
  currCase <- causes[i,2:12]
  barplot(as.numeric(currCase))
}

# Make bar plot more readable
par(mfrow=c(12,8), mar=c(1,1,1,1))
for (i in 1:length(causes[,1])) {
  currCause <- causes[i, 2:12]
  barplot(as.numeric(currCase),
          main=causes[i,1], 
          cex.main=0.8,
          cex.axis=0.7, 
          border="white", 
          space=0)
}

# Reduce ticks to show only zero line and max acount
# Play with axes
par(mfrow=c(12,8), mar=c(1,1,1,1))
for (i in 1:length(causes[,1])) {
  currCause <- causes[i, 2:12]
  
  #Draw bar plot with no axes
  barplot(as.numeric(currCause),
          main=causes[i, 1],
          cex.main=0.8,
          cex.axis=0.7,
          border="white",
          col="#e26b43",
          space=0,
          axes=FALSE)
  
  # Draw custom axes
  axis(side=1, at=c(0,11), labels=FALSE)
  axis(side=2, at=c(0, max(currCause)),
       cex=0.7)
}

# Make y axis the same scale for comparison
par(mfrow=c(12,8), mar=c(1,1,1,1))
for (i in 1:length(causes[,1])) {
  currCause <- causes[i, 2:12]
  
  # Draw bar plot with no axes, same vertical scale
  barplot(as.numeric(currCause),
                     main=causes[i,1],
                     cex.main=0.8,
                     col="#e26b43", space=0,
                     axes=FALSE,
                     ylim=c(0,120000))
          # Draw custom axes
          axis(side=1, at=c(0,11), labels=FALSE)
          axis(side=2, at=c(0, max(currCause)), cex=0.7)  
}

# Highlight the causes which occur more often to younger people 
# Revert to the original Y vertical scale
par(mfrow=c(12,8), mar=c(1,1,1,1))
for (i in 1:length(causes[,1])) {
  currCause <- as.numeric(causes[i,2:12])
  
  # Find age group with highest count
  maxCnt <- max(currCause)
  groupNum <- which(currCause == maxCnt)
  
  # Color based on max age group
  if (groupNum < 5) {
    barColor <- "#e26b43"  #orange
  } else {
    barColor <- "#cccccc" #gray
  }
  
  # Draw the bar plot
  barplot(currCause, main=causes[i,1],
          cex.names = 0.8, cex.axis = 0.7,
          border="white", 
          col=barColor, space=0, axes=FALSE)
  axis(side=1, at=c(0,11), labels=FALSE)
  axis(side=2, at=c(0, max(currCause)), cex=0.8)
}

# Try other chart types
i <- 1
firstCause <- as.numeric(causes[i, 2:12])
maxCnt <- max(firstCause)
yOffset <- (maxCnt - firstCause) / 2
plot(0,0,type="n", 
     xlim=c(0,11), ylim=c(0, max(firstCause)),
     xlab="", ylab="",
     axes=FALSE, bty="n")
rect(0:10, yOffset, 1:11, firstCause+yOffset,
     col="#cccccc",border="white" )

# Now do it for all causes
par(mfrow=c(12,8), mar=c(1,1,1,1))
for (i in 1:length(causes[,1])) {
  currCause <- as.numeric(causes[i, 2:12])
  
  # Find age group with highest count
  maxCnt <- max(currCause)
  
  # Draw the custom chart
  yOffset <- (maxCnt - currCause) /2
  plot(0,0,type="n",
       xlim=c(0,11), ylim=c(0, max(currCause)),
       xlab="", ylab="",
       axes=FALSE, bty="n",
       cex.main=0.8, main=causes[i,1])
  rect(0:10, yOffset, 1:11, currCause+yOffset,
       col="#e26b43", border="white")
}

