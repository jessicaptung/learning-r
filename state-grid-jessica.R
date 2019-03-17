# Directory
getwd()
setwd("/Users/jessicatung/Documents/FlowingData/state-grid-tutorial")

# Read data
stategrid <- read.csv("data/state-grid-coordinates.tsv", stringsAsFactors = FALSE, sep="\t")
?read.csv

# What it looks like
head(stategrid)
plot(stategrid$x, stategrid$y, type="n")
text(stategrid$x, stategrid$y, stategrid$state)

# It's upside down. Flip it.
stategrid$ysideup <- 12 - stategrid$y

# Try plotting again
plot(stategrid$x, stategrid$ysideup)
?plot
text(stategrid$x, stategrid$ysideup, stategrid$state)
?text

# Draw sate grid
symbols(stategrid$x, stategrid$ysideup, 
        squares = rep(1, dim(stategrid)[1]), 
        inches=FALSE, asp=1, bty="n", 
        xaxt="n", yaxt="n", xlab="", ylab="")
?symbols

text(stategrid$x, stategrid$ysideup, stategrid$state)

# New data file
dollarval <- read.csv("data/dollarval-bystate.tsv",
                      stringsAsFactors = FALSE, sep="\t")
head(dollarval)

# Merge grid coordinates data frame with new data
dollargrid <- merge(dollarval, stategrid, 
                    by.x="abbrev", by.y="state")
head(dollargrid)

# Color
dollargrid$col <- sapply(dollargrid$value_100, function(x){
  if(x < 95) {
    col <- "#011e00"
  } else if (x < 100) {
    col <- "#024000"
  } else if (x < 105) {
    col <- "#047300"
  } else if (x < 110) {
    col <- "#06a600"
  } else {
    col <- "#07c800"
  }
  return(col)
})
head(dollargrid)

# Fill with color
symbols(dollargrid$x, dollargrid$ysideup,
        squares = rep(1, dim(dollargrid)[1]),
        inches = FALSE,
        asp = 1,
        bty="n",
        xaxt = "n", yaxt = "n",
        xlab = "", ylab = "",
        bg = dollargrid$col, #fillin color
        fg="#ffffff")  #border

?symbols

# Add text
labeltext <-  paste(dollargrid$abbrev, "\n", "$",
                    format(dollargrid$value_100, 2), sep="")

text(dollargrid$x, dollargrid$ysideup, 
     labeltext, cex=.6, col="#ffffff")

# Add a legend
# Start layout
par(mar=c(0,0,0,0), bg="white")
?par
plot(0:1, 0:1, type="n", xlab="", ylab="", axes=FALSE, asp=1)

# Draw map like before
par(new = TRUE, plt=c(0, 1, 0, 1)) # map position
symbols(dollargrid$x, dollargrid$ysideup,
        squares = rep(1, dim(dollargrid)[1]),
        inches = FALSE,
        asp = 1,
        bty="n",
        xaxt = "n", yaxt = "n",
        xlab = "", ylab = "",
        bg = dollargrid$col, #fillin color
        fg="#ffffff")  #border
symbols(dollargrid$x, dollargrid$ysideup,
        squares = rep(1, dim(dollargrid)[1]),
        inches=FALSE,
        asp=1,
        bty="n",
        xaxt="n", yaxt="n",
        xlab="", ylab="",
        bg=dollargrid$col,
        fg="#ffffff")
labeltext <- paste(dollargrid$abbrev, "\n", "$", format(dollargrid$value_100, 2), sep="")
text(dollargrid$x, dollargrid$ysideup, labeltext, cex=.8, col="#ffffff")

# Legend
par(new = TRUE, plt = c(0, 1, .9, 1)) # Legend position
plot(0, 0, type = "n", 
     xlim = c(0, 1), ylim = c(-.1, 1),
     xlab = "", ylab = "", axes = FALSE)
rect(xleft = c(.4, .45, .5, .55, .6) - .025,
     xright = c(.45, .5, .55, .6, .65) - .025,
     ybottom = c(0, 0, 0, 0, 0)+.1,
     ytop = c(.2, .2, .2, .2, .2) + .1,
     col = c("#011e00", "#024000", "#047300", "#06a600", "#07c800"),
     border="#ffffff", lwd = .5)

# Legend text
text(c(.45, .5, .55, .6)-.025,
     c(  0,  0,   0,  0)-.3,
     labels = c("$95", "$100", "$105", "110"), pos=3, cex=.8)

#Legend title
text(.5, .7, "Value of $100", cex=2)
