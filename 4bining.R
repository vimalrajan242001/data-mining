# req of binning is to convert numeric attribute to categorical data
?runif
dataset <- runif(100, 0, 10)
dataset
bins <- 4
min <- min(dataset)
max <- max(dataset)
width <- (max - min) / bins
width <- round(width)
width
?cut
?table
# cut te range of x into interval
cut(dataset, breaks = seq(min, max, width))
table(cut(dataset, breaks = seq(min, max, width)))
barplot(table(cut(dataset, breaks = seq(min, max, width))))


students <- read.csv("data-conversion.csv")
students
# label the income of $10,000 or below as Low.
# label the income between $10,000 and $31,000 as Medium
# label the income above $31,000 AS high

# Create a vector of breakpoints
?Inf
b <- c(-Inf, 10000, 31000, Inf)
b
names <- c("Low", "Medium", "High")

# Cut the vector
students$Income.b <- cut(students$Income, breaks = b, labels = names)
students$Income.b
students

table(cut(students$Income, breaks = b, labels = names))
labels <- c("level1", "level2", "level3", "level4")
barplot(table(cut(students$Income, breaks = 4, labels = c("level1", "level2", "level3", "level4"))))
students$Income.c <- cut(students$Income, breaks = 4, labels = c("level1", "level2", "level3", "level4"))
students
install.packages("dplyr")
install.packages("tidyverse")
install.packages("readr")
library(ggplot2)
library(dplyr)
library(tidyverse)
library(readr)
data <- read_delim("zipIncome.csv", delim = ",")
data
str(data)
summary(data)

data_extract <- data %>% select(MeanEducation, MeanHouseholdIncome)
data_extract
summary(data_extract)


ggplot(data = data_extract, mapping = aes(x = MeanEducation)) +
  geom_histogram(aes(y = ..density..), fill = "bisque", color = "white", alpha = 0.7) +
  geom_density() +
  geom_rug() +
  labs(x = "mean education per house") +
  theme_minimal()