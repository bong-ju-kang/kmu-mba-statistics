#
# Bong Ju Kang
# R 기반의 통계분석: 기초부터 활용까지
# 
# created: 6/10/2019
# name: R_introduction_xxxxxxxx.R
#

#
# 숫자와 벡터
#

## 벡터와 할당문
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
print(x)
# <-: 할당  
# c: 함수

# 할당하는 다른 방법
assign("x", c(10.4, 5.6, 3.1, 6.4, 21.7))
print(x)

# 객체의 구조
str(x) # 디폴트는 열 벡터(column vector)행 벡터(row vector)
str(t(x)) # 전치(transpose)하면 행 벡터(row vector)

# 벡터의 연산
1/x


## 벡터 연산
y <- c(1, 2, 3, 4, 5)
v <- 2*x + y +1
print(v)
bnncbm(x)

# 기본 연산(원소별 연산): +, - , *, /, ^  
# 기본 함수: log, exp, sin, cos, tan, sqrt, range

# 연산의 다양한 예
1+2
2^10
2**10
log(2)
log2(2)
log10(10)
x = c(1, 2, 3, 4)
range(x) # 최소값, 최대값

x = seq(1,10, 1)
sum((x-mean(x))^2/(length(x)-1)) # 표본 분산
var(x) # 표본 분산

sort(c(2,3,1,4))
sort(c(2,3,1,4), decreasing=TRUE)


## 규칙 열(regular sequence) 생성
# 열을 생성하는 방법
seq(1, 10, 1)
10:1
seq(-1, 5, by=2)
rep(c(1, 2, 3), times=5)
rep(c(1, 2, 3), each=5)


## 논리 벡터
# 논리 연산자: <, <=, >, >=, ==, !=  
# 논리 표현의 결합: c1 & c2 (and), c1 | c2 (or)

tmp <- c(1, 2,3) > 1
print(tmp)
1==TRUE 
0==FALSE
-1==FALSE
sum(tmp)

tmp2 <- c(1, 2, 3) == 2
print(tmp2)
tmp & tmp2
tmp | tmp2

## 결측값
# 결측값의 유형: NA(not available), NaN(not a number)

x <- c(1:3, NA)
is.na(x)
0/0
x <- c(1:3, NA, NaN)
is.na(x)
sum(is.na(x))


## 문자 벡터
# 문자 벡터(character vector): 인용 부호("", '')내에 있는 문자 열

x <- 'Introduction to R'
print(x)
paste(c("x", "y"),1:2, sep="")
paste(c("x", "y"),1:3, sep=",")

## 색인 벡터
# 색인 벡터(index vector): 벡터의 원소(element) 값들을 가져오기 위한 벡터  
# 색인 벡터의 유형: 논리 벡터, 양수값 벡터, 음수값 벡터, 문자열(string) 벡터

# 논리 벡터
x <- c(1:10, NA)
x[!is.na(x)]
x[(!is.na(x) & x>1)]

# 양수값/음수값 벡터
x[1:5]
x[-length(x)] # 해당 위치 값 제거
x[-11:-9]

# 문자열 벡터
x <- 1:3
names(x)
names(x) <- c("orange", "apple", "banana")
print(x)
x[c("orange")]

## 다른 유형의 객체
# 행렬(matrix), 인자(factor), 리스트(list), 데이터프레임(data frame), 함수(function)

# 행렬
matrix(c(1:9), nrow=3, byrow=T)

# 리스트
list(c(1:9), 2:10)

# 데이터프레임
data.frame(matrix(c(1:9), nrow=3, byrow=T))

# 함수
add <- function(x, y){
  return(x+y)
}
add(1, 2)

#
# 객체, 모드 그리고 속성
#

## 타고난 속성: 모드, 길이

x <- 1:10
mode(x) # 원자 구조 유형
length(x)

y <-"R 기본 개념"
mode(y)
length(y)

z <- list(x, y)
mode(z)
length(z)

# 모드의 변경
xtoc <- as.character(x)
print(xtoc)
mode(xtoc)

ctox <- as.integer(xtoc)
print(ctox)
mode(ctox)

## 객체 길이 변경
# 객체의 길이는 변경 가능하다.

x <- numeric()
print(x)
length(x)

x[10] <- 10
print(x)
x[11] <- 11
print(x)

length(x) <- c(5)
print(x)


## 객체 속성의 정의
# 타고난(intrinsic) 속성 또는 고유 속성(모드와 길이)이 아닌 속성에 대한 정의 및 조회

# 속성 정의
x <- numeric()
length(x) <- 5*5
print(x)

attr(x, "dim") <- c(5,5)
print(x)

# 속성 조회
attr(x, "dim")
dim(x)
nrow(x)
ncol(x)


## 객체의 클래스

x <- 1:10
mode(x)
class(x)

x <- c(1.1, 2.1)
mode(x)
class(x)

x <- list(c(1, 2, 3), c("ab", "bc", "cd"))
mode(x)
class(x)

df <- as.data.frame(x)
mode(df)
class(df)

# 클래스의 제거
udf <- unclass(df)
class(udf)


#
# 순서, 무순서 요인
#

## 예를 통한 이해

# 숫자 데이터 
x <- c(1, 2, 3, 4, 3, 4, 5)
factor(x)

# 그래프로 확인
plot(x)
plot(factor(x))

# 범주 데이터
# 호주의 행정구역 데이터
state <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
"qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
"sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
"sa", "act", "nsw", "vic", "vic", "act")

statef <- factor(state)
print(statef)

mode(statef) # 고유 속성은 숫자
length(statef) # 길이는 원래 데이터와 동일
class(statef)

levels(statef) # 알파벳 순으로 정렬
is.ordered(statef) # 순서가 있는 인자인지 확인
ordered(state) # 순서가 있는 경우


## tapply(), 비정형 배열(ragged array)

# 인자와 같은 크기의 수입 데이터
incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
59, 46, 58, 43)

# 수입 데이터를 인자 별로 분류하고 각 인자 별 평균을 구한다.
incmeans <- tapply(incomes, statef, mean)
print(incmeans, digits=4)

# 표준편차를 구한다.
stdError <- function(x) sqrt(var(x)/length(x))
incster <- tapply(incomes, statef, stdError)
print(incster, digits=4)


#
# 배열과 행렬
#

## 배열

x <- seq(1, 24, 1) # 여기까지는 벡터
is.array(x)

dim(x) <- c(24)
is.array(x)

dim(x) <- c(3,8)
print(x) # 열 우선으로 표현

t(x) # 행과 열을 전치하고자 하는 경우
matrix(x, nrow=3, ncol=8, byrow=TRUE)

array(x, dim=c(3, 4,2)) # array 함수 이용
print(x)
is.matrix(x)

## 배열 색인, 배열 구획

x <- 1:12
dim(x) <- c(3, 4)
print(x)


x[1,2]
x[1:2,] # 2x4 배열
dim(x[1:2,])

x[1,] # 1x4 배열, 벡터
dim(x[1,]) # 벡터는 차원이 없음
is.vector(x[1,])
is.array(x[1,])

## 색인 행렬

x <- array(1:20, dim=c(4,5))
print(x)

i <- array(c(1:3, 3:1), dim=c(3,2)) # 특정 구역 정의
print(i)
x[i]

x[i] <- 0 # 특정 구역의 값을 바꾸기
print(x)

## 배열 외적

x <- array(1:3)
y <- array(4:6)

x %o% y # 외적
outer(x, y, "*") # 함수 이용
x %*% t(y) # 열 배열과 행 배열의 곱: 외적과 동일

# x, y의 모든 가능한 조합에서의 함수값 구하기 
x <- y <- 1:10
f <- function(x,y) cos(y)/(1+x^2)
z <- outer(x, y, f)
print(z[, 1:3], digits=4)



## 배열의 전치

x = array(1:10, dim=c(2,5))
print(x)
t(x)


## 행렬 기반의 함수

### 행렬 곱

# 열 우선으로 행렬 생성
A = matrix(1:6, nrow=3, ncol=3, byrow=T)
B = matrix(1:6, nrow=3, ncol=3, byrow=T)
x = 1:3

print(A)
print(B)
print(A * B) # 원소별 곱
print(A %*% B) # 행렬 곱

t(x) %*% A %*% x

diag(1:3) #  벡터의 값을 대각 원소의 값으로 갖는 행렬 출력
diag(A) # 기존 행렬의 대각 원소의 값을 벡터로 출력 
is.vector(diag(A))


### 선형 방정식과 역 행렬

# 행렬 생성
A <-  matrix(c(1,3,2, 2, 4, 5, 6, 4,3), nrow=3)
b <- array(c(3, 2, 2))

print(solve(A)) # A의 역행렬 구하기
solve(A) %*% b # 수치적으로 비효율적이며 불안정함

solve(A, b) # 추천 방식

### 고유값과 고유벡터

# 대칭(symmetric) 행렬 구성
B <-  matrix(c(1,3,2, 2, 4, 5, 6, 4,3), nrow=3)
A <- t(B) %*% B  

# 고유값, 고유벡터 계산
ev <- eigen(A)
print(ev)

mode(ev) # 고유 속성은 리스트
# 고유값을 가져오기 위한 방법
ev$values # 고유값 
ev["values"]

# 고유벡터
ev$vectors

### 특이값 분해 및 행렬식

# 행렬 생성
A <-  matrix(c(1,3,2, 2, 4, 5, 6, 4,3, 10), nrow=2)
print(A)

# 특이값 분해
svd <- svd(A)
names(svd)

# 원 행렬과 같은지 확인
svd$u %*% diag(svd$d) %*% t(svd$v)

# 정방행렬 생성
B <- t(A) %*% A
det(B)


### 최소제곱 적합, QR 분해

# X, y 생성
X <-  matrix(c(1,3,2, 2, 2, 5, 6, 4,3, 10), nrow=5)
y <- rnorm(5, 0, 1)

# 최소제곱 적합
fit <- lsfit(X, y, intercept = T)
print(fit)
# 회귀계수
fit$coef

# QR 분해에 의한 회귀직선 적합: 절편항을 추가 후 적합
qr <- qr(cbind(array(1, dim=c(5,1)), X), y)
print(qr)
# 회귀계수
qr.coef(qr, y)


## 분할 행렬 구성

# 행렬 구성
X <-  matrix(c(1,3,2, 2, 2, 5, 6, 4,3, 10), nrow=5)
print(X)
cy <- rnorm(5, 0, 1)
ry <- runif(2)

# 열 별 결합
XwithCY <- cbind(X, cy)
print(XwithCY)
is.matrix(XwithCY)

# 행 별 결합
XbelowRY <- rbind(X, ry)
print(XwithCY)

# 자동 차원 조절
cbind(1, X)
rbind(1, X)

## 연결 함수

# 행렬 생성
X <-  matrix(c(1,3,2, 2, 2, 5, 6, 4,3, 10), nrow=5)
print(X)
as.vector(X) # 열 우선으로 벡터를 구성

# 연결함수 적용
c(X, X)
is.matrix(c(X, X))

## 요인벡터를 이용한 빈도표 생성

# 범주 데이터 구성
state <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
"qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
"sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
"sa", "act", "nsw", "vic", "vic", "act")

# 원 데이터로 부터 빈도표 구성
table(state)

# 인자 생성
statef <- factor(state)
# 인자로부터 빈도표 구성
table(statef)

# 숫자 데이터 구성: 인자와 같은 크기로 구성
income <- runif(length(state), 10, 100)

# 데이터 값의 4분위수에 해당 하는 값을 구성(버킷 구성): 범주 변수로 재탄생
incomecut <- cut(income, breaks=quantile(income, probs=seq(0,1, 0.25)), include.lowest=T)
print(incomecut)

# 빈도표 구성 
incomef <- factor(incomecut)
table(incomef) # 빈도가 비슷

# 2원 빈도표 구성
table(statef, incomef)

# 원 데이터로부터 구성: 범주 변수인 경우는 동일
table(state, incomef)

# 그림으로 확인
plot(table(statef, incomef))
plot(table(state, incomef))

#
# 리스트와 데이터프레임
#

## 리스트
# 구성원 생성
x <- c(1:10)
y <- matrix(seq(1,6), nrow=2)
z <- 'R and Statistical Analysis'

# 리스트 생성 및 구성원에 대한 이름 주기
lst <- list(x=x, y=y, z=z) 
names(lst)

# 이름으로 구성원 가져오기
lst$x 

# 색인으로 구성원 가져오기
lst[[3]]
lst[3]

# 구성원에서 특정 위치 값 가져오기
lst[[1]][1] 
lst[[2]][1,2]


## 리스트 수정, 리스트 연결

# 구성원 생성
x <- c(1:10)
y <- matrix(seq(1,6), nrow=2)

# 리스트 생성
lst <- list(x=x, y=y) 
print(lst)

# 리스트 수정
lst[[2]] <- matrix(seq(1,6), nrow=3)
lst$y <- matrix(seq(1,6), nrow=3)
print(lst)

# 리스트 연결
clist <- c(lst, lst)
mode(clist)

## 데이터프레임
### 데이터프레임 생성

# 태그 없는 데이터프레임
df <- data.frame(rnorm(100), runif(100), sample(c('A','B', 'C', 'D'), 100, replace=T))
str(df)

# 태그 있는 데이터프레임
df <- data.frame(a=rnorm(100), b=runif(100), c=sample(c('A','B', 'C', 'D'), 100, replace=T))
str(df)
mode(df)

# 각 구성원은 참조하는 방법은 리스트와 동일. 각 구성원도 데이터프레임
df["a"][1:5,] 
df[1:5, 'a']

### attach(), detach()

# 데이터프레임 생성
df <- data.frame(a=rnorm(10), b=runif(10), c=sample(c('A','B', 'C', 'D'), 10, replace=T))
# 탐색 경로
search()
# 탐색 경로에 있는 객체이름 목록
# ls(.GlobalEnv, )

# 탐색 경로 2번째에 올리기
attach(df)
search()

# 객체의 목록 보기
ls(df)
# 탐색 경로 위치로 검색
ls(2) 

# 구성원 이름 확인 및 내용 보기
print(a)
plot(a)

# 탐색 경로에서 해제하기
detach(df)


### 파일로부터 데이터 읽기

# URL로부터 데이터 읽기
df <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")

# 디폴트 변수명
names(df)

# 변수명 새로 주기
names(df) <- c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV")

# 데이터 구조 탐색
str(df)

# 데이터 내용 보기
head(df)
tail(df)

# 하나의 긴 배열로 데이터 읽기
dataArray  <- scan("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")

# 데이터 모양 정하고 데이터 프레임 생성하기
dim(dataArray) <- c(506, 14)
df <- as.data.frame(dataArray)

# 데이터 구조 탐색
str(df)
class(df)

# .csv 파일 읽기
df <- read.table(paste0(path, '/Data/bank.csv'), sep=',', header=T)
str(df)

# library(data.table)
# df <- fread("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
# names(df) <- tolower(c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV"))
# str(df)


### 내장된 데이터 읽기

# datasets 패키지에 내장된 데이터 목록
dlist <- data(package='datasets')

# 리스트의 구조
str(dlist)

# 데이터목록 5개만 출력
head(dlist$results, 5)

# 데이터 바로 이용하기
str(BJsales)
plot(BJsales)

# 다른 패키지에서 제공되는 데이터 목록 확인 및 로딩
library(ISLR)
head(data(package='ISLR')$results, 5) 

# 데이터 바로 이용하기
names(Auto)

#
# 확률 분포
#

## 통계표
# 표준 정규 분포: 평균이 0, 표준편차가 1

# 분포함수
dnorm(-3:3, mean=0, sd=1)

# 확률밀도함수
pnorm(-3:3, 0, 1)

# 분위수함수
qnorm(seq(0,1, 0.05))

# 상위 2.5% 에 해당하는 분위수 찾기
qnorm(1-0.025)

# 상위 0.5% 에 해당하는 분위수 찾기
qnorm(1-0.005)

# 난수 생성
set.seed(123456789)
rnorm(5, 0, 1) 

## t 분포
# 상위 2.5% 에 해당하는 분위수 찾기
qt(1-0.025, df=10)


## 분포 탐색

#  미국 Yellowstone 국립원 Old Faithful의 간헐천(geyser) 분출시간(분)과 분출간 대기시간
# datasets 패키지의 데이터
str(faithful)
attach(faithful)

# 요약 통계량
summary(eruptions)
fivenum(eruptions)

# 줄기-잎 그림
stem(eruptions)

# 히스토그램
hist(eruptions)

# 히스토그램에 추가 
pngfile <- paste0(graph_path, '/그림 18.1.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

hist(eruptions, seq(1.6, 5.2, 0.2), prob=TRUE)
lines(density(eruptions, bw = "SJ")) # 커널 밀도 추정량, bw는 띠너비 옵션
rug(eruptions, side=1)

dev.off()

# 경험 분포
pngfile <- paste0(graph_path, '/그림 18.2.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(ecdf(eruptions), do.points=FALSE, verticals=TRUE) # 정규 분포와는 거리가 있음

dev.off()

# 일부 구간만 설정 후 정규분포와 비교
long <- eruptions[eruptions > 3]

pngfile <- paste0(graph_path, '/그림 18.3.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(ecdf(long), do.points=FALSE, verticals=TRUE)
x <- seq(3, 5.4, 0.01)
lines(x, pnorm(x, mean=mean(long), sd=sqrt(var(long))), lty=3)

dev.off()

# Q-Q 그림: 짧은 우측 꼬리
pngfile <- paste0(graph_path, '/그림 18.4.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

qqnorm(long)
qqline(long)

dev.off()

# t 분포와 정규분포 비교: 긴 꼬리
x <- rt(250, df = 5)

pngfile <- paste0(graph_path, '/그림 18.5.png')
png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

qqnorm(x)
qqline(x)

dev.off()

# 정규 분포 검정: Shapiro-Wilk test,  Kolmogorov-Smirnov test
shapiro.test(long) # 5% 유의수준에서 정규분포가 아님
# ks.test(long, "pnorm", mean = mean(long), sd = sqrt(var(long)))


## 2-표본 검정

# 얼음융합 잠재열 데이터: 방법 A, 방법 B
A <- "79.98 80.04 80.02 80.04 80.03 80.03 80.04 79.97 80.05 80.03 80.02 80.00 80.02"
A <- as.numeric(strsplit(A, " ")[[1]])

B <- "80.02 79.94 79.98 79.97 79.97 80.03 79.95 79.97"
B <- as.numeric(strsplit(B, " ")[[1]])

# 상자그림으로 평균의 차이 확인

pngfile <- paste0(graph_path, '/그림 18.6.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

boxplot(A, B, names=c('A', 'B'))

dev.off()

# 2집단의 표본의 개수 확인
length(A)
length(B)

# 등분산 가정이 없는 평균 동일여부 검정
t.test(A, B)

# 등분산에 대한 검정
var.test(A, B)

# 등분산 가정 
t.test(A, B, var.equal=TRUE)

# 정규 가정 없는 비모수 검정
wilcox.test(A, B)

# 분포 동일성 여부에 대하여 경험분포로부터 확인
pngfile <- paste0(graph_path, '/그림 18.7.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(ecdf(A), do.points=FALSE, verticals=TRUE, xlim=range(A, B))
plot(ecdf(B), do.points=FALSE, verticals=TRUE, lty=3, add=TRUE)

dev.off()

# 통계량으로 확인
ks.test(A, B)


# 그룹화, 반복, 조건 실행

## 조건문
### if 문

# 기본 형식
if (2 %in% c(1, 2,3)) print(TRUE) else print(FALSE)

# 단락(short-circuit)
if (4 %in% c(1, 2,3) && 3 %in% c(1,2,3)) print(TRUE) else print(FALSE)

## 반복 실행: for, repeat, while

# 기본 형식
for (i in 1:3){
  print(i)
  if (i==3) print('***')
} 

# 기본형식
while(i == 3){
  print('***')
  break
} 


#
# 함수 만들기
#

## 단순 예

# 2-표본의 검증 통계량 t값 계산하기
twosam <- function(y1, y2) {
  n1 <- length(y1)
  n2 <- length(y2)
  yb1 <- mean(y1)
  yb2 <- mean(y2)
  s1 <- var(y1)
  s2 <- var(y2)
  s <- ((n1-1)*s1 + (n2-1)*s2)/(n1+n2-2)
  tst <- (yb1 - yb2)/sqrt(s*(1/n1 + 1/n2))
  return(tst)
}

# 함수의 적용
set.seed(123)
y1 = rnorm(100, 0, 1)
y2 = rnorm(50, 0.2, 1)

twosam(y1, y2)

## 이항 연산자의 정의

# 정의
"%!%" <- function(y1, y2) {
  n1 <- length(y1)
  n2 <- length(y2)
  yb1 <- mean(y1)
  yb2 <- mean(y2)
  s1 <- var(y1)
  s2 <- var(y2)
  s <- ((n1-1)*s1 + (n2-1)*s2)/(n1+n2-2)
  tst <- (yb1 - yb2)/sqrt(s*(1/n1 + 1/n2))
  return(tst)
}

# 적용하기
set.seed(123)
y1 = rnorm(100, 0, 1)
y2 = rnorm(50, 0.2, 1)
y1 %!% y2


#
# 그래픽 프로시저
#

## 그래프 인자값 확인
head(par(), 10)

### plot()

# x값만 존재
pngfile <- paste0(graph_path, '/그림 18.8.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(x=c(3:10))

dev.off()

# x, y값 존재
pngfile <- paste0(graph_path, '/그림 18.9.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(c(1:10), rnorm(10))

dev.off()


# x가 요인인 경우
pngfile <- paste0(graph_path, '/그림 18.10.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(factor(sample(c('A', 'B', 'C'), 10, replace = T)))

dev.off()

# x가 요인이고 y가 값이 있는 경우
pngfile <- paste0(graph_path, '/그림 18.11.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(factor(sample(c('A', 'B', 'C'), 10, replace = T)), 1:10)

dev.off()

### 다변량 자료 전시
# 데이터 생성
df <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
names(df) <- tolower(c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE",
                     "DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV"))

# 산점도 행렬
pngfile <- paste0(graph_path, '/그림 18.12.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=7, height = 7, units = 'in', res=600)

pairs(df[c("rm", "lstat", "medv")])

dev.off()

# 조건부 산점도: conditioning plot
pngfile <- paste0(graph_path, '/그림 18.13.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

attach(df)
coplot(medv ~ rm | chas, given.values = c(0,1))
detach(df)

dev.off()
### 고수준 그림의 인자

# 전역 그림인자 초기화 
dev.off()

# axies=FALSE
pngfile <- paste0(graph_path, '/그림 18.14.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(rnorm(10), axes=F, main='axis=FALSE')

dev.off()

# log='x'
pngfile <- paste0(graph_path, '/그림 18.15.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(x=10**c(1:10), rnorm(10), log='x', main='log="x"')

dev.off()

# type='p', type='l', type='b', type='n'
pngfile <- paste0(graph_path, '/그림 18.16.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

par(mfrow=(c(2,2)))
plot(rnorm(10), type='p', main='type="p"')
plot(rnorm(10), type='l', main='type="l"')
plot(rnorm(10), type='b', main='type="b"')
plot(rnorm(10), type='n', main='type="n"')
par(mfrow=(c(1,1))) 

dev.off()

# xlab, ylab, main
pngfile <- paste0(graph_path, '/그림 18.17.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(1:10, rnorm(10), type="b", xlab="최근10개월", ylab="최근주가", main="최근10개월 주가" )

dev.off()
## 저수준 그림 함수들

# 전역 그림인자 초기화
dev.off()

# title, axis, abline, text 사용
pngfile <- paste0(graph_path, '/그림 18.18.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

set.seed(1234)
plot(1:10, rnorm(10), type="b", xaxt='n', ann=FALSE )
title(xlab="최근10개월", ylab="최근주가", main="최근10개월 주가")
axis(side=1, at=1:10, labels=paste0(10:1, '개월전'))
abline(h=0)
text(8, 0.2, "randowm walk")

dev.off()

### 수학 기호 주석달기

# 패키지 이용
library(latex2exp)

# 데이터 생성
x <- seq(0, 4, length.out=100)
alpha <- 1:5

# 그림 구조 생성
pngfile <- paste0(graph_path, '/그림 18.19.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(x, xlim=c(0, 4), ylim=c(0, 10), 
     xlab='x', ylab=TeX('$\\alpha  x^\\alpha$, where $\\alpha \\in 1\\ldots 5$'), 
     type='n', main=TeX('Using $\\LaTeX$ for plotting in base graphics!'))

# 콘솔에 프린트 하지 않기
invisible(sapply(alpha, function(a) lines(x, a*x^a, lty=a)))

# 범례함수 사용
legend('topright', legend=TeX(sprintf("$\\alpha = %d$", alpha)), 
       lwd=1, lty=alpha, cex=0.7)

dev.off()

## 그래픽 인자/모수 사용

### 영구 수정: par()

# par() 함수를 이용. 모든 모수값 확인
invisible(par()) 

# 고유 속성은 리스트
mode(par()) 

# 지정된 값 보기
par(c("col", "lty")) 
par('pch')

# 지정된 값 수정
pngfile <- paste0(graph_path, '/그림 18.20.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

par(pch=2)
plot(1:10)
# 원상 복귀
par(pch=1)

dev.off()



### 일시 수정

# 문자의 종류와 크기 지정
pngfile <- paste0(graph_path, '/그림 18.21.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(1:10, pch='*', cex=2) 

dev.off()

### 그래픽 원소

# pch 예시
x <- c(0:25)
pngfile <- paste0(graph_path, '/그림 18.22.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

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
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(rnorm(10), main='표준정규분포값', family='d2', font=3)

dev.off()

# adj의 의미
pngfile <- paste0(graph_path, '/그림 18.24.png')
png(filename =pngfile, width=700, height = 700)
png(filename =pngfile, width=8, height = 8, units = 'in', res=600)

par(mfrow=c(2,2))

x <- c(1:5)
plot(x, main='왼쪽 정렬', font.main=2)
text(x, x, x, adj=0)

plot(x, main='오른쪽 정렬', font.main=3)
text(x, x, x, adj=1)

plot(x, main='가운데 정렬', font.main=4)
text(x, x, x, adj=0.5)

plot(x, main='왼쪽 정렬에서 30% 오른쪽으로', font.main=4)
text(x, x, x, adj=-0.3)

par(mfrow=c(1,1))

dev.off()

# cex의 의미
x <- c(1:10)

pngfile <- paste0(graph_path, '/그림 18.25.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

plot(x, main='cex(문자 확장)')
text(2, 2, 2, adj=-0.3, cex=1)
text(3, 3, 3, adj=-0.3, cex=2)
text(4, 4, 4, adj=-0.3, cex=3)

dev.off()

### 축과 눈금 표시

# lab의 의미
x <-rnorm(10)

pngfile <- paste0(graph_path, '/그림 18.26.png')
# png(filename =pngfile, width=700, height = 700)
png(filename =pngfile, width=8, height = 8, units = 'in', res=600)

par(mfrow=c(1,2))
plot(x, lab=c(5,3, 5), main='lab=c(5,3, 5)', las=1)
plot(x, lab=c(10,100, 5), main='lab=c(10,100 5)', las=2)
par(mfrow=c(1,1))

dev.off()

# las의 의미
pngfile <- paste0(graph_path, '/그림 18.27.png')
# png(filename =pngfile, width=500, height = 500)
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
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

par(mfrow=c(1,2))
plot(1:5, main='디폴트')
plot(1:5, main='tck=0.1', tck=0.1)
par(mfrow=c(1,1))

dev.off()

### 피거 여백

pngfile <- paste0(graph_path, '/그림 18.29.png')
# png(filename =pngfile, width=500, height = 500)
png(filename =pngfile, width=6, height = 6, units = 'in', res=600)

# 전역 그래픽 모수 저장: 나중에 복귀하기 위하여 
oldpar <- par(no.readonly = T)

# 디폴트 값 확인
par('oma') # 0 0 0 0
par('mar') #  5.1 4.1 2.1 2.1

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
box("figure", lty=3, lwd=3)  
  
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
#
# 패키지
#

## 패키지 확인 및 로드

# 설치된 패키지 확인
head(library()$results, 5)
# installed.packages()

# 로드된 패키지들
search() 

# 로드되었지만 탐색 목록에 없는 패키지들
loadedNamespaces() 

# 새로운 패키지의 설치, 갱신 및 사용
# install.packages('data.table', , dependencies=TRUE)
update.packages('data.table')
library(data.table)
data.table(x=rnorm(10))

## 이름공간

# t 함수를 갖는 패키지 목록
getAnywhere(t)
Matrix::t

#
# 운영시스템 관련 함수들
#

## 파일과 디렉토리

# 현재 설정된 경로
getwd()

# 설정된 디렉토리의 디렉토리와 파일들
# list.files()
# dir()

# 하위 디렉토리
list.dirs()

# 디렉토리 생성
dir.create("temp")

# 디렉토리 제거
unlink("temp", recursive = T)

# 파일 존재 여부 확인
file.exists('birth.R') == TRUE

## 파일 경로

# 현재의 경로
getwd()

# 새로운 경로 지정
setwd("d:/BANENE") 
# 또는 setwd("d:\\BANENE")

# 경로 확인
getwd()
dir.exists("d:/BANENE")


