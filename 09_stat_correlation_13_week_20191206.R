#
# Bong Ju Kang
# R을 이용한 통계분석의 이해와 활용
# 
# created: 3/18/2019
# name: 09_stat_correlation_xxxxxxxx.R
#

#
#
# 상관분석
# 
#
#

#
# 데이터 구성
#

# [HOUSING] 데이터
url <- c("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
df <- read.table(url)
head(df)
names(df) <- tolower(c('CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT','MEDV'))

# 이미지 파일 저장 경로
graph_path = paste0(getwd(), '/image')

# 산점도
pngfile <- paste0(graph_path, '/그림 10.1.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

attach(df)
plot(rm, medv, cex=0.7, xlab='방개수', ylab='주택중위가격', main='[HOUSING]데이터')
detach(df)

dev.off()

# 예제
# [HOUSING] 데이터에서 방의 개수(RM)와 
# 주택 중위 가격(MEDV)의 상관계수를 구하세요.



# 해답
# 표본 상관계수 공식에 의한 직접계산
nom <- (t(df$rm) %*% df$medv)-nrow(df)*mean(df$rm)*mean(df$medv)
denom <- (nrow(df)-1)*sd(df$rm)*sd(df$medv)
nom / denom

# 함수 이용 확인 
cor(df$rm, df$medv)

# cosine 함수 이용
library(lsa)
cosine(df$rm-mean(df$rm), df$medv-mean(df$medv))


# 산점도 행렬
pngfile <- paste0(graph_path, '/그림 10.3.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

pairs(df[c('rm', 'age', 'dis', 'medv')], cex=0.5)

dev.off()


## 표본 상관계수의 분포

# 표본분포 추정
out <- c()
set.seed(1234)
num_samples <- c(200)
size <- c(100)
for (i in 1:num_samples) {
  index <- sample(1:nrow(df), size)
  sdf <- df[index, c('rm', 'medv')]  
  out[i] <- cor(sdf$rm, sdf$medv)
}

# 왜도 계산
library(e1071)
skewness(out, type=2) # sas 버전 


# 그림 생성
library(latex2exp)
# latex2exp_examples()

pngfile <- paste0(graph_path, '/그림 10.4.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

hist(out, main="표본상관계수의 분포", xlab='표본상관계수(r)', freq=F)
text(mean(out),0, TeX('$\\bar{r}$'), cex=2)

dev.off()

# t와 r의 관계식 확인
size <- 100

pngfile <- paste0(graph_path, '/그림 10.5.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

par('mar') # default setting
par(mar=c(5.1, 7.1, 4.1, 2.1)) 
curve(sqrt(size-2)*x/(sqrt(1-x^2)), from=-1, to=1, 
      ylab=TeX('$\\frac{\\sqrt{n-2} R}{\\sqrt{1-R^2}}$'), 
      xlab='R')
par(mar=c(5.1, 4.1, 4.1, 2.1)) # default setting

dev.off()


## 모상관계수 추론
# 예제
# [HOUSING] 데이터에서 방의 개수(RM)와 주택 중위 가격(MEDV)과는 
# 관련이 있다는 가설을 검증하세요. 단, 상관계수의 유의성으로 검증하세요.



# 해답
# [HOUSING] 데이터
library(data.table)
url <- c("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
df <- fread(url)
head(df)
names(df) <- tolower(c('CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT','MEDV'))

# 표본 상관계수 계산
r0 <- cor(df$rm, df$medv)
r0

# T값 계산
size <- nrow(df)
print(size)

t0 <- sqrt(size-2)*r0 / sqrt(1-r0^2)
print(t0)

# P값 계산
1-pt(t0, df=size-2)
# curve(dt(x, df=size-2), from=-3, to=3)

# 기각역 계산
alpha <- c(0.05)
c_value <- 2*qt(1-alpha/2, df=size-2)
c_value


# 함수에 의한 계산 및 확인
cor.test(df$rm, df$medv, alternative = c('two.sided'), conf.level=0.95)


#
# 신뢰 구간 계산
#

# Fisher 변환 이용을 이용한 신뢰 구간 구하기
alpha = 0.05
z0 <- 1/2*log((1+r0)/(1-r0))

# z0 의 분산은 1/(n-3)
# z0 기준으로 하한, 상한 값 계산
z_lower <- z0 - qnorm(1-alpha/2)*sqrt(1/(size-3))
z_upper <- z0 + qnorm(1-alpha/2)*sqrt(1/(size-3))

# 상관계수로 환원
r_lower <- tanh(z_lower)
r_upper <- tanh(z_upper)
print(c(r_lower, r_upper))

# 함수에 의한 계산 및 확인
cor.test(df$rm, df$medv, alternative = c('two.sided'), conf.level=0.95)

# 그림으로 확인
plot(df$rm, df$medv, cex=0.7, xlab='방개수', ylab='주택중위가격')
abline(lm(df$medv~df$rm), col='blue')

