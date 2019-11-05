#
# Bong Ju Kang
# R을 이용한 통계분석의 이해와 활용
# 
# created: 3/18/2019
# name: 03_stat_descriptive_9_week_xxxxxxxx.R
#

#
#
#
# 데이터 기술
#
#
#

# 데이터 구성
url <- c('https://github.com/bong-ju-kang/kmu-mba-statistics/raw/master/Data/bank.csv')
df <- read.csv(url)
str(df)
names(df)


# 기술 통계량
# 숫자형 변수
summary(df)

# install.packages('Hmisc')
# Harrell Miscellaneous
library(Hmisc)
describe(df)

#
# 범주형 자료에 대한 요약
#

# 1원 빈도표
table(df$marital)
print(table(df$marital)/sum(table(df$marital)), digits=4)


# 예제:
# 빈도표에 대한 막대 도표와 파이 도표를 생성하세요.



# 해답
plot(as.factor(df$marital), main='결혼상태와 빈도')
pie(table(df$marital), main='결혼상태와 상대빈도')

# 예제:
# 1) “y”, “marital” 변수에 대한 2원 빈도표를 생성하세요.
# 2) 행 합에 대한 각 셀의 비율을 계산하세요.



# 해답
# 2원 빈도표
tbl <- table(df[c('y', 'marital')])
# tbl <- table(df$y, df$marital)
print(tbl)

# 행 합에 대한 비율을 계산
rs <- rowSums(tbl)
# cbind(tbl, rs)
tbl/rs

#
# 범주 변수에 대한 연속 변수의 통계량
#

# 예제:
# 1) ‘y’ 변수의 각각의 값에 대한 ‘pdays’의 평균 값을 구하세요.
# 2) ‘y’에 값에 따른 상자 그림을 그려보세요.



# 해답
# 기본 방법1:
class(df$y)
mn <- tapply(df$pdays, df$y, mean)
# 평균값을 갖는 상자 그림
boxplot(pdays ~ y, data=df)
text(c(1, 2), mn,  '*', cex=1.5, col='red')

# 기본 방법2: aggregate 이용
res <- aggregate(pdays ~ y, df, mean)
print(res)
# 평균값을 갖는 상자 그림
boxplot(pdays ~y, df, horizontal = T)
text(res$pdays, c(1, 2),  '*', cex=1.5, col='red')

#
# 연속형 자료에 대한 요약
#

# 모든 값에 따른 건수
tbl <- table(df$age)
print(tbl)
plot(tbl)
length(tbl)

# 최대 건수를 주는 값
which.max(tbl)
tbl[which.max(tbl)]

# 요약 함수
summary(df$age)
nrow(subset(df, age <33 ))/nrow(df)
nrow(subset(df, age <34 ))/nrow(df)

# 줄기-잎 그림
stem(df$age)

summary(df$balance)
stem(df$balance)

# 예제:
# 1) ‘age’ 에 대한 1 백분위수와 99 백분위수를 구하세요.



# 해답
# 일반적인 분위수(quantile)
quantile(df$age, probs=c(0.01, 0.99))

# 기본 히스토그램
hist(df$age, main='나이 히스토그램', 
     xlab='나이', ylab='빈도')

# 예제:
# 1) 셀의 수가 50개인 경우의 히스토그램을 생성하세요.
# 2) 셀의 수가 20개인 경우(균등 폭)의 각 셀의 경계값을 구하세요.
# 3) 2)의 각 경계 값으로 구간을 구성하고 각 구간별 빈도를 구하세요.



# 해답
# 셀의 수의 조정:breaks
hist(df$age, breaks=50,
     main='나이 히스토그램', xlab='나이', ylab='빈도')


# 빈 또는 버킷 구성하기
# 20 등분 구성하기: 나누는 경계값 생성
min <- min(df$age)
max <- max(df$age)
width <- (max-min)/20 # 20 등분
print(width)

breaks <- seq(min, max, width)
print(breaks)

# 20등분으로 나누기: 경계값을 기준으로 구간 구성
bins <- table(cut(df$age, breaks=breaks, 
                  include.lowest=T))
print(bins)
plot(bins, main='나이 막대도표(수동 계산)', 
     xlab='나이 구간', ylab='빈도')


#
# 분포에 대한 이해
#

# 원 데이터:오른쪽으로 완만한 분포(skewed to the right)
hist(df$balance, breaks=30, main='은행잔액 히스토그램', xlab='잔액', ylab='빈도')
text(median(df$balance), 0, '|', cex=1.5, col='red')
text(mean(df$balance), 0, '*', cex=1.5, col='red')
legend('topright', legend=c('|: 중간값', '*: 평균값'), 
       bty='n', text.col='red')


library(latex2exp)
# 적절한 변환: 제곱근/로그 변환
x_min <- min(df$balance)
which(df$balance==min(df$balance))
new_x <- log10(df$balance-x_min)

# 최소값은 -Inf: 제외됨
sum(new_x == -Inf) 

hist(new_x, breaks=30,
     main='',
     xlab=TeX('$log_{10} (잔액)$'), ylab='빈도')


# 상자그림(boxplot)
boxplot(df$age, main='', xlab='나이', horizontal = T)
text(mean(df$age), y=1, '*', col='red', cex=2 )


# 예제
# 1) [BANK] 데이터의 모든 연속형 변수 목록을 생성하세요.
# 2) 모든 연속형 변수에 대한 히스토그램을 생성하세요.



# 해답
# 연속형 변수 선택
is_num <- sapply(df, is.numeric)
num_vars <- colnames(df)[is_num]


# 모든 연속형 변수에 대하여 히스토그램 생성
# get: 문자열 이름으로 객체 찾기
attach(df)
x_grid <- ceil(sqrt(length(num_vars)))
par(mfrow=c(x_grid, x_grid))
for (var in num_vars) {
  hist(get(var), main=paste0('히스토그램(', var, ')'),
            xlab=var)
}
par(mfrow=c(1, 1))
detach(df)


#
# 산점도 (scatterplot)
#

# 단순 산점도

plot(df$age, df$balance, 
     cex=0.5, 
     main='나이 대 잔액 산점도', 
     xlab='나이',
     ylab='잔액')
rug(df$balance, side=2)
rug(df$age, side=1)


# 산점도 행렬
# 연속형 변수 선택을 위한 함수
find_num_vars <- function(df){
  is_num <- sapply(df, is.numeric)
  num_vars <- colnames(df)[is_num]
  return(num_vars)
}
num_vars <- find_num_vars(df)
pairs(df[num_vars], cex=0.7)






