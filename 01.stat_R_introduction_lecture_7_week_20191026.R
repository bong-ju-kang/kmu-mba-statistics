#
# 강봉주
# R 기반의 통계 분석
# 7 주차 (10/26/2019)
# 
#

### 고수준 그림의 인자 -----
# 고수준 그림 함수에 넘겨주는 인자

# 전역 그림인자 초기화
# oldpar <- par(no.readonly = T)
par(oldpar)

# axes=FALSE
pngfile <- paste0(graph_path, '/그림 18.14.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(rnorm(10), axes=F, main='axes=FALSE')

dev.off()

# log='x'
pngfile <- paste0(graph_path, '/그림 18.15.png')
png(filename =pngfile, width=6, height = 10, units = 'in', res=1000)

# x축의 값을 로그변환 후 (log(x), y)를 표시하고 
# 값에 대한 표기는 원래 값으로 
set.seed(1234)

par(mfrow=c(3, 1))
# 원래 값으로 하면 판독 불가
plot(10^c(1:100), rnorm(100))

# 값에 표기는 원래로 하되 로그 변환된 값을 실제 값으로 사용
plot(10^c(1:100), rnorm(100), log='x', main='log="x"')

# 처음부터 로그 변환한 경우
plot(log(10^c(1:10)), rnorm(10))

par(oldpar)

dev.off()

# type='p', type='l', type='b', type='n'
pngfile <- paste0(graph_path, '/그림 18.16.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

par(mfrow=(c(2,2)))
plot(rnorm(10), type='p', main='type="p"')
plot(rnorm(10), type='l', main='type="l"')
plot(rnorm(10), type='b', main='type="b"')
plot(rnorm(10), type='n', main='type="n"')
par(mfrow=(c(1,1))) 

dev.off()

# xlab, ylab, main
pngfile <- paste0(graph_path, '/그림 18.17.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(1:10, rnorm(10), type="b", 
     xlab="최근10개월",
     ylab="최근주가", 
     main="최근10개월 주가" )

dev.off()

## 저수준 그림 함수들 -----
# 고수준 그림 함수가 정의된 후 추가하는 함수
# 저수준(low-level) 그림 함수는 고수준 그림에 
# 점, 선 또는 텍스트에 추가 정보를 제공하는 함수이다.

# title, axis, abline, text 사용
pngfile <- paste0(graph_path, '/그림 18.18.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

set.seed(1234)
plot(1:10, rnorm(10), type="b", xaxt='n', ann=FALSE )
title(xlab="최근10개월", ylab="최근주가", main="최근10개월 주가")
axis(side=1, at=1:10, labels=paste0(10:1, '개월전'))
abline(h=0)
text(8, 0.2, "randowm walk")

dev.off()

# 예제
# 1) 다음의 데이터에서
# set.seed(1234)
# x = c(1:10)
# y = rnorm(10)
# x 축의 값을 상단에, y축의 값을 오른쪽에 표시하는 
# 산점도(type='b)를 생성하세요.




### 수학 기호 주석달기 -----

# 패키지 이용
library(latex2exp)

# 데이터 생성
x <- seq(0, 4, length.out=100)
alpha <- 1:5

# 그림 구조 생성
pngfile <- paste0(graph_path, '/그림 18.19.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(x, xlim=c(0, 4), ylim=c(0, 10), 
     xlab='x', 
     ylab=TeX('$\\alpha  x^\\alpha$, where $\\alpha \\in 1\\ldots 5$'), 
     type='n', 
     main=TeX('Using $\\LaTeX$ for plotting in base graphics!'))

# 콘솔에 프린트 하지 않기
invisible(sapply(alpha, function(a) lines(x, a*x^a, lty=a)))

# 아래와 같은 형식
# lines(x, 1*x^1, lty=1)
# lines(x, 2*x^2, lty=2)
# lines(x, 3* x^3, lty=3)
# ...

# 범례함수 사용
legend('topright', legend=TeX(sprintf("$\\alpha = %d$", alpha)), 
       lwd=1, lty=alpha, cex=0.7)

dev.off()

## 그래픽 인자/모수 사용 

### 영구 수정: par() -----

# par() 함수를 이용. 모든 모수값 확인
invisible(par()) 

# 고유 속성은 리스트
mode(par()) 

# 지정된 값 보기
par(c("col", "lty")) 
par('pch')
par()$pch

# 지정된 값 수정
pngfile <- paste0(graph_path, '/그림 18.20.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

par(pch=2)
plot(1:10)

# 원상 복귀
par(pch=1)

dev.off()

### 일시 수정

# 문자의 종류와 크기 지정
pngfile <- paste0(graph_path, '/그림 18.21.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(1:10, pch='*', cex=2) 

dev.off()

### 그래픽 원소(graphic element):점, 선, 텍스트
# 그래픽 인자에 의한 수정 가능

# pch 예시
pngfile <- paste0(graph_path, '/그림 18.22.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

x <- c(0:25)
plot(x, x, pch=x, xaxt='n', yaxt='n', xlab='', ylab='')
title(main='pch:숫자 대 실제 문자')
axis(side=1, at=x, las=2, labels = as.character(x))
grid(nx=length(x), ny=0)

dev.off()

# font 예시
# 새로운 폰트 가져오기
windowsFonts(d2 = windowsFont('D2Coding'))
windowsFonts()

# 폰트 사용하기
pngfile <- paste0(graph_path, '/그림 18.23.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

plot(rnorm(10), main='표준정규분포값', family='d2', font=3)

dev.off()

# pos의 의미
pngfile <- paste0(graph_path, '/그림 18.24.png')
png(filename =pngfile, width=8, height = 8, units = 'in', res=1000)

par(mfrow=c(2,2))

x <- c(1:5)
plot(x, main='아래: pos=1', font.main=1)
# text(x, x, x, adj=0)
text(x, x, x, pos=1)

plot(x, main='왼쪽: pos=2', font.main=2)
# text(x, x, x, adj=1)
text(x, x, x, pos=2)

plot(x, main='위: pos=3', font.main=3)
# text(x, x, x, adj=0.5)
text(x, x, x, pos=3)

plot(x, main='오른쪽: pos=4', font.main=4)
# text(x, x, x, adj=-0.3)
text(x, x, x, pos=4)

par(mfrow=c(1,1))

dev.off()

# cex의 의미
pngfile <- paste0(graph_path, '/그림 18.25.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

x <- c(1:10)
plot(x, main='cex(문자 확장)')
text(2, 2, 2, pos=4, offset=0.1, cex=1)
text(3, 3, 3, pos=4, offset=0.1, cex=2)
text(4, 4, 4, pos=4, offset=0.1, cex=3)

dev.off()

### 축과 눈금 표시

# lab의 의미
pngfile <- paste0(graph_path, '/그림 18.26.png')
png(filename =pngfile, width=8, height = 8, units = 'in', res=600)

#lab: axis label (c(x, y, len)), las: axis label style
# 처음 2개의 숫자는 각각 x축, y축의 눈금표시 간격의 개수를  의미하며 
# 마지막 숫자는 눈금값의 길이(소수점 포함)이다.
# 정확하게 맞지는 않고 대략 맞음

# 디폴트
# par('lab')
# plot(x)

x <-rnorm(10)
par(mfrow=c(1,2))
plot(x, lab=c(5, 3, 5), main='lab=c(5, 3, 5)', las=1)
plot(x, lab=c(10, 100, 5), main='lab=c(10,100 5)', las=2)
par(mfrow=c(1,1))

# dev.off()

# las의 의미
pngfile <- paste0(graph_path, '/그림 18.27.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

par(mfrow=c(1,2))
plot(1:5, main='디폴트')
plot(1:5, axes=F, main='x축: las=2, y축: las=1')
axis(side=1, at=c(2:4), las=2)
axis(side=2, las=1)
par(mfrow=c(1,1))

dev.off()

# tck의 의미

pngfile <- paste0(graph_path, '/그림 18.28.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

# 눈금 표시자의 상대적 비율(그림 영역의 폭과 높이 중에 작은 값에 대한)
par(mfrow=c(1,3))
plot(1:5, main='디폴트')
plot(1:5, main='tck=0.1', tck=0.1)
plot(1:5, main='tck=0.1', tck=-0.1)
par(mfrow=c(1,1))

dev.off()

### 피거 여백 -----
# 그림 영역 < 마진 영역 < 외각마진 영역

pngfile <- paste0(graph_path, '/그림 18.29.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

# 전역 그래픽 모수 저장: 나중에 복귀하기 위하여 
oldpar <- par(no.readonly = T)

# 디폴트 값 확인
par('oma') # 0 0 0 0
par('mar') #  5.1 4.1 4.1 2.1

# 여백 주기
par(oma=c(3,3,3,3))
par(mar=c(5,4,4,2) + 0.1)   
  
# 그림(plot) 영역  
plot(0:10, 0:10, type="n", xlab="X", ylab="Y")

# 그림 영역 표시
text(5,5, "Plot", cex=2)  
box("plot", lty=2, lwd=5)

# 마진 영역에 주석 달기
mtext("Margins", side=3, line=2, cex=2, col="forestgreen")  
mtext("par(mar=c(b,l,t,r))", side=3, line=1, cex=1, col="forestgreen")  
mtext("Line 0", side=3, line=0, adj=1.0, cex=1, col="forestgreen")  
mtext("Line 1", side=3, line=1, adj=1.0, cex=1, col="forestgreen")  
mtext("Line 2", side=3, line=2, adj=1.0, cex=1, col="forestgreen")  
mtext("Line 3", side=3, line=3, adj=1.0, cex=1, col="forestgreen")  
mtext("Line 4", side=3, line=4, adj=1.0, cex=1, col="forestgreen")  
mtext("Line 5", side=3, line=5, adj=1.0, cex=1, col="forestgreen")  
mtext("Line 6", side=3, line=6, adj=1.0, cex=1, col="forestgreen")  
# 아래는 오류 발생: 설정을 총 7개 줄만 했기 때문
# mtext("Line 7", side=3, line=7, adj=1.0, cex=1, col="forestgreen")  

box("figure", lty=3, lwd=3)  
# box('inner')
  
# 외각 영역에 주석 달기
mtext("Outer Margin Area", side=1, line=1, cex=2, col="blue", outer=TRUE)  
mtext("par(oma=c(b,l,t,r))", side=1, line=2, cex=1, col="blue", outer=TRUE)  
mtext("Line 0", side=1, line=0, adj=0.0, cex=1, col="blue", outer=TRUE)  
mtext("Line 1", side=1, line=1, adj=0.0, cex=1, col="blue", outer=TRUE)  
mtext("Line 2", side=1, line=2, adj=0.0, cex=1, col="blue", outer=TRUE)  
box("outer", lty=1, lwd=3)  

# 원상 복귀
par(oldpar)

dev.off()
