# http://projects.flowingdata.com/tut/pyramid/population-pyramid-animated.html
# https://flowingdata.com/2015/11/03/animated-pyramid-chart-in-r/

# Install package: animation (save images as GIFs, HTML, SWF, video, LaTeX) 
# Install package: plotrix (draw a pyramid chart)
install.packages(c("animation", "plotrix"), dependencies = TRUE)
library(animation)
library(plotrix)

# Load the data. Source: US Census Bureau
getwd()
setwd("/Users/jessicatung/Documents/FlowingData/pyramid-animated-tutorial")
population <- read.csv("data/us-pop-age-sex.csv",
                       stringsAsFactors = FALSE)
head(population)

# Draw a pyramid chart: pyarmid.plot()
# Subset on age and sex

# Remove the "Total" rows with the -1 index. Vector.
ages <- unique(population$age)[-1] # Won't chart the total
typeof(ages)
ages
# Grab only the ages in (using the %in% operator) the ages vector 
pop2015 <- subset(population, year==2015 & age %in% ages)
head(pop2015)

# Store Male and Female columns in their own vectors
female <- pop2015$female_pct
male <- pop2015$male_pct

# Draw the plot
pyramid.plot(male, female, labels=ages, main="US Population 2015")

# Simplified
par(cex=0.85)
pyramid.plot(male, female, labels=ages, main="Population Percentages by Age and Sex, 2015",
             lxcol="#A097CC", rxcol="#EDBFBE", unit="", xlim=c(10,10), gap=0)

# Plot for every year
par(mfrow=c(4,4))
for (y in unique(population$year)) {
  pop_year <- subset(population, year==y & age %in% ages)
  female <- pop_year$female_pct
  male <- pop_year$male_pct
  
  par(cex=0.6)
  pyramid.plot(male, female, 
               top.lables=c("Male", "", "Female"),
               labels = ages, main = y,
               lxcol = "#A097CC", rxcol = "#EDBFBE",
               xlim = c(10, 10), gap = 0, unit = "")
}


# Temporary 
ani.options(outdir = paste(getwd(), "/images", sep=""))
?ani.options

# Save as GIF
saveGIF({
  
  for (y in unique(population$year)) {
    pop_year <- subset(population, year==y & age %in% ages)
    female <- pop_year$female_pct
    male <- pop_year$male_pct
    
    par(cex=0.8)
    pyramid.plot(male, female, top.labels=c("Male", "", "Female"), labels=ages, main=y, lxcol="#A097CC", rxcol="#EDBFBE", xlim=c(10,10), gap=0)
    
  }}, movie.name = "population-pyramid-animated.gif", 
  interval=0.15, nmax=100, ani.width=650, ani.height=400)

# Save as HTML
saveHTML({
  
  for (y in unique(population$year)) {
    pop_year <- subset(population, year==y & age %in% ages)
    female <- pop_year$female_pct
    male <- pop_year$male_pct
    
    par(cex=0.8)
    pyramid.plot(male, female, top.labels=c("Male", "", "Female"), labels=ages, main=y, lxcol="#A097CC", rxcol="#EDBFBE", xlim=c(10,10), gap=0)
    
  }}, movie.name = "population-pyramid-animated.gif", 
  interval=0.5, nmax=100, ani.width=650, ani.height=400)