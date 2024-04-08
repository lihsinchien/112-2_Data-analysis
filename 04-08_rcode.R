##################################################
### Ch4 Classification Method
### Section 4.3 logistic regression ##############
### 04-01
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

#################
### 04-08
#################
# prediction
glm.probs <- predict(glm.fit , type = "response")
glm.probs[1:10]

glm.xb <- predict(glm.fit)
tmp<-glm.xb[1:10]
exp(tmp)/(1+exp(tmp))

# model performance: make the Confusion Matrix
glm.pred<- ifelse(glm.probs>.5,"Up","Down")
table(glm.pred,Direction)

(507+145)/1250 #correctly classified proportion
mean(glm.pred == Direction)

## the training error is often overly optimistic
## split data into training set and testing set:
## training set: "Year" < 2005

table(Year)
train <- (Year < 2005)
head(train)
table(train)
head(!train)
table(!train)

Smarket.2005 <- Smarket[!train, ]
dim(Smarket.2005)
Direction.2005 <- Direction[!train]

## fit the model using the training data
glm.fit.train <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume ,
  data = Smarket , family = binomial , subset = train)
summary(glm.fit.train)

# model performance using the testing set 
glm.probs <- predict(glm.fit.train, Smarket.2005, type="response")
glm.pred <- ifelse(glm.probs> .5,"Up","Down")
table(glm.pred, Direction.2005)
mean(glm.pred==Direction.2005) # worse than random selection
mean(glm.pred!=Direction.2005)


glm.fit.train2 <- glm(Direction ~ Lag1 + Lag2 , data = Smarket ,
                family = binomial , subset = train)
summary(glm.fit.train2)

glm.probs <- predict(glm.fit.train2, Smarket.2005, type="response")
glm.pred <- ifelse(glm.probs> .5,"Up","Down")
table(glm.pred, Direction.2005)
mean(glm.pred==Direction.2005)
106/(106+76) # conditional on predict "Up", 58% accuracy rate

x.new<-data.frame(Lag1 = c(1.2, 1.5), Lag2 = c(1.1, -0.8))
x.new
predict(glm.fits, newdata = x.new, type = "response")
