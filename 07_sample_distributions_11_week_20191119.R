#
#
# 표본 분포
#
#

# 확률변수의 함수 분포

# 가계자산조사 > 연간자료(제공)[2006년 가계자산조사]
url <- 'https://github.com/bong-ju-kang/kmu-mba-statistics/raw/master/Data/20016_household_asset_survey.txt'

df <- read.csv(url, header=FALSE)
str(df)

# 연간소득과 순자산 (단위: 만원)
# df <- data.frame(income=df$V15, net=df$V19)
# dim(df)
# 8275    2

# 예제
# HAS_layout.txt를 참조하여 연간소득에 대한 히스토그램을 생성하세요.
# 연간소득에 대한 히스토그램



# 해답
income <- df$V15

png(filename='./image/601.png', width=6, height = 5, units = 'in', res=1000)

hist(income, breaks=30, ann=F)
title(xlab='연간소득(단위:만원)')

dev.off()

png(filename='./image/602.png', width=8, height = 5, units = 'in', res=1000)
par(mfrow=c(1,2))

# 모집단으로 가정
mean <- mean(income) 
print(mean)
sd <- sqrt(mean((income-mean(income))^2))
print(sd)

hist(income, breaks=30, ann=F)
title(xlab='연간소득(단위:만원)')

hist(log10(income), breaks=30, ann=F)
title(xlab='log10(연간소득(단위:만원))')

par(mfrow=c(1,1))
dev.off()

# 크기가 100인 임의표본 1개
set.seed(123)
mean(sample(income, 100))
# 3481.42

# 표본비율
100/nrow(df)
# 0.01208459

# 크기가 100인 또 다른 임의표본 1개
set.seed(1)
mean(sample(income, 100))
# 3518.87

# 크기가 100인 임의표본 1000개 
result <- c()
for (i in 1:1000){
    result[i] <- mean(sample(income, 100))
}

# 표본평균의 평균
print(mean(result))
# 3609.39

# 예제
# 표본평균의 분포와 모평균 예시



# 해답
png(filename='./image/603.png', width=6, height = 5, units = 'in', res=1000)

hist(result, breaks=20, ann=F)
abline(v=mean(income), lty=1, lwd=1) # 모평균
abline(v=mean(result), lty=2, lwd=2) # 표본평균의 평균
title(main='가계소득 표본평균 분포', xlab='가계소득(단위:만원))', ylab='빈도')
legend(4500, 100, legend=c('모평균', '표본평균의 평균'),  
       lty=c(1,2), lwd=c(1, 2), box.col="white")

dev.off()

# 정확도 계산
N <- length(result)
in_cases <- sum((result <= mean(income) + 100) &
                    (result >= mean(income) - 100))
print(in_cases / N)

#
# 표본 평균의 분포 
#

# 데이터 구성
trials <- c(1000)
p <- 1/6
n <- 5
expected_count <- trials*p
print(expected_count)


sample_mean <- c()
set.seed(123)
for (i in 1:100){
    sample_mean[i] <- mean(rbinom(n, trials, p))
}

#
# 과제 3
#

# 𝐵(1000, 1/6)에서 크기가 5인 임의 표본 100개
# 표본 평균의 분포



# 예제 
# X~B(1, 1/6) 일 때 크기가 100인
# 임의 표본 70개에 대하여 합과 표본평균의 분포를 그래프로 표현하세요.
# 베르누이시행의 합과 비율의 분포



# 해답
# 데이터 구성
trials <- 1
sample_size <- 100
num_samples <- 70
p <- 1/6

sample_sum <- c()
sample_mean <- c()

for (i in 1:num_samples){
    sample_sum[i] <- sum(rbinom(sample_size, trials, p))
    sample_mean[i] <- mean(rbinom(sample_size, trials, p))
}

# 예제
png(filename='./image/605.png', width=8, height = 5, units = 'in', res=1000)

par(mfrow=c(1,2))
hist(sample_sum, breaks = 20, ann=F)
title(main='표본합 분포')
abline(v=n*p, lwd=2) # 모평균
hist(sample_mean, breaks = 20, ann=F)
title(main='표본평균(표본비율) 분포')
abline(v=p, lwd=2) # 모평균
par(mfrow=c(1,1))

dev.off()

# 예
z = (30-100*1/5)/sqrt(100*1/5*4/5)
print(z)
sol <- 1 - pnorm(z)
print(sol)
# 0.006209665

#
# 카이제곱 분포
#

# 표준 정규분포로 부터 카이제곱 분포 모습 확인
# 크기가 100인 표본
sample_size <- c(100)
set.seed(1234)
v <- c()
for (i in 1:sample_size) {
    v[i] <- rnorm(1)^2 + rnorm(1)^2 + rnorm(1)^2
}

library(latex2exp)
png(filename='./image/606.png', width=7, height = 5, units = 'in', res=1000)

hist(v, main=TeX('v= $z_1^2$ + $z_2^2$ + $z_3^2$'), freq = F)
par(new=T)
curve(dchisq(x, df=3), xlim=c(0, 12), ann=F, yaxt='n', col='blue')

dev.off()


# 카이제곱(chi-square)분포: 밀도 함수
dchisq(1,df=1)
dchisq(1, df=10)

# 예제
# 𝑉_1, 𝑉_2, 𝑉_3의 범위가 [0, 8] 일 때 
# 𝑉_1  ~ χ^2 (1),𝑉_2  ~ χ^2 (3),𝑉_3  ~ χ^2 (5) 의 그래프를 생성하세요.



# 해답 
png(filename='./image/607.png', width=8, height = 5, units = 'in', res=1000)

curve(dchisq(x, df=1), xlim=c(0,8), ylim=c(0,0.5), ann=F, lty=1)
par(new=T)
curve(dchisq(x, df=3), xlim=c(0,8), ylim=c(0,0.5), ann=F, lty=2, xaxt='n', yaxt='n')
par(new=T)
curve(dchisq(x, df=5), xlim=c(0,8), ylim=c(0, 0.5), ann=F, lty=3, xaxt='n', yaxt='n')
legend(4, 0.4, legend=c('자유도=1', '자유도=3', '자유도=5'), 
       cex=0.9,
       lty=c(1, 2,3), 
       box.col="white")
title(main="카이제곱분포", xlab="V")

dev.off()

# 예제
# 𝑋_1,…, 𝑋_100   ~┴𝑖𝑖𝑑  𝑁(0, 𝜎^2=3^2) 인 크기가 
# 100인 표본 50개에 대하여 ((𝑛−1) 𝑆^2)/(𝜎^2   )의 분포를 그려보세요. 



# 해답
num_samples <- 50
sample_size <- 100
sd <- 3
chisq <- c()

set.seed(1234)
for (i in 1:num_samples){
    chisq[i] <- (sample_size-1)*var(rnorm(sample_size, 0, sd))/sd^2
}

png(filename='./image/608.png', width=7, height = 5, units = 'in', res=1000)

hist(chisq, freq = F, xlim=c(min(chisq), max(chisq)), 
     main=TeX('$(n-1)S^2/ \\sigma^2$ Distribution'),
     xlab=TeX('$(n-1)S^2/ \\sigma^2$'))
par(new=T)
curve(dchisq(x, df=sample_size-1), xlim=c(min(chisq), max(chisq)), 
      ann=F, xaxt='n', yaxt='n', col='blue', lwd=2)

dev.off()

#
# t분포
#

# 예제
# 자유도가 99일 때 표본의 크기가 90인 𝑇=𝑍/√(𝑉∕𝑟  )
# 의 분포를 그려보세요.



# 해답
n <- 90
size <- 100
r <- size - 1
sd <- 3
t <- array()

set.seed(1234)
for (i in 1:n){
    z <- rnorm(1)
    t[i] <- z/sqrt(rchisq(1,r)/r)
}

png(filename='./image/609.png', width=7, height = 5, units = 'in', res=1000)

hist(t, freq = F, xlim=c(min(t), max(t)), 
     main=TeX('n=90, r=99,  $Z / \\sqrt{V/r}$ Distribution'),
     xlab=TeX('$Z / \\sqrt{V/r}$'))
par(new=T)
curve(dt(x, df=size-1), xlim=c(min(t), max(t)), 
      ann=F, xaxt='n', yaxt='n', col='blue', lwd=2)

dev.off()


#
# 과제 4
#
# 자유도가 1, 3, 10인 t 분포에 대한 다음 그림을 프로그램으로 생성하세요.


# 오른쪽 면적 그림
png(filename='./image/611.png', width=7, height = 5, units = 'in', res=1000)

curve(dt(x, 10), xlim=c(-3,3), ann=F, yaxt='n')

cord.x <- c(6, seq(3, 2, -0.01), 2)
cord.y <- c(0, dt(seq(3, 2, -0.01), 10), 0)
polygon(cord.x, cord.y, col='gray')
# title('Pr(Z <= -z) = Pr(Z >= z)')
title(main=TeX('$Pr(T \\geq 2)$'))

dev.off()

# 양쪽 면적 그림
png(filename='./image/612.png', width=7, height = 5, units = 'in', res=1000)
curve(dt(x, 10), xlim=c(-3,3), ann=F, yaxt='n')

cord.x <- c(-6, seq(-3, -2, 0.01), -2)
cord.y <- c(0, dt(seq(-3, -2, 0.01), 10), 0)
polygon(cord.x, cord.y, col='gray')

cord.x <- c(6, seq(3, 2, -0.01), 2)
cord.y <- c(0, dt(seq(3, 2, -0.01), 10), 0)
polygon(cord.x, cord.y, col='gray')
# title('Pr(Z <= -z) = Pr(Z >= z)')
title(main=TeX('$Pr(T \\geq 2)=Pr(T \\leq -2)$'))
dev.off()

pt(2, 10)
1-pt(2,10)
pt(-2, 10)

#
# F분포
#

# 예제
# 𝐹=(𝑉_1∕10)/(𝑉_2∕100) 에 대하여
# 표본 크기가 90인 경우에 분포의 모습에 대한 그림을 생성하세요.



# 해답
n <- 90
f <- array()

set.seed(1234)
for (i in 1:n){
    nom <- rchisq(1,df=10)
    denom <- rchisq(1, df=100)
    f[i] <- (nom/10)/(denom/100)
}

png(filename='./image/613.png', width=7, height = 5, units = 'in', res=1000)

hist(f, freq = F, xlim=c(min(f), max(f)), 
     main=TeX('$\\frac{V_1/r_1}{V_2/r_2}$ Distribution'), 
     xlab=TeX('$\\frac{V_1/r_1}{V_2/r_2}$'))
par(new=T)
curve(df(x, df1=10, df2=100), xlim=c(min(f), max(f)), 
      ann=F, xaxt='n', yaxt='n', col='blue', lwd=2)

dev.off()

#
# 과제 5
#
# 자유도에 따른 F 분포의 생성


# Pr(f > 1.5) =?
png(filename='./image/615.png', width=7, height = 5, units = 'in', res=1000)
curve(df(x, df1=90, df2=100), xlim=c(0,5), ylim=c(0,2), ann=F, lty=1)
cord.x <- c(6, seq(3, 1.5, -0.01), 1.5)
cord.y <- c(0, df(seq(3, 1.5, -0.01), df1=90, df2=100), 0)
polygon(cord.x, cord.y, col='gray')
title(main="Pr(F > 1.5)=?", xlab="F")
dev.off()

pf(1.5, 90, 100)
1-pf(1.5, 90, 100)

# 상위 alpha% 에 해당하는 분위수 찾기
alpha <- 0.05
f_alpha <- qf(1-alpha, df1=90, df2=100)
print(f_alpha)

# 상위 % 분위수 
#
# 과제 6
#
# 𝐹 ~ 𝐹(90, 100 ) 일 때 상위 면적에 해당하는그림 그리기


