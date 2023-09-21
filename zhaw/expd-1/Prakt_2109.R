# Dies ist unnötig ----
(5+5)*7

# Variablen ----
var1 <- 2
var1

var2 <- 2+1
var2

var3 = 4
var3

# Testing ----
3^3

a <- 2 + 3

# Funktionen ----
exp(x=a)
exp(a)


# R Funktionen ----
pi

round(pi)
round(pi, digits=3)
round(pi, 4)

# Help ----
?round

help(topic=round) # Funktionsnamen hier
help(round)

apropos(what="round")

# Spezielle Datenwerte ----
NA
NULL
NaN
NA + 1
sqrt(-2)

# Vektoren ----
vec1 <- c(1, 2, 3)

2 * vec1

round(sqrt(vec1), 2) # Very cool

vec2 <- c(4, 5, 6, 7)

vec3 <- c(5, 7, 9)

vec1 + vec2 # ACHTUN vor R eigenschaft

length(vec1)

length(vec2)

# Zahlen Volgen ----
2:6

18:51

21:7

seq(from=0, to=32, by=8)

rep(8, 9)

vec4 <- c(4, rep(9,2), seq(from=1, to=16, by=1))
vec4
?sample

sample(vec4) # Same as shuffle


# Mehr funktionen ----
sum(vec3)

min(vec2)

max(vec1)

range(vec4)

# Vektorelemente benennen ----
summary_vec3 <- c(min(vec3), max(vec3), sum(vec3))
names(summary_vec3)

names(summary_vec3) <- c("Minimum", "Maximum", "Summe")
names(summary_vec3)

# Matrixen ----
rbind(vec1, vec3)

mat2 <- matrix(1:6, nrow=2, byrow=TRUE)
mat2

mat3 <- matrix(1:6, nrow=2, byrow=FALSE)
mat3

colnames(mat2) <- c("Spalte 1", "Spalte 2", "Spalte 3")
rownames(mat2) <- c("Reihe 1", "Reihe 2")

mat2


# Rechnen Mit Matrix ----
mat2 * mat3

?matrix


# Aufgabe 1 ----
5+3
3-1
5*2
11/3
log(2)
log(-2)
va<-2
va
vb<-3
vb
vc<-va*vb
vc
va<-4
vc
vc<-va*vb
vc
vb<-'hallo'
vb
vc<-va*vb

log(15)

8^7


# Aufgabe 2 ----
1:5
v<-1:5
v
length(x=v)
help(length)
5*v
y<-c(3,8,9,100,200)
v*y
sum(v*y)
z<-seq(from=0,to=0.2,by=0.05)
names(z)
names(z)<-c("Element1","Element2","Element3","Element4","Element5")
names(z)
sum(z)
min(y)

sum(1:1000)


# Aufgabe 3 ----

v<-1:12
m1<-matrix(data=v,nrow=3,ncol=4,byrow=FALSE)
m1
help(matrix)
m2<-matrix(data=v,nrow=3)
m2 #WasistderUnterschiedzum1?
nrow(m1)
ncol(m1)
dim(m1)
dim(m2)
colnames(m1)
rownames(m1)
colnames(m1)<-c("Spalte1","Spalte2","Spalte3","Spalte4")
rownames(m1)<-c("Zeile1","Zeile2","Zeile3")
m1
2*m1
m1-m2
m1*m2
m3<-matrix(data=1:8,ncol=2,byrow=TRUE)
m1*m3

m4 <- matrix(rep(1:8, 5), nrow=8, byrow=FALSE)

rownames(m4) <- c("1ner", "2er", "3er", "4er", "5er", "6er", "7er", "8er")
colnames(m4) <- c("Zeile 1", "Zeile 2", "Zeile 3", "Zeile 4", "Zeile 5")

m4
