#
# Bong Ju Kang
# R기반의 통계분석: 기초부터 활용까지
# 
# created: 6/10/2019
# name: 02_stat_intro_add_yyyymmdd.R
#

#
# 통계학이란?
#

graph_path = getwd()
# "C:/Users/banene/OneDrive/KMU/project"

# 예제:
# Yahoo Finance 에서 2008년 1월 1일 부터 현재까지의 
# 종가 기준의 삼성전자 시계열 도표(time series plot)를
# 그려보자.


# install.packages("quantmod")
library(quantmod)

# 삼성전자의 야후 코드
symbol <- c("005930.KS")

options("getSymbols.warning4.0"=FALSE)
df <- getSymbols(symbol, src="yahoo", env = NULL,  
                 from=as.Date("2018-01-01"))

str(df)
class(df)


# 종가 기준: "005930.KS.Open" "005930.KS.High" "005930.KS.Low" "005930.KS.Close"...
pngfile <- paste0(graph_path, './image/그림 1.2.png')
png(filename =pngfile, width=10, height = 6, 
    units = 'in', res=1000)

# windows(width=1000, height=500)
plot(df[, 4], main='')

dev.off()

# 과대/과소 추출(over, under sampling) -----
# 예제
# 1 그룹은 전부 추출하고 
# 0 그룹은 1그룹과 크기가 같은 표본을 추출한다.

# 데이터 구성
set.seed(123)
pop <- data.frame(
    group = c(rep('1', 10), rep('0', 100)),
    x = runif(110)
)


#
# 단순 막대 도표
#

# 예제: 
# 데이터 구성
plot_data <- data.frame(
    names=c('Apple', 'Samsung', 'China All'),
    bar_height=c(30, 50, 20)
)


#
# 그룹 막대 도표
#

# 예제:
# 데이터 구성

plot_df <- data.frame(
    group = rep(c('Apple', 'Samsung','China'), 3),
    quarter = rep(c('2Q/2018', '3Q/2018', '4Q/2018'),
                  each=3),
    count = c(40, 40, 20, 30, 45, 25, 10, 50, 40)
)


#
# 파이 도표
#

# 예제:
# 데이터 생성

plot_df <- data.frame(
    group = rep(c('Global Market Share', 'China Market Share'), 
                each=3),
    labels = rep(c('Apple', 'Samsung', 'China All'), 2),
    sizes = c(30, 50, 20, 11, 7, 100)
    )


#
# 선 도표
#

# 예제:
# 데이터 구성

library(quantmod)
# 삼성전자의 야후 코드
# https://finance.yahoo.com/quote/005930.KS/

symbol <- c("005930.KS")
df <- getSymbols(symbol, src="yahoo",env = NULL,  
                 from=as.Date("2014-01-01"))
str(df)


#
# 비교 선도표
#

# 예제:
# 데이터 생성
# LG화학의 야후 코드
# https://finance.yahoo.com/quote/051910.KS/

symbol <- c("051910.KS")
df2 <- getSymbols(symbol, src="yahoo",env = NULL,  
                 from=as.Date("2014-01-01"))

# 데이터프레임으로 전환
ss <- as.data.frame(df$`005930.KS.Close`)
colnames(ss) <- c('samsung')
rownames(ss)

lg <- as.data.frame(as.vector(df2$`051910.KS.Close`))
colnames(lg) <- c('lgchem')
rownames(lg)


#
# 히스토그램: 구간수(bins) 비교
#

# 예제:

# 데이터 생성
library(quantmod)
# 삼성전자의 야후 코드
# https://finance.yahoo.com/quote/005930.KS/

symbol <- c("005930.KS")
df <- getSymbols(symbol, src="yahoo",env = NULL,  
                 from=as.Date("2014-01-01"))
str(df)

price <-  df$`005930.KS.Close`


#
# 산점도
#

plot(ss$samsung, lg$lgchem, pch=20, cex=0.8,
     xlab='삼성전자 주가',
     ylab='LG화학 주가',
     main='삼성전자 대 LG화학 주가 상관관계')


#
# 열지도 (전형적인 예제)
#

# 데이터 생성
# [HOUSING] 

# URL로부터 데이터 읽기
url <- c("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
df <- read.table(url)
str(df)

# 변수명 새로 주기
names(df) <- c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE",
               "DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV")
cormat <- as.matrix(cor(df))

# 빨간 색깔로 25개의 색깔 만들기
col <- colorRampPalette(c('white', 'red'))(25)
library(lattice)
levelplot(cormat, col=col, col.regions=col,
          main='변수들의 상관관계 열지도', 
          xlab='변수명', 
          ylab='변수명')

