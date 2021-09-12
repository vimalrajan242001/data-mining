# Create the data frame.
getwd()
vimal <- data.frame(
  Age = c (18,18,25,14), 
  Martial = c("single","single","married","single"),
  Ammount = c(5000,7855,74856,55554), 
  quality = c("good","excellent","good","excellent"),  
  peopleCount = c(5,7,4,5),
  whomWith = c("friends","family","alone","other")
)
# Print the data frame.			
print(vimal) 
write.csv(vimal,"E:\\studies\\3rd year\\q1\\data mining\\day-1\\vimal1.csv", row.names = TRUE)
vimal$Age
dim(vimal)
str(vimal)
summary(vimal)
mode(vimal$Age)
mode(vimal$Martial)

emp.data <- data.frame(
  emp_id = c (1:5), 
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25), 
  
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
                         "2015-03-27")),
  stringsAsFactors = FALSE
)
# Print the data frame.			
print(emp.data) 
mode(emp.data$emp_name)
data <-data.frame(Age=c(10,20,30,40,50),Marital=c("single","married",'s','m','s'),
                  Quality=c('e','p','g','f','p'),
                  amount=c(10,11,12,13,15),
                  peoplecount=c(1,4,8,3,9)
                  ,whowith=c('fri','cusin','alone','family','cusin'))

# cmeans combination

print(data)
write.csv(data,'survey.csv',row.names=FALSE)
print(data$Age)
print(data$Marital)
print(data$Quality)
print(data$amount)
print(data$peoplecount)
print(data$whowith)
print(data$Age[1])
dim(data)#coordinates of data
str(data)# structure of the data
summary(data)# summary of the data frame

# row.names =false because we dont have column
#descriptive statistic  to locate dataobjects and describing data using 
#the measure of central tendency:mean , median , mode ,variance
#Descriptive statistic
#minimum
#first quartile
#Meidan
#third quartile
#maximum

boxplot(data)#// error because marital have alpabets
boxplot(data$Age)
mode(data$Marital) #character
# we can't find distributive value for nominals except mode
#25% 1st quarile 50% mean 75% 3rd quartile or viscor above 75 outliers
