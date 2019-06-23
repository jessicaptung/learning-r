# https://www.kaggle.com/rtatman/the-5-day-data-challenge
# Data used:
# Day 1 - Groundhog archive - Read in data
# Day 2 - Starbucks Menu - Histogram
# Day 3 - Cereals - T test

# Set up
library(tidyverse)
list.files(path = "../input")

# Read in and explore data
archive <- read_csv("../input/archive.csv")
head(archive)
tail(archive)
summary(archive)
str(archive)

# Rename column names
names(archive)  <- make.names(names(archive))
tail(archive)

# Another approach to rename column names
library(janitor)
archive %>%
	clean_names()

# Remove na records
archive <- archive %>%
    filter(!is.na(February.Average.Temperature) )
head(archive)
tail(archive)
summary(archive)
str(archive)

# Histogram (x has to be a continuous variable) (ggtitle instead of geom_title)
ggplot(data=archive, aes(x = February.Average.Temperature)) +  
    geom_histogram(bin=10)+ #bin is optional
    ggtitle("Feb Avg Temperature") #optional

# Prep for T-test
# Group records to two groups
unique(archive$Punxsutawney.Phil)
archive <- archive %>%
    filter(archive$Punxsutawney.Phil =="Full Shadow" | 
           archive$Punxsutawney.Phil =="No Shadow" |
           archive$Punxsutawney.Phil =="Partial Shadow")
archive %>%
    group_by(Punxsutawney.Phil) %>%
    count()
archive$Shadow.Type  <- ifelse(archive$Punxsutawney.Phil =="Full Shadow", "Shadow", 
                        ifelse(archive$Punxsutawney.Phil =="Partial Shadow", "Shadow",
                        ifelse(archive$Punxsutawney.Phil =="No Shadow", "No Shadow",
                        "Missing"
                        )))

archive %>%
    group_by(archive$Shadow.Type) %>%
    count()

# Check for normality with a qqplot (if normal, points should 
# More or less on the center diagonal)
qqnorm(archive$February.Average.Temperature)

# T-Test
# is there a difference in the Feb temperature across the two
# types of activities (Shadow and No Shadow)
t.test(archive$February.Average.Temperature ~ archive$Shadow.Type)

# Default: p-value= 0.05
# Welch Two Sample t-test
# data:  archive$February.Average.Temperature by archive$Shadow.Type
# t = 2.9105, df = 24.277, p-value = 0.007613
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval: 0.5520229 3.2378384
# sample estimates:
# mean in group No Shadow    mean in group Shadow 
#               35.57800                33.68307  

# p-value = 0.007 > 0.05
# => reject the null
# => NOT not a diff between these two group (Ho)
# t: actual velue of the t-test
# df: degrees of freedom
# p-value: the probability that a diff this large between 2 groups just due to the chance if they were actually drwan from the same underlying population
# When Feb temperature is higher, there tends to be no shadow

# Histogram (x has to be a continuous x variable)
ggplot(archive, aes(x=February.Average.Temperature, fill=Shadow.Type)) +  
    geom_histogram()