HW 0408 解答
================
2024-05-02

*1. This question should be answered using the Weekly data set, which is
part of the ISLR2 package. This data contains 1089 weekly returns for 21
years, from the beginning of 1990 to the end of 2010.*

``` r
library(ISLR2)
```

    ## Warning: 套件 'ISLR2' 是用 R 版本 4.3.2 來建造的

``` r
attach(Weekly)
```

*(a) Produce some numerical or graphical summaries of the Weekly data.
Do there appear to be any patterns? (use pairs( ), cor( ))*

將類別變數 Direction 轉為 數值變數 $y$。令 $y = 1$ 代表 Direction$=$ Up,
$y=0$ 代表 Direction $=$ Down。

``` r
y<-ifelse(Direction=="Up",1,0)
```

``` r
pairs(data.frame(y,Weekly[-9]))
```

![](HW0408-Solution_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
從變數倆倆的分布圖，可看出 Volume 和 Year 有正相關，Today 和 Direction
變數也有相關性。

``` r
round(cor(data.frame(y,Weekly[-9])),digits=2)
```

    ##            y  Year  Lag1  Lag2  Lag3  Lag4  Lag5 Volume Today
    ## y       1.00 -0.02 -0.05  0.07 -0.02 -0.02 -0.02  -0.02  0.72
    ## Year   -0.02  1.00 -0.03 -0.03 -0.03 -0.03 -0.03   0.84 -0.03
    ## Lag1   -0.05 -0.03  1.00 -0.07  0.06 -0.07 -0.01  -0.06 -0.08
    ## Lag2    0.07 -0.03 -0.07  1.00 -0.08  0.06 -0.07  -0.09  0.06
    ## Lag3   -0.02 -0.03  0.06 -0.08  1.00 -0.08  0.06  -0.07 -0.07
    ## Lag4   -0.02 -0.03 -0.07  0.06 -0.08  1.00 -0.08  -0.06 -0.01
    ## Lag5   -0.02 -0.03 -0.01 -0.07  0.06 -0.08  1.00  -0.06  0.01
    ## Volume -0.02  0.84 -0.06 -0.09 -0.07 -0.06 -0.06   1.00 -0.03
    ## Today   0.72 -0.03 -0.08  0.06 -0.07 -0.01  0.01  -0.03  1.00

由變數之間的相關係數也可知，Year 和 Volume 有正相關 (相關係數 0.84),
Today 和 y 也有正相關(相關係數 0.72) (Today 的值較大則 Direction 為 up
的比例也較高)

*(b) Use the full data set to perform a logistic regression with
Direction as the response and the five lag variables plus Volume as
predictors. Use the summary function to print the results. Do any of the
predictors appear to be statistically significant? If so, which ones?
Give a numerical interpretation to the effect of the significant
predictors.*

``` r
r<-glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,family="binomial",data=Weekly)
summary(r)
```

    ## 
    ## Call:
    ## glm(formula = Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + 
    ##     Volume, family = "binomial", data = Weekly)
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)   
    ## (Intercept)  0.26686    0.08593   3.106   0.0019 **
    ## Lag1        -0.04127    0.02641  -1.563   0.1181   
    ## Lag2         0.05844    0.02686   2.175   0.0296 * 
    ## Lag3        -0.01606    0.02666  -0.602   0.5469   
    ## Lag4        -0.02779    0.02646  -1.050   0.2937   
    ## Lag5        -0.01447    0.02638  -0.549   0.5833   
    ## Volume      -0.02274    0.03690  -0.616   0.5377   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 1496.2  on 1088  degrees of freedom
    ## Residual deviance: 1486.4  on 1082  degrees of freedom
    ## AIC: 1500.4
    ## 
    ## Number of Fisher Scoring iterations: 4

Lag2 appear to be statistically significant (p-value = 0.0296 \< 0.05)
Lag2 的係數為 0.058，代表在其他變數不變的情況下，Lag2 每增加一單位，則
Direction 為 Up 的 odds 會變為原來的 $1.06 (=e^{0.058)}$ 倍。

(在其他變數不變的情況下，Lag2 每增加一單位，則 Direction 為 Up 的 log
odds 會增加 $0.058$)

*(c) Compute the confusion matrix and overall fraction of correct
predictions. Explain what the confusion matrix is telling you.*

``` r
p_hat<-predict(r,type="response")

head(p_hat)
```

    ##         1         2         3         4         5         6 
    ## 0.6086249 0.6010314 0.5875699 0.4816416 0.6169013 0.5684190

``` r
y_hat<-ifelse(p_hat>0.5,1,0)

table(y_hat,y)
```

    ##      y
    ## y_hat   0   1
    ##     0  54  48
    ##     1 430 557

The over all fraction of correct predictions 為
$\frac{54+557}{1089}=0.561$。

*(d) Now fit the logistic regression model using a training data period
from 1990 to 2008, with Lag2 as the only predictor. Compute the
confusion matrix and the overall fraction of correct predictions for the
held out data (That is, the data from 2009 and 2010).*

``` r
train<-Year<=2008

Weekly.train<-Weekly[train==TRUE,]
Weekly.test<-Weekly[train==FALSE,]

r.train<-glm(Direction~Lag2,family="binomial",data=Weekly.train)

p_hat.test<-predict(r.train,newdata=Weekly.test,type="response")

y_hat.test<-ifelse(p_hat.test>0.5,1,0)
y.test<-ifelse(Weekly.test$Direction=="Up",1,0)

table(y_hat.test,y.test)
```

    ##           y.test
    ## y_hat.test  0  1
    ##          0  9  5
    ##          1 34 56

The overall fraction of correct predictions for the held out data 為
$\frac{9+56}{9+56+5+34}=0.625$

*2*

$$log(\frac{p(x)}{1-p(x)})=\beta_0+\beta_1 x_1 + \beta_2 x_2$$
$$\frac{p(x)}{1-p(x)}=e^{\beta_0+\beta_1 x_1 + \beta_2 x_2}$$

$$ p(x) = e^{\beta_0+\beta_1 x_1 + \beta_2 x_2} -e^{\beta_0+\beta_1 x_1 + \beta_2 x_2} p(x)$$

$$ (1+e^{\beta_0+\beta_1 x_1 + \beta_2 x_2}) p(x) = e^{\beta_0+\beta_1 x_1 + \beta_2 x_2} $$

$$ p(x) = \frac{e^{\beta_0+\beta_1 x_1 + \beta_2 x_2}}{1+e^{\beta_0+\beta_1 x_1 + \beta_2 x_2}} $$
