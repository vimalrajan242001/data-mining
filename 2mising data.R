# Data Preprocessing
setwd("E:/studies/3rd year/q1/data mining")
# Importing the dataset
dataset = read.csv('Data.csv')
View(dataset)
# Taking care of missing data
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)
dataset$Salary = ifelse(is.na(dataset$Salary),
                        ave(dataset$Salary, FUN = function(x) mean(x, na.rm = FALSE)),
                        dataset$Salary)
dataset
