#
# Bong Ju Kang
# R을 이용한 통계분석의 이해와 활용
# 
# created: 3/18/2019
# name: 04_stat_probability_distribution_9_week_xxxxxxxx.R
#

#
#
# 확률과 확률 변수
#
#

# 상대도수: 주사위
result <- c()
# 크기가 1이고 성공 확률이 1/6에서 1번 추출
rbinom(1, 1, 1/6)

# 크기가 2이고 성공 확률이 1/6에서 1번 추출
rbinom(1, 2, 1/6)

# 크기가 10이고 성공 확률이 1/6에서 1번 추출
rbinom(1, 10, 1/6)

# 크기가 1이고 성공 확률이 1/6에서 2번 추출
rbinom(2, 1, 1/6)

# 크기가 1이고 성공 확률이 1/6에서 6번 추출
rbinom(6, 1, 1/6)

# 무한히 반복하는 경우
for (i in 1:1000){
  result[i] <- mean(rbinom(n=i, size=1, prob=1/6))
}

# 수학적 확률과 비교
mean(rbinom(n=10000, size=1, 1/6))
1/6

mean(rbinom(n=1, size=10000, 1/6))

# 예제
# 1) 그림 생성



# 해답
# 데이터 생성
result <- c()
for (i in 1:1000){
  result[i] <- mean(rbinom(n=i, size=1, prob=1/6))
}

# 그림 생성
plot(result, type='b', cex=0.1, 
     xlab='시행횟수', ylab='상대도수', 
     main='주사위 1번 던지는 시행')
abline(h=1/6, lty='dotted', lwd=3)
legend(800, 0.4, legend='1/6', bty='n', 
       lty='dotted', lwd=3)

# 예제: 이산형 확률 밀도 함수
# 이항 분포
# 4번 시행에서 성공확률이 1/2인 경우
# 𝐴={0, 1, 2}의 확률을 계산해보자



# 해답
# choose() 이용
sum(choose(4,c(0, 1, 2))*(1/2)^4)

# dbinom() 이용
sum(dbinom(c(0, 1, 2), 4, 1/2))
# 0.6875

# 연속형 확률 밀도 함수
# 지수 분포
pexp(c(1))
# 0.6321206
1-exp(-1)
# 0.6321206

# 예제: 균등 분포의 분포함수
# 1) 구간 [0, 1]에서 정의된 균등 분포의 분포 함수를 
# 정의하세요
# 2) 분포 함수를 x값에 따른 그래프를 그리세요
# punif() 함수 이용



# 해답
x <- seq(0,1, 0.1)
px <- punif(x)

plot(x, px, type='b', cex=1, xlab='균등확률변수값',
     ylab='F(x)=Pr(X<=x)',
     main='표준 균등분포함수')

