#
# Bong Ju Kang
# R을 이용한 통계분석의 이해와 활용
# 
# created: 3/18/2019
# name: 08_stat_statistical_inference_xxxxxxxx.R
#

#
#
# 통계적 추론(statistical inference)
#
#

graph_path <- paste0(getwd(), '/image')

# 추정(estimation)
# 우도함수 예시
theta <- seq(0,1, 0.01)
n <- c(10)

pngfile <- paste0(graph_path, '/그림 7.1.png')
png(filename =pngfile, width=11, height = 6, units = 'in', res=1000)

par(mfrow=c(2,5))
for (x in 1:10){
  plot(theta, theta^x*(1-theta)^(n-x), main=paste0('합=', x),
       ylab=TeX('$L(\\theta)'), xlab=TeX('$\\theta'))
}
par(mfrow=c(1,1))

dev.off()

# 예
pnorm(2)-pnorm(-2)

# 예제
# 신뢰수준이 90%, 95%, 99%에 해당하는 신뢰구간 분위수를 구하세요.



# 해답
confidence_level=c(0.9, 0.95, 0.99)
alpha = 1-confidence_level
z_alpha_half <- qnorm(1-alpha/2)
print(z_alpha_half)

# 통계가설(statistical hypothesis)
# 검정력 함수 1
library(latex2exp)
pngfile <- paste0(graph_path, '/그림 7.2.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

curve(1-pnorm((75-theta)/2), from=70, to=85,  xname='theta', 
      xlab=TeX('$\\theta'), ylab=TeX('$K_1(\\theta)'))
axis(side=2, at=seq(0,1, 0.1))
abline(v=75, lty=2)
abline(h=0.5, lty=2)

dev.off()

# 검정력 함수 2
pngfile <- paste0(graph_path, '/그림 7.3.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

curve(1-pnorm((78-theta)/2), from=70, to=85,  xname='theta', 
      xlab=TeX('$\\theta'), ylab=TeX('$K_2(\\theta)'), yaxt='n')
x <- 75
y <- 1-pnorm((78-75)/2)
abline(v=x, lty=2)
abline(h=y, lty=2)
# text(x, y, sprintf("%.3f", y) , adj=1.2, cex=0.7)
axis(side=2, at=y, labels=sprintf("%.3f", y))

dev.off()

# 예
1-pnorm((78-77)/2)

# 예
qnorm(0.841)
qnorm(0.159)

# 예
theta <- c(73, 75, 77, 79)
k3 <- 1-pnorm((76-theta)/1)
k3

# 검정력함수 비교
pngfile <- paste0(graph_path, '/그림 7.4.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

curve(1-pnorm((75-theta)/2), from=70, to=85,  xname='theta',  lty=1,
      xlab=TeX('$\\theta'), ylab=TeX('$K(\\theta)'))
par(new=T)
curve(1-pnorm((78-theta)/2), from=70, to=85,  xname='theta', lty=2,
      xlab=TeX('$\\theta'), ylab=TeX('$K_2(\\theta)'), ann=F, xaxt='n', yaxt='n')
par(new=T)
curve(1-pnorm((76-theta)/1), from=70, to=85,  xname='theta', lty=3,
      xlab=TeX('$\\theta'), ylab=TeX('$K_2(\\theta)'), ann=F, xaxt='n', yaxt='n')
abline(v=75, lty=4)
legend(80, 0.4, legend=c(TeX('$K_1$'),TeX('$K_2$'),TeX('$K_3$') ), 
       cex=0.9,
       lty=c(1, 2, 3), 
       box.col="white")
title(main=TeX('$H_0 : \\theta \\leq 75$'))

dev.off()

# 예
qnorm(0.05)
c <- 75 + qnorm(0.05)*9.4/sqrt(100)
c

pnorm((73.5-75)/9.4*sqrt(100))

# 예
z <- (220000-200000)/(100000/sqrt(100))
z
1-pnorm(z)

