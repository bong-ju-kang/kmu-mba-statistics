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



# 해답
size <- sum(pop$group=='1')
smp_1  <- pop[pop$group=='1',]
index <- sample(which(pop$group=='0'), 10)
smp_2 = pop[index, ]
out <- rbind(smp_1, smp_2)
print(out)


#
# 단순 막대 도표
#

# 예제: 
# 데이터 구성
plot_data <- data.frame(
    names=c('Apple', 'Samsung', 'China All'),
    bar_height=c(30, 50, 20)
)



# 해답
barplot(height = plot_data$bar_height,  
        names.arg = plot_data$names, 
        col='white'
)
title(xlab='회사', ylab='시장점유율')

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
# 벡터를 인자로 인코딩: 가만 두면 자동으로 정렬함
plot_df$group <- factor(plot_df$group, 
                        levels = c('Apple', 'Samsung','China'))



# 해답
barplot(plot_df$count ~  
          plot_df$group + plot_df$quarter,
    col=gray(c(0.5, 0.7, 0.9)),
    ylab='점유율',
    xlab='분기',
    main='그룹 막대 도표',
    beside=TRUE, 
    legend=TRUE, 
    args.legend=list(bty='n')
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



# 해답
oldpar <- par(no.readonly = TRUE)
par(mfrow=c(1,2))
par(oma=c(0, 0, 2, 0))
par(mar=c(1, 1, 4, 1))
pie(plot_df[plot_df$group=='Global Market Share',]$sizes, 
    labels=plot_df[plot_df$group=='Global Market Share']$labels, 
    col=gray(c(0.5, 0.7, 0.9)), 
    main = 'Global Market Share')
pie(plot_df[plot_df$group=='China Market Share',]$sizes, 
    labels=plot_df[plot_df$group=='China Market Share',]$labels, 
    col=gray(c(0.5, 0.7, 0.9)), 
    main = 'China Market Share')
mtext('Market Shares: Global vs. Chaina', outer = TRUE, cex = 1.5)
par(oldpar)


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



# 해답
# 데이터프레임으로 전환
ss <- as.data.frame(df$`005930.KS.Close`)
colnames(ss) <- c('samsung')
rownames(ss)

plot(as.Date(rownames(ss), '%Y-%m-%d'), ss$samsung, 
     type='l', 
     xlab='일(day)', 
     ylab='종가기준주가(원)', 
     main='최근6년 삼성전가 주가 추이'
)
# y축의 틱 값과 일치: 디폴트 그리드
grid(ny=NULL, nx=NA)

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



# 해답
plot(as.Date(rownames(ss), '%Y-%m-%d'), ss$samsung, 
     type='l', 
     xlab='일(day)', 
     ylab='종가기준주가(원)', 
     main='최근 6년 삼성전자 대 LG화학 주가 비교'
)

# 있는 그림에 추가로 새로운 그림 그리기
par(new=TRUE)

plot(as.Date(rownames(ss), '%Y-%m-%d'), lg$lgchem, 
     type='l', 
     lty='dotted',
     axes = F,
     xlab=NA, 
     ylab=NA
     )
axis(side=4)
legend('topleft', 
       legend=c('삼성전자', 'LG화학'), 
       lty = c('solid', 'dotted'),
       bty='n'
       )
par(new=F)




# 해답


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



# 해답
hist(price, breaks=30, 
     col=gray(0.7),
     xlab='종가기준 주가(원)',
     ylab='빈도',
     main='최근 6년 삼성전자 주가 분포', 
     sub='구간수 비교'
     )
par(new=T)

hist(price, breaks=10, 
     axes=F, ann=F, 
     lty=2,
    col=gray(0.9, alpha=0.9),
    border=gray(0.5, alpha=0.9)
     )
legend('topright', bty='n', 
       legend = c('구간수=30','구간수=10'),
       fill=gray(c(0.7, 0.9))
       )
par(new=F)

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

