###################################
## 03-11: Simple linear regression
###################################

library(ISLR2) #引入 ISLR2 套件,裡面有分析用的資料 Boston
head(Boston) #查看前 6 筆樣本內容
dim(Boston)  #查看資料筆數

?Boston      #在 help 視窗顯示資料內容 

# 畫分佈圖看 x, y 變數有無線性相關
plot(Boston$lstat,Boston$medv, xlab="lstat(中低收入戶比例)", ylab="medv(房價)")

# 估計 linear regression model
lm.fit <- lm(medv~lstat, data=Boston) #將模型配適結果存入 lm.fit 中
summary(lm.fit) # 顯示配式結果
confint(lm.fit) #估計量信賴區間

########################################
## 03-18: Multiple linear regression
########################################

plot(Boston) #畫出所有變數的兩兩分佈圖
round(cor(Boston),digits=2) #計算相關係數

library(ISLR2)
lm.fit2<-lm(medv~lstat+age,data=Boston) #放入兩個解釋變數
summary(lm.fit2)

lm.fit3<-lm(medv~., data=Boston)
summary(lm.fit3) # 放入資料中所有的其他欄位當解釋變數

lm.fit4<-lm(medv~.-age, data=Boston)
summary(lm.fit4) # age 外的所有其他變數

round(cor(Boston),digits=2)

## Variable Selection: Backward

# p-value < 0.05
lm.fit3.1<-lm(medv~.-indus,data=Boston)
summary(lm.fit3.1)

lm.fit3.2<-lm(medv~.-indus-age,data=Boston)
summary(lm.fit3.2)

# AIC 
drop1(lm.fit3)
?step 
lm.fit.backward.aic<-step(lm.fit3) #Choose a model by AIC

## transform

lm.fit5<-lm(medv~poly(lstat,5),data=Boston)
plot(lm.fit5)

## Qualitative predictors

head(Carseats)

lm.fit<-lm(Sales ~., data = Carseats)
summary(lm.fit)

attach(Carseats)
contrasts(ShelveLoc)
?contrasts

## diagnosis
par(mfrow=c(2,2))
plot(lm.fit)

dev.off()
plot(lm.fit,which=1)
par(mfrow=c(1,2))
plot(lm.fit,which=c(1,3))
