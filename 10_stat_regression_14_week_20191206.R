#
# Bong Ju Kang
# R을 이용한 통계분석의 이해와 활용
# 
# created: 3/18/2019
# name: 10_stat_regression_xxxxxxxx.R
#

#
#
# 단순 선형회귀 분석
# 
#

# 사전 정의 항목
graph_path <- paste0(getwd(), '/image')

#
# 데이터 구성
#

# [HOUSING] 데이터
url <- c("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
df <- read.table(url)
head(df)
names(df) <- tolower(c('CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT','MEDV'))


# 단순회귀직선

pngfile <- paste0(graph_path, '/그림 11.1.png')
png(filename =pngfile, width=5, height = 5, units = 'in', res=1000)

plot(df$rm, df$medv, cex=0.7, xlab='방개수', ylab='주택중위가격')
abline(lm(medv~rm, data=df), lty=1)

dev.off()

#
# 모수의 추정
#

# 단순회귀선 추정식
nom <- (df$rm %*% df$medv)-nrow(df)*mean(df$rm)*mean(df$medv)
denom <- (nrow(df)-1)*var(df$rm)
b1 <- nom / denom 
b0 <- mean(df$medv)-b1*mean(df$rm)
b <- c(b0, b1)
print(b)

# 함수에 의한 적합
lm(medv ~ rm, data=df)


# 단순회귀선(중심점 포함)
pngfile <- paste0(graph_path, '/그림 11.2.png')
png(filename =pngfile, width=5, height = 5, units = 'in', res=1000)

plot(df$rm, df$medv, cex=0.7, xlab='방개수', ylab='주택중위가격')
abline(lm(medv~rm, data=df))
text(mean(df$rm), mean(df$medv), '*', cex=5, col='red')
abline(v=mean(df$rm), lty=2)
abline(h=mean(df$medv), lty=2)
legend(4, 40, legend=c('*: 평균점'), box.col='white', text.col='red')

dev.off()

# 표본에 따른 회귀직선의 변화
pngfile <- paste0(graph_path, '/그림 11.3.png')
png(filename =pngfile, width=7, height = 7, units = 'in', res=1000)

x_grid <- seq(min(sdf$rm, na.rm=T),max(sdf$rm, na.rm=T), 0.1)
plot(df$rm, df$medv, cex=0.5, xlab='방개수', ylab='주택중위가격', 
     xlim=c(min(df$rm), max(df$rm)), ylim=c(min(df$medv), max(df$medv)))
out <- matrix(nrow=10, ncol=length(x_grid))
set.seed(123)
size <- c(100)
for (i in 1:10){
  index <- sample(1:nrow(df), size)
  sdf <- df[index, ]
  fit <- lm(medv~rm, data=sdf)
  abline(fit, col='gray')
  newdata <- data.frame(rm=x_grid)
  out[i, ] <- predict.lm(fit, newdata=newdata)
}

# 평균예측선 그리기
par(new=T)
plot(x_grid, colSums(out)/10, ann = F, xaxt='n', yaxt='n', type='l', lwd=3, lty=2,
     xlim=c(min(df$rm), max(df$rm)), ylim=c(min(df$medv), max(df$medv)))

# 전체 데이터 적합선 그리기
abline(lm(medv~rm, data=df), col='black', lwd=2 )

legend(4, 45, legend=c('표본별(크기:100) 추정 회귀직선', '추정 회귀직선 평균', '모 직선'), 
       cex=0.9,  
       lty=c(1,2, 1), lwd=c(1, 3, 2), box.col='white')


dev.off()

#
# 오차분산: MSE 의 추정
# 

# 예제
# [HOUSING] 데이터에서 방의 개수와 주택 중위값(목표변수)간의 
# 표본의 크기가 100인 회귀분석을 실시하고 난 후 오차 분산을 추정하세요. 



# 해답
set.seed(123456789)
size <- c(100)
sdf <- df[sample(1:nrow(df), size), ]

# 모델 적합
model <- lm(medv ~ rm, data=sdf)
predicted <- model$fitted.values

# library(RcppEigen)
# model <- fastLm(medv ~ rm, data=sdf)
# predicted <- model$fitted.values

# 오차분산 계산
sxx <- (nrow(sdf)-1)*var(sdf$rm)
syy <- (nrow(sdf)-1)*var(sdf$medv)
sxy <- cov(sdf$rm, sdf$medv)*(nrow(sdf)-1)
# sxy <- (df$rm-mean(sdf$rm))%*%(sdf$medv-mean(df$medv))
sse <- syy-sxy^2/sxx
mse <- sse / (nrow(sdf)-2)

sqrt(mse) # 오차표준오차(residual standard error)

# 함수 확인
summary(model)

## 변동의 분해에 의한 회귀직선의 유의미성 검증
size <- c(50)

# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

# 총변동
pngfile <- paste0(graph_path, '/그림 11.4.png')
png(filename =pngfile, width=10, height = 6, units = 'in', res=1000)

par(mfrow=c(1,2))

# 총변동만 그리기
plot(sdf$rm, sdf$medv, cex=0.7, xlab='방개수', ylab='주택중위가격', main='총 변동') 
fit <- lm(medv~rm, data=sdf)
abline(fit, col='gray')
abline(h=mean(sdf$medv))
segments(sdf$rm, mean(sdf$medv), sdf$rm, sdf$medv, col='black', lwd=1, lty=2)
legend(7, 15, legend=c('회귀직선', '평균선', '총변동' ), col=c('gray', 'black', 'black'), 
       lty=c(1, 1, 2), text.col=c('gray', 'black', 'black'),box.col="white")
# 총변동과 회귀변동
plot(sdf$rm, sdf$medv, cex=0.7, xlab='방개수', ylab='주택중위가격', main='회귀 및 잔차 변동') 
fit <- lm(medv~rm, data=sdf)
abline(fit, col='gray')
abline(h=mean(sdf$medv))
# 잔차변동
segments(sdf$rm, predict(fit, newdata=sdf), sdf$rm, sdf$medv, lwd=1, lty=3)
# 회귀변동
segments(sdf$rm, mean(sdf$medv), sdf$rm, predict(fit, newdata=sdf), lwd = 1, lty=5)
legend(7, 15, legend=c('잔차', '회귀' ), 
       lty=c(3, 5), box.col="white")

par(mfrow=c(1,1))

dev.off()

#
# 변동의 분해
# 
# 예제: 앞의 예제에서 결정계수 값을 구하세요.


# 해답
size <- c(100)

# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

# 변동 계산
SST <- (nrow(sdf)-1)*var(sdf$medv)
SSR <- ((nrow(sdf)-1)*cov(sdf$rm, sdf$medv))^2 / ((nrow(sdf)-1)*var(sdf$rm))
SSE <- SST-SSR
RSQ <- SSR/SST
print(RSQ)

# 추가 계산
RSQ_adj <- 1-(1-RSQ)*(nrow(sdf)-1)/(nrow(sdf)-2)
print(c(SST, SSE, SSR, RSQ, RSQ_adj))
sqrt_MSE <- sqrt(SSE / (nrow(sdf)-2 ))
  
# 함수로부터 계산: 결과값 확인
summary(lm(medv~rm, data=sdf))


#
# 모수의 추론
#

# 예제
# 100개의 표본을 구성한 후 기울기에 대한 95% 신뢰 구간을 구해보세요.



# 해답

# 회귀계수의 신뢰구간
size <- c(100)

# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

dof <- nrow(sdf)-2
alpha <- c(0.05)
t_value <- qt(1-alpha/2, df=dof)

# 오차분산의 계산
c <- (nrow(sdf)-1)*var(sdf$rm)
SST <- (nrow(sdf)-1)*var(sdf$medv)
SSR <- ((nrow(sdf)-1)*cov(sdf$rm, sdf$medv))^2 / ((nrow(sdf)-1)*var(sdf$rm))
SSE <- SST-SSR
sqrt_MSE <- sqrt(SSE/dof)
print(sqrt_MSE)

# 회귀계수 계산
b1 <- ((nrow(sdf)-1)*cov(sdf$rm, sdf$medv)) / ((nrow(sdf)-1)*var(sdf$rm))
print(b1)

# 확인
coef(lm(medv ~ rm, data=sdf))

# t 검증 통계량 계산
t_stat <- b1/sqrt_MSE*sqrt(c) # t 통계량 값 
print(t_stat)

# 100(1-alpha)% 신뢰구간
c(b1-c_value*sqrt_MSE/sqrt(c), b1+c_value*sqrt_MSE/sqrt(c))

# 함수 확인
fit <- lm(medv ~ rm, data=sdf)
confint.lm(fit, parm='rm', level=0.95)
confint.lm(fit) # 모든 모수에 대하여 
summary(fit)


## 회귀계수 가설 검증
# 예제
# 기울기에 대한 5% 유의수준 하의 검증



# 해답
# 회귀계수 계산
b1 <- ((nrow(sdf)-1)*cov(sdf$rm, sdf$medv)) / ((nrow(sdf)-1)*var(sdf$rm))

# t 검증 통계량 계산
t_stat <- b1/sqrt_MSE*sqrt(c) # t 통계량 값 
print(t_stat)

# P값 계산
p0 <- 2*(1 - pt(t_stat, df=dof))
p0

# 기각역 
c_value <- pt(1-alpha/2, df=dof)
c_value

# 함수 확인
fit <- lm(medv ~ rm, data=sdf)
summary(fit)

## 분산분석표에 의한 회귀직선의 유의성검증
# 예제
# 100개의 표본을 구성한 후 모 회귀직선의 유의미성에 대하여 
# 5% 유의 수준으로 검증하세요. 단, 분산 분석표를 이용하세요.



# 해답
#변동의 분해값 계산
size <- c(100)

# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

# 변동 계산
SST <- (nrow(sdf)-1)*var(sdf$medv)
SSR <- ((nrow(sdf)-1)*cov(sdf$rm, sdf$medv))^2 / ((nrow(sdf)-1)*var(sdf$rm))
SSE <- SST-SSR
c(SST, SSR, SSE)

n <- nrow(sdf)
MSE = SSE / (n-2)
MSR = SSR / 1
c(MSE, MSR)

f0 <- MSR/MSE
p0 <- 1 - pf(f0, df1=1, df2=n-2) 
c(f0, p0)
  
# 함수로부터 계산
# summary(lm(medv~rm, data=sdf))
fit <- lm(medv~rm, data=sdf)
anova(fit)


#
# 모회귀직선에 대한 신뢰 구간
# 

size <- c(100)
# 재현성을 위하여
set.seed(123) 
sdf <-  df[sample(1:nrow(df), size), ]

# 모델 적합
fit <- lm(medv~rm, data=sdf)
# fit <- fastLm(medv~rm, data=sdf)
# names(fit)
# summary(fit)


# 적합된 모델로 부터 가져올 정보 목록
sfit <- summary(fit)
names(sfit)

sigma <- sfit$sigma
sxx <- (nrow(sdf)-1)*var(sdf$rm)


# 하나의 적합값과 신뢰구간
x <- c(5)
se <- sigma*sqrt(1/nrow(sdf)+(x-mean(sdf$rm))^2/sxx) 
alpha <- c(0.05)
c_value <- qt(1-alpha/2, df=nrow(sdf)-2)
fitted <- predict.lm(fit, newdata=data.frame(rm=x)) # 예측값
lower <- fitted - c_value*se 
upper <- fitted + c_value*se
c(fitted, lower, upper)

# 함수 이용 값 확인
predict.lm(fit, newdata=data.frame(rm=x), interval = c('confidence'), level=0.95) # 예측구간


## 모회귀직선 신뢰구간: 신규 데이터 이용
# 데이터 생성
set.seed(1)
sdf <-  df[sample(1:nrow(df), size), ]
x <- sdf$rm

# 적합 및 예측값 구하기
fitted <- predict.lm (fit, newdata=data.frame(rm=x)) # 예측값
confi <- predict.lm(fit, newdata=data.frame(rm=x), 
                    interval = c('confidence'), 
                    level=0.95) # 예측구간
head(confi)


conf.df <- data.frame(x, confi)
# names(conf.df)
conf.df <- conf.df[order(conf.df$x),]

# 신뢰구간의 의미
class(confi)
confi[, 'lwr']

pngfile <- paste0(graph_path, '/그림 11.5.png')
png(filename =pngfile, width=7, height = 7, units = 'in', res=1000)

# 데이터와 적합된 회귀직선 그리기
plot(sdf$rm, sdf$medv, cex=0.5, xlim=c(3, 8.5), ylim=c(9,53), ann=F)
abline(a=coef(fit)[1], b=coef(fit)[2], lwd=0.5)
par(new=T)

# 하한선 그리기
plot(conf.df$x, conf.df$lwr, type='b', cex=0.3,lty=2,  xlim=c(3, 8.5), ylim=c(9,53), ann=F)
par(new=T)

# 상한선 그리기
plot(conf.df$x, conf.df$upr, type='b', cex=0.3,  lty=2, xlim=c(3, 8.5), ylim=c(9,53), ann=F)

# 범례 표시
legend(3, 50, legend=c('회귀직선', '신뢰구간'), lty=c(1,2), box.col='white')

# 표제 달기
title(xlab='방개수', ylab='주택중위값', main='모회귀직선의 신뢰구간')

dev.off()

#
# 오차가정에 대한 검증
#

## 표준화 잔차 계산
size <- c(100)
# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

# 모델 적합
fit <- lm(medv~rm, data=sdf)

# 1-h_ii 결과와 동일 여부 확인
1-lm.influence(fit)$hat
1-(1/n+(sdf$rm-mean(sdf$rm))^2/sxx)

# 내부 스튜던트화 잔차 또는 표준화 잔차
sigma <- summary(fit)$sigma
n <- nrow(sdf)
sxx <- (n-1)*var(sdf$rm)
Ti <- (sdf$medv-fit$fitted.values)/sqrt(sigma^2*(1-1/n-(sdf$rm-mean(sdf$rm))^2/sxx))
head(Ti)

# 함수 이용한 결과와 확인
head(rstandard(fit))
plot(fit)

#
# 표준화 잔차의 분포에 대한 이해
#

num_samples <- 500
size <- 100
res <- matrix(ncol=num_samples, nrow=size)
for (i in 1:num_samples){
  tmpdf <- df[sample(1:nrow(df), size), ]
  res[, i] <- rstandard(lm(medv~rm, data=tmpdf))
}
hist(c(res))


#
# 독립성 검증
# 

# 관측 번호에 따른 표준화 잔차 산점도
pngfile <- paste0(graph_path, '/그림 11.6.png')
png(filename =pngfile, width=8, height = 5, units = 'in', res=1000)

par(mfrow=c(1,2))
plot(rt(100, df=98), xlab='관측번호', ylab='t분포값')
plot(rstandard(fit), xlab='관측번호', ylab='표준화잔차')
par(mfrow=c(1,1))

dev.off()


#
# 등분산성 검증
# 

# 간단한 방법: 관측값에 따른 분산이 일정

size <- c(100)
# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

# 모델 적합
fit <- lm(medv~rm, data=sdf)

# 관측번호에 따른 분산이 일정 여부 파악
pngfile <- paste0(graph_path, '/그림 11.7_0.png')
png(filename =pngfile, width=8, height = 5, units = 'in', res=1000)

plot(rstandard(fit), xlab='관측번호', ylab='표준화잔차')
grid(nx=20, ny=NA)

dev.off()

# 조금은 복잡한 방법
newdf <- data.frame(x=sdf$rm, rstd=rstandard(fit))
delta <- c(0.1)
pch <- ifelse(newdf$x <= 6+delta & newdf$x >=6-delta, 17,
              ifelse(newdf$x <= 7+delta & newdf$x >=7-delta, 0, 1 ))
cex.size <- ifelse(newdf$x <= 6+delta & newdf$x >=6-delta, 1,
              ifelse(newdf$x <= 7+delta & newdf$x >=7-delta, 1, 0.5))

pngfile <- paste0(graph_path, '/그림 11.7.png')
png(filename =pngfile, width=8, height = 5, units = 'in', res=1000)

plot(newdf$x, newdf$rstd, ann=F,  pch=pch,  cex=cex.size)
for (i in seq(5, 8, 0.5)) {
  abline(v=i, lty=2)
}
title(main='등분산성의 의미', xlab='방개수', ylab='표준화잔차')

dev.off()

pngfile <- paste0(graph_path, '/그림 11.7_2.png')
png(filename =pngfile, width=8, height = 5, units = 'in', res=1000)

# 독립변수가 많은 경우: 예측값(독립변수들의 관측값 대용)에 따른 표준화 잔차 산점도
plot(fit$fitted.values, rstandard(fit), xlab='예측값', ylab='표준화잔차')

dev.off()

#
# 정규성 검증 
#
# 분위수에 대한 이해
set.seed(1)
x <- rnorm(100)
Fn <- rank(sort(x))/length(x)

pngfile <- paste0(graph_path, '/그림 11.8.png')
png(filename =pngfile, width=7, height = 7, units = 'in', res=1000)

plot(sort(x), Fn, cex=0.5, type='b',
     main='경험분포함수', xlab='정렬된 x', ylab=bquote(F[n]~"(x)"), xaxt='n')
abline(h=0.2, lty=2)
abline(v=quantile(x, probs=0.2), lty=2)
axis(side=1, at=c(quantile(x, probs=0.2)), labels=sprintf('%.2f', quantile(x, probs=0.2)))

dev.off()


## QQplot

# 데이터 구성
size <- c(300)
# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

# 모델 적합
fit <- lm(medv~rm, data=sdf)

# 이론적인 값
m <- size
probs <- seq(1, m)/(m+1)
length(probs)
x <- qnorm(probs)
head(x)

# 경험분포 값
y <- quantile(rstandard(fit), probs=probs)
head(y)

# QQplot
pngfile <- paste0(graph_path, '/그림 11.9.png')
png(filename =pngfile, width=5, height = 10, units = 'in', res=1000)

par(mfrow=c(3,1))

plot(x, y, xlab='표준정규분포', ylab='경험분포', main='분위수-분위수 그림')
abline(a=0, b=1)

hist(rstandard(fit), xlab='스튜던트화잔차', freq=F, main='')

# 함수 호출
qqnorm(rstandard(fit))
# qqline(rstandard(fit))


par(mfrow=c(1,1))

dev.off()


# 2개만 있는 그림
pngfile <- paste0(graph_path, '/그림 11.9_1.png')
png(filename =pngfile, width=5, height = 8, units = 'in', res=1000)

par(mfrow=c(2,1))

hist(rstandard(fit), xlab='스튜던트화잔차', freq=F, main='')

# 함수 호출
qqnorm(rstandard(fit))
qqline(rstandard(fit))

par(mfrow=c(1,1))

dev.off()

# 통계량에 의한 정규성 검증
shapiro.test(rstandard(fit))

