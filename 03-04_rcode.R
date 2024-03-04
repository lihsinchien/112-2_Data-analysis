

set.seed(3)
x<-rnorm(100,mean=50,sd=0.1)
y<-x+rnorm(100,mean=0,sd=0.1)

cor(x,y)

## Homework: pearson correlation coefficient

a1<-sum((x-mean(x))*(y-mean(y)))
a2<-sqrt(sum((x-mean(x))^2)*sum((y-mean(y))^2))
a1/a2 

###################################
## 2024-03-04
####################################

############################################
# textbook 2.3.2 Graphics
############################################

# 生成數列

x<-1:10
x
seq(1,10)
seq(-pi,pi,length=10)
seq(from=1,length=10,by=1)

y<-x+rnorm(10)

# 畫圖 plot()
plot(x,y)
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y",xlim=c(0,10))
abline(a=0,b=1)

getwd() #目前的工作目錄, 設定工作目錄指令 setwd("D://course//112-2//BigDataAnalysis//112-2_Data-analysis")

pdf("Figure.pdf")
plot(x,y,col="green")
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",main="Plot of X vs Y")
dev.off()
dir() #顯示目前資料夾的所有檔案

# 讀寫資料

x<-rnorm(10)
y<-rnorm(10,mean=1,sd=.1)
z<-rep(c("F","M"),5)

mat.c<-cbind(x,y)
mat.r<-rbind(x,y)

cbind(x,y,z)
data<-data.frame(x,y,z)

#寫出 .txt檔
write.table(data,file="data.txt",row.names = F)
#寫出 .csv檔
write.csv(data,file="data.csv",row.names = F)

#讀入.txt檔
data2<-read.table(file="data.txt",header=T)
#讀入 .csv
data3<-read.csv(file="data.csv")

data2
data3
