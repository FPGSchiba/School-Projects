# ---- Boxplot ----
munis <- c(53.9, 54.3, 54.6, 54.6, 54.9, 55.9, 55.1, 55.2, 55.5, 55.5, 55.5, 55.5, 55.6, 55.8, 51.2, 51.4, 51.9, 51.9, 52.1, 52.6, 52.9, 52.9, 52.9, 53, 53.1, 53.1, 53.3, 55.9, 56.1, 56.1, 56.2, 56.7, 56.9, 56.9, 56.9, 57.4, 57.5, 58.8, 59.6, 53.3, 53.4, 54, 54, 54.1, 54.2, 54.6, 54.6, 54.6, 54.7, 54.8, 54.8)

boxplot(munis)
stripchart(munis)

# ---- Aufgabe 1----
dat <- read.table('./data/imports85.txt', sep = '\t', header = T)
dat

# A
dat$cyl <- factor(dat$cyl, levels = c('two', 'four', 'six', 'eight', 'twelve'))

mosaicplot(table(dat$cyl, dat$wheels), las = 2, xlab = "Number of Cylinders", ylab = "Antriebsart", col = c("orange", "orange3", "tomato", "tomato3", "beige", "brown1"))

# B
barplot(table(dat$cyl, dat$wheels), ylab = "Relative Häufigkeit", legend.text = T, col = c("orange", "orange3", "tomato", "tomato3", "beige", "brown1"))

barplot(table(dat$cyl, dat$wheels), ylab = "Relative Häufigkeit", legend.text = T, col = c("orange", "orange3", "tomato", "tomato3", "beige", "brown1"), beside = T)

# C
par(mfrow=c(1,1))
boxplot(price ~ cyl, data=dat) # zivilstand = Faktor, Sequenz geordnet -> Faktor ordnet richtig ein
stripchart(price ~ cyl, data=dat, vertical=T, method='stack')


# ---- Aufgabe 2 ----
library(openxlsx)
dat <- read.xlsx('./data/datDS23t.xlsx')

# A
str(dat)
quantile(dat$anreisezeit_an_die_zhaw, na.rm = T) # 30 minuten

# B
?quantile
quantile(dat$anreisezeit_an_die_zhaw, probs = c(0.9), na.rm = T)

# C
boxplot(dat$anreisezeit_an_die_zhaw)
hist(dat$anreisezeit_an_die_zhaw)

# geht beides, es sind stetische Daten

# D
dat$programmierkenntnisse <- factor(dat$programmierkenntnisse, levels = c('nicht vorhanden', 'gering', 'mittel', 'gross'))
mosaicplot(table(dat$geschlecht, dat$programmierkenntnisse), las = 2, col=c("black", "rosybrown3", "limegreen", "green"))
t_vergleich <- prop.table(table(dat$geschlecht,dat$programmierkenntnisse), margin = 1)
t_vergleich
barplot(t_vergleich, col = c("black", "rosybrown3"), legend.text = T, beside = T, ylab = "Relative Häufigkeit")
