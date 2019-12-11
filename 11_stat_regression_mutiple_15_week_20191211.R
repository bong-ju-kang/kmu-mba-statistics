#
# Bong Ju Kang
# R을 이용한 통계분석의 이해와 활용
# 
# created: 3/18/2019
# name: stat_regression_multiple_xxxxxxxx.R
#


#
#
# 다중 선형회귀
#
#

graph_path = paste0(getwd(), '/image')

# 데이터 구성
# [HOUSING] 데이터
url <- c("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
df <- read.table(url, header=FALSE)
head(df)
names(df) <- tolower(c('CRIM','ZN','INDUS','CHAS','NOX','RM','AGE','DIS','RAD','TAX','PTRATIO','B','LSTAT','MEDV'))

# 표본 구성
size <- c(100)
# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size),]

# 입력 변수 정의의
xvars <- c('rm', 'age', 'lstat')

# 산점도로 대략적인 관련성 파악
pngfile <- paste0(graph_path, '/그림 12.1.png')
# png(filename =pngfile, width=600, height = 600)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

pairs(sdf[, c(xvars, 'medv')], cex=0.5, labels = c('방개수', '연령', '인구감소비율', '주택중위값'))

dev.off()

## 모수의 추정
# 데이터 행렬 구성
ones <- matrix(c(1), nrow=nrow(sdf))
X <- cbind(ones, as.matrix(sdf[, xvars]))
y <- as.matrix(sdf$medv)

# 역행렬 이용 직접계산
library(MASS)
ginv(t(X) %*% X) %*% t(X) %*% y

#
# 정규방정식 이용: QR 분해 이용
#

# 회귀계수값 구하기
betahat <- qr.solve(t(X) %*% X, t(X) %*% y)
# betahat은 열 벡터
# dim(betahat)
# is.matrix(betahat)
qr <- solve(qr(t(X) %*% X), t(X) %*% y)

#  예측값
yhat <- X %*% betahat

# 잔차
r <- y - yhat

# 오차 분산 추정값 구하기
n <- nrow(sdf)
p <- length(betahat)
SSE <- crossprod(r, r)
MSE <- SSE/(n-p) # 평균제곱오차
RSE <- sqrt(MSE) # Residual standard error
print(RSE)

# 함수 이용하여 오차 분산 확인
fit <- lm(medv ~ rm+age+lstat, data=sdf)
summary(fit)

#
# 모자 행렬에서 부터 오차분산의 추정
#
H <- X %*% ginv(t(X) %*% X) %*% t(X)
dim(H)
I <- diag(nrow=nrow(H))

n <- nrow(sdf)
p <- 4
r <- I-H
SSE <- t(y) %*% r %*% y
MSE <- SSE / (n-p) 
RSE <- sqrt(MSE) # Residual standard error
print(RSE)

# 함수 이용하여 오차 분산 확인
fit <- lm(medv ~ rm+age+lstat, data=sdf)
summary(fit)

#
# 회귀계수에 대한 추론
#
D <- sqrt(ginv(t(X) %*% X))

SSE <- sum(fit$residuals^2) # 잔차제곱합
MSE <- SSE/(n-p) # 평균제곱오차
RSE <- sqrt(MSE) # Residual standard error

print('표준오차(Std. Error):-----')
d <- diag(D)
print(RSE*d)

print('회귀계수에 대한 t 값(t value):-----')
t0 <- coef(fit) / (d * RSE)
print(t0)

print('회귀계수에 대한 P 값(Pr(>|t|)):-----')
n <- nrow(sdf)
p <- length(fit$coefficients)
print(2*(1-pt(abs(t0), df=n-p)))

#함수 이용
summary(fit)

#
# 회귀직선의 유의성 검증
#
n <- nrow(sdf)
p <- length(fit$coefficients)
SSE <- sum(fit$residuals^2) # 잔차제곱합
MSE <- SSE/(n-p) # 평균제곱오차

SST <- (n-1)*var(y)
SSR <- SST-SSE
f0 <- (SSR/(p-1))/(SSE/(n-p)) 
pvalue <- 1-pf(f0, df1=(p-1), df2=n-p)
print(paste('F-statistic: ',f0, 'on ', p-1, ' and ', n-p,' DF, ', 'p-value: ', pvalue)) 

#함수 이용
summary(fit)


#
# 잔차 분석: 오차 가정에 대한 검증
#

# 독립성 확인
# 잔차 대 예측값 확인

# 데이터 구성
size <- c(50)
# 재현성을 위하여
set.seed(123) 
sdf <- df[sample(1:nrow(df), size), ]

# 예측값 및 잔차
fit <- lm(medv~., data=sdf)
yhat <- predict(fit, sdf)
t <- rstandard(fit)

pngfile <- paste0(graph_path, '/그림 12.3.png')
png(filename =pngfile, width=5, height = 5, units = 'in', res=1000)

plot(yhat, t, main='예측값 대 스튜던트화잔차 산점도', xlab='예측값', ylab='스튜던트화잔차')
abline(h=0, lty=3)

dev.off()

# 함수로 확인
plot(fit, which = 1)

# 등분산성 확인
fit <- lm(medv~., data=sdf)
yhat <- predict(fit, sdf)
t <- rstandard(fit)
t2 <- sqrt(abs(t))

pngfile <- paste0(graph_path, '/그림 12.4.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(yhat, t2, main=TeX('$\\sqrt{|Studetized Residual|}$'), xlab='예측값', 
     ylab=TeX('$\\sqrt{|Studetized Residual|}$'))

dev.off()

# 함수로 확인
plot(fit, which = 3)

# 정규성
pngfile <- paste0(graph_path, '/그림 12.4_b.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

qqnorm(rstandard(fit), 
       main='정규 분위수-분위수', xlab='이론 정규 분위수', ylab='잔차 경험 분위수')
qqline(rstandard(fit))


dev.off()

# 함수로 확인
plot(fit, which = 2)

## 이상점
maxh <- array()
set.seed(123)
for (i in 1:1000) {
  h <-  rnorm(1000) 
  h <- 1/100 + (h-mean(h))**2/((100-1)*var(h))
  maxh[i] <- max(h)
}

pngfile <- paste0(graph_path, '/그림 12.4_b2.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(maxh, cex=0.5, xlab='실험번호', ylab=TeX('$max(h_{ii})$'), main=TeX('실험번호 대 $max(h_{ii})$'))

dev.off()

# 외부스튜던트화 잔차
fit <- lm(medv~., data=sdf)
yhat <- predict(fit, sdf)
t <- rstudent(fit)
t2 <- sqrt(abs(t))


pngfile <- paste0(graph_path, '/그림 12.4_b3.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(yhat, t2, main=TeX('$\\sqrt{|Ext. Studetized residual|}$'), xlab='예측값', 
     ylab=TeX('$\\sqrt{|Ext. Studetized residual|}$'))

dev.off()

## 이상점과 영향점에 대한 이해
# 데이터 구성
set.seed(0)
x <- rnorm(8, sd=2)
x <- c(-2.0, x)
y <- 2 + 0.3*x + rnorm(9)
plotdf <- data.frame(obsnum=1:9, x,y)

# 선형회귀 적합
fit <- lm(y~x)

# 초기 그림
pngfile <- paste0(graph_path, '/그림 12.5.png')
png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(x,y, type='n')
abline(fit,  lty=2)
text(plotdf$x, plotdf$y, plotdf$obsnum, cex=0.8)
legend(-3,5, '적합된 직선', lty=2, box.col='white')

dev.off()

# 표준화 잔차 계산
plotdf <- data.frame(plotdf, rstandard=rstandard(fit))

# 스튜던트화 잔차 계산
plotdf <- data.frame(plotdf, rstudent=rstudent(fit))
print(plotdf)


## 진단 그림으로 확인
pngfile <- paste0(graph_path, '/그림 12.6.png')
png(filename =pngfile, width=6, height = 10, units = 'in', res=1000)

par(mfrow=c(2,1))

# 독립성 및 이상값 
plot(fit, which=1, main='독립성 및 이상값 진단')

# 등분산성 및 이상값
plot(fit, which=3, main='등분산성 및 이상값 진단')

par(mfrow=c(1,1))

dev.off()


# 지렛대 구하기
influence(fit)$hat
plotdf <- data.frame(plotdf, hat=influence(fit)$hat)

# 그림으로 확인하기
pngfile <- paste0(graph_path, '/그림 12.7.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(plotdf$obsnum, plotdf$hat, type='n', xlab='관측값번호', ylab='레버리지')
text(plotdf$obsnum, plotdf$hat, plotdf$obsnum, cex=0.8)

dev.off()

# 쿡의 거리 구하기
cooks.distance(fit)
plotdf <- data.frame(plotdf, Cook=cooks.distance(fit))
print(plotdf[c("obsnum", "Cook")])

# 그림으로 확인하기
pngfile <- paste0(graph_path, '/그림 12.8.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(plotdf$obsnum,plotdf$Cook, type='n', xlab='관측값번호', ylab='쿡의 거리')
text(plotdf$obsnum, plotdf$Cook, plotdf$obsnum, cex=0.8)

dev.off()

# 영향도 분석
# 2번/5번이 없는 경우
pngfile <- paste0(graph_path, '/그림 12.9.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(x,y, type='n')
abline(fit, lty=1)
text(plotdf$x, plotdf$y, plotdf$obsnum, cex=0.8)
abline(lm(y~x, data=plotdf[plotdf$obsnum != 2,]), lty=2)
abline(lm(y~x, data=plotdf[plotdf$obsnum != 5,]), lty=3)
legend(-3, 4, legend = c('전체데이터', '2번삭제', '5번삭제'), 
       lty=c(1,2,3),box.col='white')

dev.off()
