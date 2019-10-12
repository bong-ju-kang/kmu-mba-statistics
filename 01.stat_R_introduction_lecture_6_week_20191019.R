#
# 강봉주
# R 기반의 통계 분석
# 6 주차 (10/19/2019)
# 
#


#
# 그룹화, 반복, 조건 실행
#

## 그룹화 -----
# 중괄호{} 안에 표현

# 그룹 표현의 결과
gexpr <- {
    x <- 1
    y <- 2
    x == y
}
class(gexpr) # 제일 마지막의 결과가 전체 표현식의 결과

gexpr <- {
    x <- 1
    y <- 2
    x == y
    z <- c(1, 2, 3)
}
class(gexpr)

# 그룹 표현의 예
add <- function(x, y){
    z <- x+y
    return(z)
}
add(1, 2)

# 예제
# 다음의 그룹 표현식의 결과는?
# {
#     dir()
#     getwd()
# }




## 제어문(control statement) -----

# 논리 연산자
# Operator	Description
# !	Logical NOT
# &	Element-wise logical AND
# &&	Logical AND
# |	Element-wise logical OR
# ||	Logical OR


# [if 문]
# 기본 형식
# if (expr_1) expr_2 else expr_3

if (2 %in% c(1, 2,3)) print(TRUE) else print(FALSE)
# %in%: 회원연산자(membership operator)

# 단락(short-circuit)
if (4 %in% c(1, 2,3) && 3 %in% c(1,2,3)) 
    print(TRUE) else print(FALSE)

## 반복 실행: for, repeat, while

# 기본 형식
for (i in 1:3){
  print(i)
  if (i==3) print('***')
} 
print(i)

# 기본형식
i=2
while(i < 3){
  print('***')
  i = i+1
  # i++
  # break
} 
print(i)



# 예제
# ISLR패키지의 Auto 데이터로부터 숫자형 변수 이름만 있는 
# num_list를 생성하세요.


#
# 함수 만들기
#

## 단순 예

# 표본분산 구하기
sampvar <- function(x){
    x <- x[!is.na(x)]
    devsum <- sum((x - mean(x))^2)
    return(devsum/(length(x)-1))
}

# 함수 결과 확인
sampvar(c(1, 2, 3))
# var(c(1, 2, 3))
sampvar(c(1, 2, 3, NA))

# 예제
# 1) 표본 표준 편차를 구하는 함수를 작성하세요.
# 단, 결측값 제거 여부를 인자로 처리하세요.
# 2) c(1, 2, 3, 4)의 표본 표준편차 값은?


sampsd <- function(x, is.na=F) {
    if (is.na == T) 
        x <- x[!is.na(x)]
    devsum <- sum((x - mean(x))^2)
    return(sqrt(devsum/(length(x)-1)))
}
sampsd(c(1, 2, 3, 4))
sampsd(c(1, 2, 3, 4, NA), is.na=T)
sd(c(1, 2, 3, 4))


## 이항 연산자의 정의 -----
# %anything%: 가운데 어떤 문자도 사용 가능

# 예: 벡터의 내적
"%i%" <- function(x, y){
    if (is.vector(x) && is.vector(y)){
        if (length(x)==length(y)){
            for (i in 1:length(x)){
                return(sum(x*y))
            }
        }
        else return(print('길이가 틀립니다.'))
    }
    else return(print('벡터가 아닙니다.'))
}

c(1, 2) %i% c(2, 3)
c(1, 2, 3) %i% c(2, 3)


# 예제
# 1) 행렬의 곱을 계산하는 이항연산 함수를 작성하세요.
# %m%
# 2) matrix(c(1, 2, 3, 4), nrow=2), 
# matrix(c(4, 3, 2, 1),nrow=2)의 곱을 계산하세요.

#
# 그래픽 프로시저
#

## 그래프 인자값 확인
# R은 그래프를 생성하기 위한 다양한 전역 인자값(graphical parameter)을 
# 갖고 있는데, 이는 par 함수를 이용하여 확인할 수 있다.

head(par(), 100)
length(par()) # 총 72개
# [1] 72

# 예제:
# 1)그래프 인자 값 중에 cex, lty의 기본(default)값을 구하세요.



### plot() -----
# plot() 함수는 일반(generic) 함수이다. 
# 즉, 다형성(polymorphism) 용도로 제작된 함수이다. 

# 화일 저장 경로 저장
graph_path = paste0(getwd(), '/image')


pngfile <- paste0(graph_path, '/그림 18.8.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)
# x값만 존재
# x축은 일련번호, y축은 데이터값 
plot(x=c(3:10))
dev.off()

# x, y값 존재
pngfile <- paste0(graph_path, '/그림 18.9.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)
set.seed(1234)
plot(c(1:10), rnorm(10))
dev.off()


# x가 요인인 경우
pngfile <- paste0(graph_path, '/그림 18.10.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

set.seed(1234)
plot(factor(sample(c('A', 'B', 'C'), 10, replace = T)))

dev.off()

# x가 요인이고 y가 값이 있는 경우
pngfile <- paste0(graph_path, '/그림 18.11.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

# 요인의 수준별 상자그림
set.seed(1234)
plot(factor(sample(c('A', 'B', 'C'), 10, replace = T)), 1:10)

# set.seed(1234)
# boxplot(1:10~sample(c('A', 'B', 'C'), 10, replace = T))

dev.off()

# 예제
# 다음과 같이 데이터를 구성하였을 때, 
# set.seed(1234)
# x <- factor(sample(c('A', 'B', 'C'), 10, replace = T))
# y <- 1:10
# 1) x의 수준 별로 중간값을 구하고 그림으로 표현하세요.



### 다변량 데이터 그림 -----
# pairs(), coplot(), ...

# 데이터 생성
df <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
names(df) <- tolower(c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE",
                     "DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV"))

# 산점도 행렬
pngfile <- paste0(graph_path, '/그림 18.12.png')
png(filename =pngfile, width=7, height = 7, units = 'in', res=1000)

pairs(df[c("rm", "lstat", "medv")])

dev.off()

# 예제
# 1) [HOUSING] 데이터에서 age, nox, medv 에 대한 산점도를 그리세요.
# 2) 변수간의 관련성이 있는 지 확인하세요.



# 조건부 산점도: conditioning plot
pngfile <- paste0(graph_path, '/그림 18.13.png')
png(filename =pngfile, width=6, height = 6, units = 'in', res=1000)

# 조건부 변수의 분포
table(df$chas)

# 원 데이터 
attach(df)
coplot(medv ~ rm | chas, given.values = c(0,1))
detach(df)

# 요인 데이터로 변환 후 
attach(df)
coplot(medv ~ rm | as.factor(chas), given.values = c('0','1'))
detach(df)

dev.off()


# 예제
# 1) [HOUSING] 데이터에서 age 변수의 값을 
# 중간값 보다 작은 경우와 큰 경우로 나눈다.
# 2) 나누어진 2개의 집단 별로 medv와 rm의 산점도를 그리세요.



med <- median(df$age)
level <- ifelse(df$age < med, '< Med', '>=Med')
coplot(df$medv ~ df$rm | level, given.values=unique(level))
