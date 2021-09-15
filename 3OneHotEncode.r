#Encoding of categorical variable : One - Hot encoding
id <- factor(1:10) #10 OBSERVATION (10 ROWS)
?rnorm()
height <- round(175 +rnorm(10)*10)
state <-c("TN","UP","AP","TN","Tripura","TN","AP","UP","KAR","TN")
mydata <- data.frame(cbind(id,height,state))
mydata

# The variable state is categorical
for(unique_value in unique(mydata$state))
{
  mydata[paste("state", unique_value, sep=".")] <- ifelse(mydata$state == unique_value, 1, 0)
}
mydata
#-------------------------------
library(scorecard)
a <-c('red','red','green')
b <-c('large','medium','small')
c <-c('wide','narrow','narrow')

df <- data.frame(a,b,c)
df
?one_hot()
one_hot(df)
#-----------------------------------------------------------------
library(data.table)
library(mltools)
dt <- data.table(ID = 1:4,
                 color = factor(c("red", NA, "blue", "blue"), levels=c("blue","green","red")))
dt
one_hot(dt)
one_hot(dt, sparsifyNAs=TRUE)
one_hot(dt, naCols=TRUE)
one_hot(dt, dropCols=FALSE)
one_hot(dt, dropUnusedLevels=TRUE)





