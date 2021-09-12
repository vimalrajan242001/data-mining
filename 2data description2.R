getwd()
mydata <- read.csv("students.csv")
mydata
library(reshape)
mydata <- rename(mydata, c(Last.Name="Last"))
mydata <- rename(mydata, c(First.Name="First"))
mydata <- rename(mydata, c(Student.Status="Status"))
mydata <- rename(mydata, c(Average.score..grade.="Score"))
mydata <- rename(mydata, c(Height..in.="Height"))
mydata <- rename(mydata, c(Newspaper.readership..times.wk.="Read"))
head(mydata)

#Categorical Data : Frequencies/Crosstabs
table(mydata$Gender)
table(mydata$Read)

# Two-way tables
readgender <- table(mydata$Read,mydata$Gender)
readgender
addmargins(readgender) # Adding row/col margins

prop.table(readgender,1) # Row proportions
round(prop.table(readgender,1), 2) # Round col prop to 2 digits
round(100*prop.table(readgender,1), 2) # Round col prop to 2 digits (percents)
addmargins(round(prop.table(readgender,1), 2),2) # Round col prop to 2 digits



prop.table(readgender,2) # Column proportions
round(prop.table(readgender,2), 2) # Round column prop to 2 digits
round(100*prop.table(readgender,2), 2) # Round column prop to 2 digits (percents)

addmargins(round(prop.table(readgender,2), 2),1) # Round col prop to 2 digits
prop.table(readgender) # Tot proportions
round(prop.table(readgender),2) # Tot proportions rounded
round(100*prop.table(readgender),2) # Tot proportions rounded

chisq.test(readgender) # Do chisq test Ho: no relathionship
fisher.test(readgender) # Do fisher'exact test Ho: no relationship

install.packages("vcd")
library(vcd)

assocstats(readgender) # First two are assoc measures, last three show degree of association.
# NOTE: Chi-sqr = sum (obs-exp)^2/exp. Degrees of freedom for Chi-sqr are (r-1)*(c-1)
# NOTE: Chi-sqr contribution = (obs-exp)^2/exp
# Cramer's V = sqrt(Chi-sqr/N*min). Where N is sample size and min is a the minimum of (r-1) or (c-1)

# 3-way crosstabs
table3 <- xtabs(~Read+Major+Gender, data=mydata)
table3
ftable(table3)

getwd()
scores=c(78,93,68,84,90,74,64,55,80)
scores
sort(scores)

max(scores)
min(scores)

quantile(scores)

quantile(scores,0.25)
par(mfrow=c(1,2))
boxplot(scores)
abline(h=min(scores), col= "Blue")
abline(h=max(scores), col= "Red")
abline(h=median(scores), col= "Yello")
abline(h=quantile(scores, c(0.25, 0.75)), col= "Green")

library(moments)

x<-c(20,21,31,298,32,33,35)
skewness(x)
hist(x)
x=rnorm(50,10,10)#r norm normal distribution
skewness(x)  
hist(x,breaks=10,col='blue',xlab='x',main='Histogram with normal curve')   
h =hist(x, breaks = 10, col="White", xlab="X",
         main="Histogram with Normal Curve")
xfit <-seq(min(x), max(x), length=40)
yfit <-dnorm(xfit, mean=mean(x), sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)

x=rnorm(50,10,10)#r norm normal distribution
skewness(x)  
hist(x,breaks=10,col='blue',xlab='x',main='Histogram with normal curve')   
h =hist(x, breaks = 10, col="White", xlab="X",
         main="Histogram with Normal Curve")
xfit <-seq(min(x), max(x), length=40)
yfit <-dnorm(xfit, mean=mean(x), sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)  
lines(xfit,yfit,col='blue',lwd=2)

install.packages("Hmisc")  
corona=read.csv('COVID19_line_list_data.csv')
library(hmisc)
describe(corona)
dim(corona)
corona$death_dummy=as.integer(corona$death!=0)
corona$death_dummy
corona=subset(corona,death_dummy==1)
dead
alive=subset(corona,death_dummy==0)
alive
t.test(alive$age,corona$age,alternative='two sided',conf.level=0.99)
# normall in a t test if p value is less than .05 reject null hypothesis

