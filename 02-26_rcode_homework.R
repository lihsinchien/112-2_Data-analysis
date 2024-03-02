x <- matrix(data<-c(1,2,3,4),nrow=2,ncol=2,byrow=TRUE)

## 基本運算, +,-,*,/,^

2+2
5-3
5*3
5/2
5^3
sqrt(2)

x<-c(1,6,2)
y<-c(2,1,1)

x+y
x*y
3*y
y^2
sqrt(y)

## 生成 normal 分配資料

x<-rnorm(50)
x
mean(x)

set.seed(123)
x<-rnorm(50)
x
mean(x) #sample mean
var(x) #sample variance

sum(x)

sum((x-mean(x))^2)/49
sum((x-mean(x))^2)/50

sqrt(var(x)) # standard error 樣本標準差

?rnorm

set.seed(3)
x<-rnorm(100,mean=50,sd=0.1)
y<-x+rnorm(100,mean=0,sd=0.1)

cor(x,y)

## Homework: pearson correlation coefficient

a1<-sum((x-mean(x))*(y-mean(y)))
a2<-sqrt(sum((x-mean(x))^2)*sum((y-mean(y))^2))
a1/a2 


