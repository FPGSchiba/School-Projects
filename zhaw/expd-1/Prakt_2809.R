# ---- Datentypen ----
typeof(5)
typeof(5L) # Integer

pi
typeof(pi)

mode(pi) # <- Nicht wichtig - Vergessen

typeof(1:12)

typeof("Zeichenkette")

typeof(TRUE)

namen <- c("Urs", "Anna", "Max", "Pia", "Maaike")
letters

length(letters)
LETTERS

farben <- c('rot', 'blau', 'gelb', 'rot')
farben

typeof(farben)

# Character -> Faktoren
farben_kat <- as.factor(farben)
farben_kat

typeof(farben_kat)
levels(farben_kat)

# Faktor -> character
farben_char <- as.character(farben_kat)
farben_char

typeof(farben_char)

# Nummern
Nummern <- c("7", '12', '8', '1')
as.numeric(Nummern)

as.character(1:10)

# Logische Datentypen
x <- c(TRUE, FALSE, TRUE, TRUE)
x


a <- c(3.1, 5.0, -0.7, 0.9, 1.7)
a <= 2


(a > 2) & (a < 5)

# Data Frames
dat <- data.frame(
  name=c("Urs", 'Anna', 'Max'),
  punkte=c(3, 5, 7),
  weiblich=c(FALSE, TRUE, FALSE))
dat

head(dat, n=2) # Erste 2 Zeilen (Default: 6)

dim(dat)

colnames(dat)

str(dat)

dat$name

max(dat$punkte)

# ---- Daten einlesen ----
getwd() # Working Directory

dat_path <- paste(getwd(), '/data/datDS23t_raw.rds', sep='')
dat_path
dat <- readRDS(dat_path)
dat

tab <- table(dat$Q00_Programmierkenntnisse)
barplot(tab, main = 'Programmierkentnisse', ylab='Absolute Häufigkeit')

# ---- Aufgabe 1 ----
w<-c(1:5,2) # Ordinal
typeof(w)
x<-c(6:13)/3 # Stetig
typeof(x)
y<-c(TRUE,FALSE,TRUE,TRUE) # Ordinal
typeof(y)
z<-c("Marie","Betty","Peter","Peter") # Nominal
typeof(z)
z_f<-as.factor(z) # Ordinal
typeof(z_f)

u<-(w<=2)
u
mode(u)
as.numeric(u)
as.character(u)
as.character(z_f)
as.numeric(z_f)
as.numeric(z)
unique(z_f)
unique(w)
?unique

# ---- Aufgabe 2 ----
# A
?seq
seq(95, -5, -5)

sort(rep(letters, 2))
counter<-0
num_counter<-0

rep(1:10, 1:10)

?rep

rep(1:4, c(2,1,2,1))

# B

matrix(seq(3, 75, 3), ncol = 5)

# ---- Aufgabe 3 ----
# A
?data.frame
dat <- data.frame(
  Name=c('Ruedi', 'Hans', 'Peter', 'Stefan', 'Julia', 'Maria'),
  Alter=c(27, 34, 21, 25, 29, 23),
  Note=c(5.0, 6.0, 5.5, 4.0, 3.5, 5.0),
  Studium=c(FALSE, TRUE, TRUE, TRUE, FALSE, TRUE)
)
dat
# B
nrow(dat)
dim(dat)

# C
# - Character
# - double
# - logical

pie(table(dat$Studium), main = 'Studium')



# ---- Aufgabe 4 ----
dat_path <- paste(getwd(), '/data/datDS23t_raw.rds', sep='')
dat_path
dat <- readRDS(dat_path)
dat

# B
str(dat)

nrow(dat)
colnames(dat)
head(dat)
dim(dat)
ncol(dat)

# C
# Alter - Diskret
# Geschlecht - Ordinal
# Haarfarbe - Ordinal
# Augenfarbe - Ordinal
# Körpergrösse - Stetig
# Sport - Stetig ? Diskret
# Handspanne - Stetig
# Geschwister - Diskret
# Postleitzahl - Ordinal
# Schlafzimmer - Ordinal
# Ausbildung - Ordinal
# Programmierkenntnisse - Ordinal
# Schuhgrösse - Diskret
# SV - Ordinal
# Anreisezeit - Stetig

str(dat)

# D
tab <- table(dat$Q00_Haarfarbe)
table(dat$Q00_Haarfarbe)
table(dat$Q00_Haarfarbe) / length(dat$Q00_Haarfarbe)

# E
colors()

barplot(tab, col='skyblue3')

# F
tab <- table(dat$Q00_Schlafzimmer)

?barplot
barplot(tab, col = 'skyblue3', main = 'Schlafzimmer Stockwerk', las=2, ylab='Anzahl')

# G
vec_plz <- sort(as.numeric(dat$Q00_Postleitzahl))
vec_plz
tab <- table(vec_plz)
barplot(tab, col = 'skyblue3', ylab = 'Anzahl', cex.names = 0.7)
