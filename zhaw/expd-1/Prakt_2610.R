# ---- Aufgabe 1 ----
library(readxl)
dat<-read_excel("./data/selfOutpu.xlsx")

# A
plot(handspanne ~ koerpergroesse, data = dat)

# B
plot(handspanne ~ koerpergroesse, data = dat, ylab = "Handspanne [cm]", xlab = "Körpergrösse [cm]", main = "Handspanne vs Körpergrösse", asp=1)

scatter.smooth(dat$koerpergroesse, dat$handspanne)

# Nicht linear monoton steigend

# C
dat
dat[dat$geschlecht == "weiblich", "geschlechtCol"] <- "red4"
dat[dat$geschlecht == "männlich", "geschlechtCol"] <- "seagreen4"
str(dat)

# D
dat$haarfarbe <- factor(dat$haarfarbe, levels = c("braun", "schwarz", "blond"))

plot(dat$haarfarbe)

# E
dat$geschlecht <- factor(dat$geschlecht, levels = c("männlich", "weiblich"))

dat$geschlecht <- as.numeric(dat$geschlecht)
dat$haarfarbe <- as.numeric(dat$haarfarbe)

plot(geschlecht ~ haarfarbe, data = dat, pch = dat$haarfarbe)
legend("topright", title="Legende", legend = c("Haarfarbe", "Geschlecht"), pch = dat$haarfarbe)


# ---- Aufgabe 2 ----
# A
dat <- read.csv('./data/diamanten.csv', sep = ";")
dat

hist(dat$price)
# Rechtsschief

# B
abline(v=quantile(dat$price,probs=c(0.25,0.5, 0.75)),lty=2)

# C
dat$cut <- factor(dat$cut, levels = c("Fair","Good","VeryGood","Premium","Ideal"), ordered = T)
barplot(table(dat$cut))

