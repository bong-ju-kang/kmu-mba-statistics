#
# Bong Ju Kang
# R을 이용한 통계분석의 이해와 활용
# 
# created: 3/18/2019
# name: 05_special_distributions_10_week_xxxxxxxx.R
#

#
#
# 특별한 분포
#
#

#
# 베르누이 표본
#

# 시행 횟수:1, 성공확률:1/22, 표본크기: 1000
# 결과 값은 성공 건수
x <- rbinom(1000, 1, 1/2)


# 평균과 분산
mean(x)
var(x)


# 베르누이 시행과 대수의 법칙
result <- array()
for (i in 1:1000){
    result[i] <- mean(rbinom(i, 1, 1/2))
}


plot(result, type='b', cex=0.1, xlab='독립시행횟수', ylab='성공상대빈도')
abline(h=1/2, lty=2, lwd=3)
legend(800, 0.8, legend='1/2', bty='n', lty='dotted', lwd=3)

#
# 이항 분포
#

# 크기가 4인 이항 분포
rbinom(10, 4, 1/2)

# 예제
# factorial 함수를 이용하여 이항 계수 값을 구하는 함수를 작성하고 검증하세요.



# 해답
# 이항 계수 구하기
bicoef <- function(n, k){
    return(factorial(n)/factorial(n-k)/factorial(k))
}

# 계산 결과 확인
bicoef(3, 1)
choose(3, 1)

# 예제
# 1) 𝐵(20, 0.5), 𝐵(20, 0.7), 𝐵(40, 0.5) 을 따르는
# 확률변수 각각에 대하여 확률 밀도 함수 그래프를 그리세요.




# 해답
plot(dbinom(0:20, 20, 0.5), pch=0, type='b', cex=0.7, yaxt='n', xaxt='n', ann=F, ylim=c(0,0.2), xlim=c(0,42))
par(new=T)
plot(dbinom(0:20, 20, 0.7), pch=1, type='b', cex=0.7, yaxt='n', xaxt='n', ann=F, ylim=c(0,0.2), xlim=c(0,42))
par(new=T)
plot(dbinom(0:40, 40, 0.5),  pch=2, type='b', cex=0.7, ann=F, ylim=c(0,0.2), xlim=c(0,42))
legend(0, 0.2, legend = c("B(20, 0.5)", "B(20, 0.7)", "B(40, 0.5)"),  
       pch=c(0, 1, 2), cex=0.7)
title(main='이항분포 확률밀도함수', xlab='X', ylab='Pr(X=x)')

#
# 정규분포
#

# 분산이 같은 경우
# 예제
# 1) 𝑁(0,1), 𝑁(10, 1) 각각의 분포를 그리고 비교해보세요.




# 해답 
library(latex2exp)
x <- seq(-5, 5, 0.1)
plot(x, dnorm(x, mean=0), ann=F, xaxt='n', yaxt='n', type='b', pch=1, cex=0.5, xlim=c(-5, 15))
text(0, 0, TeX('$\\mu$=0'))
par(new=T)
x <- seq(5,15, 0.1)
par(new=T)
plot(x, dnorm(x, mean=10), type='b',ann=F,  cex=0.5, pch=0, xlim=c(-5, 15))
text(10, 0, TeX('$\\mu$=10'))
legend(2.5, 0.4, legend = c("N( 0, 1)", "N(10, 1)"), 
       pch=c(0, 1), cex=1, box.col='white')
title(ylab='상대빈도/확률밀도함수값')


# 분산이 틀린 경우
# 예제) 𝑁(0,1), 𝑁(0, 2^2 ),𝑁(0, 3^2 )각각의 분포를 그리고 비교해보세요.



# 해답1
library(latex2exp)
x <- seq(-5,5, 0.1)
plot(x, dnorm(x, mean=0, sd=1), ann=F, type='b', pch=0, cex=0.5, xaxt='n', yaxt='n', ylim=c(0,0.4))
par(new=T)
plot(x, dnorm(x, mean=0, sd=2),  type='b', pch=1, cex=0.5, ann=F, xaxt='n', yaxt='n', ylim=c(0,0.4))
par(new=T)
plot(x, dnorm(x, mean=0, sd=3),  type='b', pch=2, cex=0.5, ann=F, xaxt='n', yaxt='n', ylim=c(0,0.4))
abline(v=0, lty=2, lwd=2)
mtext(TeX('$\\mu$=0'), side=1)
legend(2, 0.4, legend = c(TeX("N(0, 1 )"), TeX("N(0, $2^2$)"), TeX("N(0, $3^3$)")),
       pch=c(0, 1, 2), cex=1, box.lwd = 0, box.col='white')


# 해답2: 곡선으로 그리기
curve(dnorm(x, 0, 1), from=-5, to=5, ann=F,xaxt='n', yaxt='n', ylim=c(0,0.4), col='blue')
par(new=T)
curve(dnorm(x, 0, 2), from=-5, to=5, ann=F,xaxt='n', yaxt='n', ylim=c(0,0.4), col='green')
par(new=T)
curve(dnorm(x, 0, 3), from=-5, to=5, ann=F,xaxt='n', yaxt='n', ylim=c(0,0.4), col='red')
abline(v=0, lty=2, lwd=2)
mtext(TeX('$\\mu$=0'), side=1)
legend(2, 0.4, legend = c(TeX("N(0, 1 )"), TeX("N(0, $2^2$)"), TeX("N(0, $3^3$)")), lty=1,
       col=c('blue', 'green', 'red'), cex=1, box.lwd = 0, box.col='white')


# 표준편차의 의미

#
# 과제 1: 그래프 생성
#


#
# 정규분포의 성질
#

# 예제
# 1) Φ(0),Φ(1),Φ(−1) 값을 구하세요



# 해답
x <- c(0, 1, -1)
pnorm(x)


#
# 과제 2
#


# 확률계산
p_ge_1 = 1 - pnorm(1, 0, 1) # Pr(X>1)
p_btn_1_std = pnorm(1, 0, 1)-pnorm(-1, 0, 1) # Pr(-sigma <= Z <= sigma)
p_btn_2_std = pnorm(2, 0, 1)-pnorm(-2, 0, 1) # Pr(-2*sigma <= Z <= 2*sigma)
p_btn_3_std = pnorm(3, 0, 1)-pnorm(-3, 0, 1) # Pr(-2*sigma <= Z <= 2*sigma)

pnorm(3)
pnorm(-1)
pnorm(3) - pnorm(-1)
# 0.839994

# 예제
# 표준 정규분포에서 상위 2.5%에 해당하는 분위수는?




# 해답
value <- c(0.025)
xvalue <- qnorm(1-value, 0, 1)




# 그래프로 표현
curve(dnorm(x), xlim=c(-3,3), ann=F, yaxt='n')
cord.x <- c(6, seq(3, xvalue, -0.01), xvalue)
cord.y <- c(0, dnorm(seq(3, xvalue, -0.01)), 0)
polygon(cord.x, cord.y, col='gray')
abline(v=xvalue, col='red', lty=3)
arrows(2.7, dnorm(2.7, 0, 1)+0.03, 2.5, dnorm(2.5, 0, 1),
       length=0.1)
text(2.7, dnorm(2.7, 0, 1)+0.035, '0.025')
title(main='상위 2.5%')
