#
# 강봉주
# R 기반의 통계 분석
# 2 주차
#

## 객체의 클래스 -----
# R: 객체 지향 언어, s3($), s4(@), ...
# 객체: 메모리상에 존재하는 어떤 것(thing, person, ...)
# 클래스: 주어진 객체가 변수이면 데이터 형이고
# 데이터이면 데이터 구조를 의미

# 숫자 정수형
x <- 1:10
mode(x)
# storage.mode(x)
class(x)

# 숫자 실수형
x <- c(1.1, 2.1)
mode(x)
class(x)

# 문자형
letters
mode(letters)
class(letters)

# 리스트
x <- list(A=c(1, 2, 3), B=c("ab", "bc", "cd"))
mode(x)
class(x) 
str(x)

# s3 class: $ (컴포넌트 가져오는 방법)
x$A
x$B
class(x$A)
class(x$B)
x[[1]]
class(x[[1]])

x <- list(c(1, 2, 3), c("ab", "bc", "cd"))
x[[1]]
class(x[1])

# 데이터프레임
df <- as.data.frame(x)
print(df)
mode(df)
class(df)

# 클래스의 제거
udf <- unclass(df)
class(udf)

data.frame(a=c(1, 2,3), b=rnorm(3))

#
# 순서, 무순서 요인
#

# 요인(factor)은 같은 길이를 갖는 다른 벡터의 
# 이산 분류(discrete classification)를 특정하기 위한 벡터이다. 

## 예를 통한 이해 -----

# 숫자 데이터: 예를 들어 설문조사의 특정 문항의 5점 척도 응답 
x <- c(1, 2, 3, 4, 3, 4, 5)
y <- factor(x)
print(y)

mode(y) # 요인은 숫자
class(y)
levels(y) # 서로 다른 값


# 그래프로 확인
plot(x)
plot(y)

# 범주 데이터
# 호주의 행정구역 데이터
state <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
"qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
"sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
"sa", "act", "nsw", "vic", "vic", "act")

length(state)
statef <- factor(state)
print(statef)
plot(statef)

mode(statef) # 고유 속성은 숫자
length(statef) # 길이는 원래 데이터와 동일
class(statef)

levels(statef) # 알파벳 순으로 정렬
is.ordered(statef) # 순서가 있는 인자인지 확인
ordered(state) # 순서가 있는 경우

# 순서가 있는 인자
status <- c("Lo", "Hi", "Med", "Med", "Hi")
statusf <- factor(status)
table(statusf)

ordered.status <- factor(status, 
                         levels=c("Lo", "Med", "Hi"), 
                         ordered=TRUE)
unordered.status <- factor(status, 
                         levels=c("Lo", "Med", "Hi"))

# 화면 상에 순서가 출력됨
print(ordered.status)
plot(ordered.status)
plot(statusf)

# 값들을 비교할 수가 있음
ordered.status[1] > ordered.status[3] 

# 순서는 정해지지만 화면 상에 순서 구분은 없음
print(unordered.status)

# 값들을 비교할 수가 없음
unordered.status[1] > unordered.status[3] 

# 순서대로 출력
table(ordered.status)
table(unordered.status)

# 알파벳 순서대로 출력
table(status)

## tapply(), 비정형 배열(ragged array) -----
# 인자와 같은 크기의 수입 데이터
incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
59, 46, 58, 43)
length(incomes)
length(statef)

st <- c('a', 'a', 'a', 'b', 'b')
value <- c(2, 3, 1, 2, 6)

stf <- factor(st)
tapply(value, st, mean)

# 수입 데이터를 인자 별로 분류하고 각 인자 별 평균을 구한다.
# tapply: 불 규칙 배열을 갖는 요인의 각 수준 값에 대하여 함수 적용
incmeans <- tapply(incomes, statef, mean)
print(incmeans, digits=4)

# 표본 표준편차를 구한다.
stdError <- function(x) sqrt(var(x))
incster <- tapply(incomes, statef, stdError)
print(incster, digits=4)

# 기존 함수 이용
tapply(incomes, statef, sd)

# 예제
# 1) statef 요인에 대하여 incomes의 수준 별 합을 구하면?



tapply(incomes, statef, sum)


#
# 배열과 행렬
#

## 배열 -----
# 배열은 대괄호([]) 내의 첨자(subscript)를 이용하여 
# 데이터를 정의한 것이다.

x <- seq(1, 24, 1) # 여기까지는 벡터
is.array(x)
is.vector(x)

dim(x) <- c(24) # 크기를 갖으면 배열
is.array(x)

dim(x) <- c(3,8)
print(x) # 열 우선으로 표현

tx <- t(x) # 행과 열을 전치하고자 하는 경우 t(A[i,j])=A[j,i]
print(tx)
is.matrix(tx)

dim(x) <- c(2, 4, 3)
x[,,1]
is.matrix(x)

# 행렬은 2차원 배열
matrix(x, nrow=3, ncol=8, byrow=TRUE)
matrix(x, nrow=3, ncol=8)

x <- array(x, dim=c(3, 4, 2)) # array 함수 이용
print(x)
is.matrix(x) # 차원=2인 경우만 행렬

# 예제
# 1) x <- seq(1, 24, 1) 벡터를 이용하여 
# 행 우선의 8*3 행렬을 구성하면?



x <- seq(1, 24, 1)
matrix(x, 8, 3, byrow = T)

## 배열 색인, 배열 구역(subsection) -----
x <- 1:12
dim(x) <- c(3, 4)
print(x)

# [] 이용하여 원소 값 직접 찾기: 첨자(subscript) 이용
x[1,2]
x[1:2,] # 2x4 배열
x[c(1, 2), ]
dim(x[1:2,])

x[1,] # 1x4 배열, 벡터
dim(x[1,]) # 벡터는 차원이 없음
is.vector(x[1,])
is.array(x[1,])

## 색인 행렬을 이용한 특정 구역 찾기
x <- array(1:20, dim=c(4,5))
print(x)

i <- array(c(1:3, 3:1), dim=c(3,2)) # 특정 구역 정의
print(i)
x[i]

x[i] <- 0 # 특정 구역의 값을 바꾸기
print(x)

# 예제
# 1) x <- array(1:20, dim=c(4,5)) 에서
# 17, 14, 11 값을 가져오기 위한 인덱스 행렬은?



x <- array(1:20, dim=c(4,5))
index <- matrix(c(1, 5, 2, 4, 3, 3), nrow=3, byrow = T)
# index <- matrix(c(seq(1, 3, 1), seq(5, 3, -1)), nrow=3)
x[index]


## 배열 외적 -----
# 모든 i, j에 대하여, z[i,j] = x[i] * y[j] 
x <- array(1:3)
y <- array(4:6)

z <- x %o% y # 외적
# 결과 확인
z[2, 3]
x[2] * y[3]

outer(x, y, "*") # 함수 이용
outer(x, y, '+') # 더하기 연산자 적용

x %*% t(y) # 열 배열과 행 배열의 곱: 외적과 동일

# x %*% y # 내적
# crossprod(x, y)
# sum(x[i] * y[i])

# 외적의 활용 예
# x, y의 모든 가능한 조합에서의 함수값 구하기 
x <- -5:5
y <- -10:10

f <- function(x,y) return(x^2+y^2)

# x는 행을 구성하고 y는 열을 구성
z <- outer(x, y, f)

# length(x)*length(y) 행렬이 구성됨
print(z, digits=4)
dim(z)

# z값을 x, y의 각 위치에서 표현
nrow(z)
ncol(z)
contour(x, y, z)
# contour(z)

# nrow(z)와 length(x)가 맞지 않으면 차원 오류 발생
contour(c(1, 2,3), y, z)

# 예제;
# x <- y <- -10:10 에 대하여
# 1) 1/(1+exp(0.5+0.5*x-0.7*y)) 의 그래프를 생성하세요.



x <- y <- -10:10
z <- outer(x, y, function(x, y) 1/(1+exp(0.5+0.5*x-0.7*y)))
contour(x, y, z, nlevels=20)

## 배열의 전치 -----
# t(x)[i,j]=x[j,i]
x = array(1:10, dim=c(2,5))
print(x)
t(x)

# 확인
# tx <- t(x)
# tx[1,2]
t(x)[1, 2]
x[2, 1]


## 행렬 기반의 함수 -----
# [행렬 곱]

# 행 우선으로 행렬 생성
A = matrix(1:9, nrow=3, ncol=3, byrow=T)
B = matrix(1:9, nrow=3, ncol=3, byrow=T)
x = 1:3

print(A)
print(B)
print(A * B) # 원소별 곱: A[i,j]*B[i,j]
print(A %*% B) # 행렬 곱: C[i,j]=sum_k(A[i,k]*B[k,j])

t(x) %*% A %*% x

# 행렬곱이 되기 위한 조건
dim(t(x)) # 1*3
dim(A) # 3*3
length(x) # 3*1

diag(1:3) #  벡터의 값을 대각 원소의 값으로 갖는 행렬 출력
diag(A) # 기존 행렬의 대각 원소의 값을 벡터로 출력 
is.vector(diag(A))

diag(matrix(1:12, nrow=3)) # 정방행렬이 아니어도 됨

# 예제:
# 1) x <- rep(c(1, 2, 3), times=3) 에 대하여 
# 3*3 행렬 A를 구성하세요.
# 2) t(A), A의 행렬 곱을 구하세요.


x <- rep(c(1, 2, 3), times=3)
A <- matrix(x, nrow=3)
t(A) %*% A  
