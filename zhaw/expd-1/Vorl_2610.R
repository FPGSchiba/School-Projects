# ---- Aufdgabe 1 ----
dat <- read.table('./data/imports85.txt', sep = '\t', header = T)
dat

# A
plot(dat$city.mpg, dat$hwy.mpg)
plot(dat$city.mpg, dat$ps)

#B
scatter.smooth(dat$city.mpg, dat$hwy.mpg)
scatter.smooth(dat$city.mpg, dat$ps)

#C
# city ~ hwy: Stark linear zunehmend
# city ~ ps: Mitel monoton abnehmend

# ---- Aufgabe 2 ----
load('./data/wohnungen.rda')
wg

# A
str(wg)

# Zimmer: Metrisch diskret
# Miete: Metrisch stetig
# Ort: Kategoriell nominal
# Stock: metrisch diskret
# m2: metrisch stetig

# B
less_125 <- wg[wg$m2 > 125,]
less_125

# C
barplot(table(wg$Ort))

# D
wg$Miete
boxplot(Miete ~ Ort, data = wg)

# 1: Falsch
# 2: Richtig
# 3: Richtig

# E
scatter.smooth(wg$Miete, wg$m2)
# Ja nicht stark, aber es wächst monoton
