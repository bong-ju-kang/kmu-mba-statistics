#
# 강봉주
# R 기반의 통계 분석
# 3 주차 (10/5/2019)
# 예습용
#


## 분할 행렬 구성(partitioned matrix) -----
# 분할 행렬(partitioned matrix)의 구성은 
# 벡터나 행렬로부터 새로운 행렬을 구성하는 것

# 행렬 구성
X <-  matrix(c(1, 3, 2, 2, 2, 5, 6, 4, 3, 10), nrow=5)
print(X)
dim(X)
cy <- rnorm(5, 0, 1)
ry <- runif(2)

# 열 별 결합
XwithCY <- cbind(X, cy)
print(XwithCY)
is.matrix(XwithCY)

# 행 별 결합
XbelowRY <- rbind(X, ry)
print(XbelowRY)

# 정상적인 방법
dim(ry) <- c(1, 2)
XbelowRY <- rbind(X, ry)

# 자동 차원 조절
cbind(1, X)
rbind(1, X)
cbind(1, 1, X)

# 예제:
# X <-  matrix(c(1, 3, 2, 2, 2, 5, 6, 4, 3, 10), nrow=5) 에서
# 1) 1 값이 모든 행에 앞에 추가한 행렬을 구하세요.






## 연결 함수
# 차원과 무관

# 행렬 생성
X <-  matrix(c(1, 3, 2, 2, 2, 5, 6, 4, 3, 10), nrow=5)
print(X)
dim(X)
as.vector(X) # 열 우선으로 벡터를 구성
dim(as.vector(X))

# 연결함수 적용
c(X, X) # 열 우선
is.matrix(c(X, X))

## 요인벡터를 이용한 빈도표 생성 -----
# 요인벡터는 수준에 따라 그룹화를 함함

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

# 데이터 값의 4분위수에 해당 하는 값을 구성(버킷 구성): 
# 범주 변수로 재탄생
qtiles <- quantile(income, probs=seq(0,1, 0.25))
print(qtiles)

incomecut <- cut(income, breaks=qtiles, include.lowest=T)
print(incomecut)
is.factor(incomecut)

# 빈도표 구성 
# incomef <- factor(incomecut)
table(incomef) # 빈도가 비슷

# 2원 빈도표 구성
table(statef, incomef)

# 원 데이터로부터 구성: 범주 변수인 경우는 동일
table(state, incomef)

# 그림으로 확인
plot(table(statef, incomef))
plot(table(state, incomef))


# 예제:
# 다음의 데이터에서     
# set.seed(123)
# x <- sample(c('a', 'b', 'c'), 10, replace=T)
# y <- rnorm(10)
# z <- sample(letters, 10, replace=T)
# 1) x에 대한 요인 벡터를 구성하세요.
# 2) x의 값별로 y의 평균을 구하세요.
# 3) z에 대한 요인 벡터를 구성하세요.
# 4) x*z 별로 빈도표를 구성하세요.






#
# 리스트와 데이터프레임
#

## 리스트 -----
# 리스트(list)는 객체들을 순서대로 모아 놓은 모임이다.
# 각 객체들은 구성원(component)이라 한다.

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
lst[3] # 여전히 리스트

class(lst[[3]])
class(lst[3])

# 구성원에서 특정 위치 값 가져오기
lst[[1]][1] 
lst[[2]][1,2]
lst$x[1]

# 리스트 수정, 리스트 연결

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
print(clist)

# 예제:
# 1) rnorm(10), sample(c('a', 'b', 'c'), 10, replace=T)의 
# 구성원으로 된  리스트 객체를 생성하세요.
# 2) 구성원에 c('x', 'level') 이름을 부여하세요.



## 데이터프레임 -----
# 1) 구성원은 반드시 벡터, 요인, 숫자행렬, 리스트 또는 다른 데이터프레임
# 2) 행렬, 리스트 그리고 데이터프레임은 각각 갖고 있는 수만큼의 변수가 생성
# 3) 문자벡터는 강제로 요인으로 저장
# 4) 구성원의 길이는 같아야 함

# [데이터프레임 생성]

# 태그 없는 데이터프레임
df <- data.frame(rnorm(100), runif(100), 
                 sample(c('A', 'B', 'C', 'D'), 100, replace=T))
str(df)
names(df)
head(df)

# 태그 있는 데이터프레임
df <- data.frame(a=rnorm(100), b=runif(100), 
                 c=sample(c('A','B', 'C', 'D'), 100, replace=T))
str(df)
mode(df)
class(df)
head(df)
tail(df)

# 각 구성원은 참조하는 방법은 리스트와 동일. 
# 각 구성원도 데이터 프레임 !!!
df["a"][1:5,] # df['a'] 도 데이터 프레임 

mode(df['a'])
class(df['a'])
mode(df[['a']])

df[1:5, 'a'] # 하나의 데이터 프레임에서
df[, 'a'] # 하나의 컬럼
df[1:5,] # 복수의 행
df[df$a > 1,] # 인덱스 벡터 이용

# 행의 개수가 일치해야 함
data.frame(c(1, 2, 3), c(1)) # 자동으로 연장
data.frame(c(1, 2, 3), c(1, 2, 3, 4)) # 행 개수 오류 발생
data.frame(c(1, 2, 3), c(1, 2, 3, 4, 5, 6)) # 작은 벡터의 배수

# 예제:
# 다음의 데이터에서 
# df <- data.frame(a=rnorm(100), b=runif(100), 
#                  c=sample(c('A','B', 'C', 'D'), 100, replace=T))
# 1) a, c 열로 구성된 데이터 프레임을 구성하세요.
# 2) c열의 'C' 값으로만 구성된 데이터 프레임을 구성하세요.



# [attach(), detach()]

# 데이터프레임 생성
df <- data.frame(a=rnorm(10), b=runif(10), 
                 c=sample(c('A','B', 'C', 'D'), 10, replace=T))

# 탐색 경로: attched 패키지와 객체들
search()
class(.GlobalEnv)

# 탐색 경로에 있는 객체이름 목록
ls(.GlobalEnv)

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


# [파일로부터 데이터 읽기]

# 파일 생성
tempdir()
ff <- tempfile(fileext = '.data')
cat("
1 2 3
4 5 6
7.1 2 3
", file=ff)

# cat('1 2 3', '4 5 6', '7.1  2 3', file=ff, sep='\n')

# 디폴트는 공백 또는 탭으로 구분(sep=''), 
# 첫번째 줄을 변수명으로 인식하지 않기(header=F)
df <- read.table(ff)
str(df)

# 변수명이 있는 경우
cat("
x y z
1 2 3
4 5 6
7.1 2 3
", file=ff)

# cat('x y z', '1 2 3', '4 5 6', '7.1  2 3', file=ff, sep='\n')
df <- read.table(ff, header=T)
str(df)

# 구분자가 다른 경우
cat("
x, y, z
1, 2, 3
4, 5, 6
7.1,  2, 3
", file=ff)
# cat('x, y, z', '1, 2, 3', '4, 5, 6', '7.1,  2, 3',
#     file=ff, sep='\n')
df <- read.table(ff, header=T, sep=',')
str(df)


# URL로부터 데이터 읽기
url <- c("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
df <- read.table(url)
str(df)

# 디폴트 변수명
names(df)

# 변수명 새로 주기
names(df) <- c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE",
               "DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV")

# 데이터 구조 탐색
str(df)

# 데이터 내용 보기
head(df, 3)
tail(df)

# 하나의 긴 배열로 데이터 읽기
dataArray  <- scan("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")

# 데이터 모양 정하고 데이터 프레임 생성하기
dim(dataArray) <- c(506, 14)
df <- as.data.frame(dataArray)

# 데이터 구조 탐색
str(df)

# .csv 파일 읽기
url <- c('https://github.com/bong-ju-kang/kmu-mba-statistics/raw/master/Data/bank.csv') 
df <- read.csv(url)

# library(data.table)
# df <- fread("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
# names(df) <- tolower(c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV"))
# str(df)

# 예제
# 1) github의 
# https://github.com/bong-ju-kang/kmu-mba-statistics/tree/master/Data
# 에 있는 모든 데이터를 읽어서 구조를 살펴보세요.




# [내장된 데이터 읽기]
# datasets 패키지에 내장된 데이터 목록
data()
dlist <- data(package='datasets')

# 리스트의 구조
str(dlist)
str(dlist$results)

# 데이터목록 5개만 출력
head(dlist$results, 5)

# 데이터 바로 이용하기
str(BJsales)
plot(BJsales)

# 다른 패키지에서 제공되는 데이터 목록 확인 및 로딩
# install.packages('ISLR')
library(ISLR)
head(data(package='ISLR')$results, 5) 

# 데이터 바로 이용하기
str(Auto)

# 예제
# 1) ISLR 패키지의 데이터 목록의 구성 항목은 무엇으로 구성되었나요?
# 2) 총 수록된 데이터의 개수는?
    
    
