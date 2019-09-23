#
# Bong Ju Kang
# R기반의 통계분석: 기초부터 활용까지
# 
# created: 6/10/2019
# name: 01.stat_R_introduction_xxxxxxxx.R
#

#
#
# 데이터 구조에 대한 이해
#
#

#
# 숫자와 벡터
#

## 벡터와 할당문
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
# print(x)
# x

# <-: 할당  
# c: 함수

# 할당하는 다른 방법: 잘 사용하지 않음
# assign("x", c(10.4, 5.6, 3.1, 6.4, 21.7))
print(x)
str(summary(c(1, 2, 3)))

# 객체의 구조
str(x) # 디폴트는 열 벡터(column vector)
str(t(x)) # 전치(transpose)하면 행 벡터(row vector)

length(x)


## 벡터 연산 -----
y <- c(1, 2, 3, 4, 5)
v <- 2*x + y + 1
print(v)

# 기본 연산(원소별 연산): +, - , *, /, ^  
# 기본 함수: log, exp, sin, cos, tan, sqrt, range

# 연산의 다양한 예

1+2
2^10
2**10

log(2)
log(exp(1))
log2(2)
log10(10)

pi
sin(pi/2)
cos(0)
cos(pi/2)
cos(pi/2) < 10**(-12)
tan(0)
tan(pi/2)


x = c(1, 2, 3, 4)
exp(x) 

log(x) # 자연 로그 
range(x) # 최소값, 최대값

x = seq(1,10, 1)
sum((x-mean(x))^2/(length(x)-1)) # 표본 분산
var(x) # 표본 분산

sort(c(2,3,1,4))
sort(c(2,3,1,4), decreasing=TRUE)

# 예제: 
# 1) 10을 밑으로 하는 로그 10, 100, 1000의 값은?
# 2) c(1, 2, 3)의 제곱의 합은?


# x <- c(1, 2, 3)
# sum(x^2)

log10(c(10, 100, 1000))
sum(c(1, 2, 3)^2)

## 규칙 열(regular sequence) 생성 -----
# 열을 생성하는 방법
seq(1, 10, 1)
seq_len(10)
10:1
1:5

seq(-1, 5, by=2)
rep(c(1, 2, 3), times=5)
rep(c(1, 2, 3), each=5)

# rep(c(1), times=5)

# 예제:
# 1) 다음의 열을 생성하세요.
# 1, 3, 5, 7, 9, 11, 17



c(seq(1, 11, 2), 17)

## 논리 벡터 -----
# 논리 연산자: <, <=, >, >=, ==, !=  
# 논리 표현의 결합: c1 & c2 (and), c1 | c2 (or), !c1, xor(c1, c2)

# 논리 벡터인 이유
# x <- c(1, 2, 3)

c(1, 2, 3) > 1
c(1, 2, 3) == 1
# x[x > 1]

# 논리 벡터의 예
tmp <- c(1, 2,3) > 1
print(tmp)
is.logical(tmp)

# 키워드: TRUE, FALSE
# TRUE, 1, T: 모든 같은 의미
1 == TRUE # TRUE 가 형변환 일어나서 1로 됨
3 == TRUE

0 == FALSE

-1 == FALSE
-1 == T

as.logical(-1) == T

3 == TRUE 
as.logical(3) == TRUE
c(1, 2, 3) == T

# 논리 벡터의 합
sum(tmp)
T+T+F+F+T

# 논리 벡터의 결합
tmp1 <- c(1, 2, 3) == 1
tmp2 <- c(1, 2, 3) == c(1, 2, 7)
tmp1 & tmp2
tmp1 | tmp2
!tmp1
xor(tmp1, tmp2) # 둘 다 참 또는 거짓이면 거짓, 아니면 참
xor(c(0, 2, 3), c(2, 3, 4))

# 예제:
# 1) 7 == TRUE 의 결과는?
# 2) as.logical(c(0, 1, 2, -1))의 결과는?



7 == TRUE
as.logical(c(0, 1, 2, -1))

## 결측값 -----
# 결측값의 유형: NA(not available), NaN(not a number)
NA
is.na(NA)

x <- c(1:3, NA)
is.na(x) # 결과는 벡터

NaN
0/0
is.na(0/0) #NaN도 결측값

# log(-3)
x <- c(1:3, NA, NaN)
is.na(x)
sum(is.na(x))

# 예제
# 1) c(1:3, NA, NaN)의 결측값을 0으로 치환하세요.



x <- c(1:3, NA, NaN)
x[is.na(c(1:3, NA, NaN))] <- 0

## 문자 벡터 -----
# 문자 벡터(character vector): 인용 부호("", '')내에 있는 문자 열

x <- 'Introduction to R'
print(x)
is.vector(x)
# x[2]
x <- c('a', 'abc')
print(x)
is.vector(x)
length(x)

# 문자열의 유용한 함수
paste(c("x", "y"),1:2, sep="")
paste(c("x", "y"),1:5, sep="")
paste(c("x", "y"),1:2, sep=",")
paste(c("x", "y"),1:2, sep="", collapse = "+")
paste0(c('x'), 1:10)
paste(c('x'), 1:10, sep='')

# 예제:
# 1) y ~ x1+x2+x3 와 같은 식을 생성하세요.

# as.logical(-1)==T
# -1==T
# as.integer(T)

x <- paste0(c('x'), 1:3, collapse = '+')
c('y~',  x)
as.formula(c('y~',  xexp))


## 색인 벡터 -----
# 색인 벡터(index vector): 
# 벡터의 원소(element) 값들을 가져오기 위한 벡터  
# 색인 벡터의 유형:
# 논리 벡터, 양수값 벡터, 음수값 벡터, 문자열(string) 벡터

# 논리 벡터
x <- c(1:10, NA)
length(x)
length(!is.na(x)) # 논리 벡터는 원래 벡터와 길이가 같아야 함
x[!is.na(x)]

x > 1 # NA는 NA로 결과가 나옴
NA > 1
!is.na(x)
NA & FALSE # NA와 F의 결과는 F 
x[(!is.na(x) & x>1)]

# 양수값/음수값 벡터
x[1:5]
x[-length(x)] # 해당 위치 값 제거
x[-length(x):-9]

# 문자열 벡터
x <- 1:3
names(x)
names(x) <- c("orange", "apple", "banana")
print(x)
x[c("orange")]

# 예제
# 1) seq(10) 에서 홀수번째 값만 가져오세요.
# 2) 논리벡터를 사용하여 값이 c(1, 3, 9) 인 것만 가져오세요.  



# 1)
x <- seq(10)
x[seq(1, length(x), 2)]

# 2)
index <- (x ==1 | x==3 | x==9)
x[index]

## 다른 유형의 객체 -----
# 행렬(matrix), 
# 인자(factor), 
# 리스트(list), 
# 데이터프레임(data frame), 
# 함수(function)

# 행렬
m <- matrix(c(1:9)) # 열 벡터
# m[2,1]
m <- matrix(c(1:9), nrow=3) # 열 우선
# m[,2]
matrix(c(1:9), nrow=3, byrow=T)

# 리스트
list(c(1:9), 2:10)
# 서로 다른 데이터 형도 가능
mode(c('KANG', 'KO', '...'))
mode(c(1:31))
lst <- list(c(1:31), names=c('KANG', 'KO', '...'))
# lst[[1]]
# lst$names
# lst[[2]]
# lst[[1]][7]

# 데이터프레임
df <- data.frame(matrix(c(1:9), nrow=3, byrow=T))
# names(df)
# names(df) <- c('reg_no', 'xxx', 'no')

# 함수
add <- function(x, y){
  return(x+y)
}
add(1, 2)


#
# 객체, 모드 그리고 속성
#

## 타고난 속성, 고유 속성: 모드(객체의 원자 구조), 길이

# 모드
# 숫자값,
# 복소수값, 
# 논리값, 
# 문자값, 
# 아스키(ASCII: 미국 표준문자 코드)값(raw), 
# 함수, 
# 표현(expression)

# 숫자: numeric
x <- 1:10
mode(x) # 원자 구조 유형
length(x)
typeof(x) # R 내부의 원자 구조 유형, 좀 더 세분화됨

x <- c(0.1, 1, 0.3)
mode(x) 
length(x)
typeof(x)
# mode(lst[[1]])

# 복소수: complex
x <- 1+2i
mode(x) 
length(x)
typeof(x)

# 문자: character
y <-"R 기본 개념"
mode(y)
length(y)

# 함수
mode(add)

# 표현식 
exp <- expression( x <- pi)
mode(exp)
length(exp)
eval(exp)
print(x)

# 리스트
z <- list(x, y)
mode(z)
length(z)

# 데이터프레임
df <- data.frame(x=c(1, 2), y=c('a', 'b'), z=c(1.1))
# df$x
# df[[1]]

mode(df)
length(df)

# 행렬
mat <- matrix(1:9, nrow=3)
mode(mat)

# 모드의 변경: 가능한 경우만
x <- c(0.1, 1, 0.7)
xtoc <- as.character(x)
print(xtoc)
mode(xtoc)

ctox <- as.integer(xtoc)
print(ctox)
mode(ctox)

# lst
# df <- as.data.frame(list(c(1, 2, 3), c(2, 3, 4)))
# mode(df)
# names(df) <- c('x', 'y')

as.expression(x)
# library(data.table)
# as.data.frame(data.table(c(1, 2, 3)))

# 예제
# 1) c('abc', 'def')의 모드를 숫자로 변경하면?



x <- c('abc', 'def')
mode(x)
mode(x) <- c('numeric')
# 또는 as.numeric(x)



## 객체 길이 변경
# 객체의 길이는 변경 가능하다.
x <- numeric()
print(x)
length(x)

x <- numeric(5)
print(x)

x[10] <- 10
print(x)
x[11] <- 11
print(x)

length(x) <- c(5)
print(x)

ll <- list()
length(ll)
print(ll)

ll[[5]]=c(1, 2, 3)
print(ll)
length(ll)

# 예제
# 1) df <- data.frame(x=c(1, 2), y=c('a', 'b'), z=c(1.1))
# 의 길이를 구하고 2로 조정하세요.
  


df <- data.frame(x=c(1, 2), y=c('a', 'b'), z=c(1.1))
length(df)
length(df) <- c(2)
print(df)
# is.data.frame(df)
# as.data.frame(df)

## 객체 속성의 정의 -----
# 고유 속성(모드와 길이)이 아닌 속성에 대한 정의 및 조회

# 속성 정의
x <- numeric()
length(x) <- 5*5
print(x)

attr(x, "dim") <- c(5,5)
print(x)

# 속성 조회: 변경 불가
attr(x, "dim")
dim(x)
nrow(x)
ncol(x)
