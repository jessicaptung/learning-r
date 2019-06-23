# https://www.kaggle.com/rtatman/the-5-day-data-challenge
# Day 4 - Survey data - Bar chart
# Day 5 - Survey data - Chi-squared test

library(tidyverse)
list.files(path = "../input")

# Read in data
dataset <- read_csv("../input/anonymous-survey-responses.csv")
head(dataset)
tail(dataset)
summary(dataset)
str(dataset)

# Rename columns 
names(dataset) <- make.names(names(dataset))

# or clean names with clean_names
library(janitor)
dataset %>%
    clean_names()

# Bar chart
ggplot(dataset, aes(x=Have.you.ever.taken.a.course.in.statistics.)) +
    geom_bar()

# Rename content
unique(dataset$Just.for.fun..do.you.prefer.dogs.or.cat.)
dataset$Just.for.fun..do.you.prefer.dogs.or.cat. <- 
	recode(dataset$Just.for.fun..do.you.prefer.dogs.or.cat.,
      "Cats ?±" = "Cats",
      "Dogs ?¶" = "Dogs",
      "Neither ?…" = "Neither",
      "Both ?±?¶" = "Both")

# Bar chart
ggplot(dataset, aes(x=Just.for.fun..do.you.prefer.dogs.or.cat.)) +
    geom_bar() +
    ggtitle("Cats or Dogs?") + #ggtitle, not geom_title 
    xlab("") # not xlabs, must put "" in ()

# Chi-squared test 
# Is there a relationship between having programming background and having taken statistics
# See if the portion of 2 categorical variables are diffrent from chance
chisq.test(dataset$Have.you.ever.taken.a.course.in.statistics.,
           dataset$Do.you.have.any.previous.experience.with.programming.)

# Result
#Pearson's Chi-squared test
#data:  dataset$Have.you.ever.taken.a.course.in.statistics. and dataset$Do.you.have.any.previous.experience.with.programming.
#X-squared = 16.828, df = 8, p-value = 0.03195
# X-squared: the chi-squared value (bigger = more diff from the expected distribution)
# df: degrees of freedom (used in calculating the p-value)
# p-value: the probability that a diff this large by chance if our samples were actually drawn from the same distribution
# alpha: the upper bound of the p-vlaue that it owuld take to convince me that there isn't no diff between the two groups
# There is a relationship between taking statistics course and having programming experience 

# Bar chart to see relationship between two categorical variables
ggplot(dataset, aes(x=Have.you.ever.taken.a.course.in.statistics.,
                    fill=Do.you.have.any.previous.experience.with.programming.)) +
    geom_bar(position="dodge")

# switch x and y
ggplot(dataset, aes(x=Do.you.have.any.previous.experience.with.programming.,
                    fill=Have.you.ever.taken.a.course.in.statistics.)) +
    geom_bar()