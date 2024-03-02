
# 向量

x <- c(1,6,2)
x # print x
y <- c(1,4,3)
y

x+y

# 向量長度
length(x)

# 列出目前有的變數
ls()

# 刪除現有變數
rm(x,y)
ls()

rm(list = ls()) # 刪除所有變數

#查詢指令內容

help(rm)
?rm

#建立矩陣
?matrix
x <- matrix(data<-c(1,2,3,4),nrow=2,ncol=2)
x
