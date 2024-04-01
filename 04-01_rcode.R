
##################################################
### Ch3 model diagnosis (03-25_rcode.R) ##########
##################################################

getwd() #get the working directory
setwd("C:\\Users\\user\\Documents\\LHChien") #set the working directory
#data<-read.table(file="C:\\Users\\user\\Documents\\LHChien\\savings.txt",header=T)
data<-read.table(file="savings.txt",header=T) 

head(data)
dim(data)

lmod<- lm(sr~.,data=data)
summary(lmod)

lmod.f<-step(lmod)
summary(lmod.f)

par(mfrow=c(2,2)) 
plot(lmod.f) 

dev.off()
plot(lmod.f,which=5)
plot(lmod.f,which=4)

##################################################
### Ch4 Classification Method
### Section 4.3 logistic regression ##############
##################################################

library(ISLR2)
head(Smarket)

?Smarket
#Daily percentage returns for the S&P 500 stock index between 2001 and 2005

## data overview
dim(Smarket)
pairs(Smarket)
attach(Smarket) #the database is attached to the R search path
plot(Volume)

## Model fitting
glm.fit <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data = Smarket , family = binomial)
coef(glm.fit)
summary(glm.fit)

contrasts(Direction) #check the coding: R code "Direction" as the dummy variable

