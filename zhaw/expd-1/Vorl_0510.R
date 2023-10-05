faithful

#1.Einteilungin"5er"Klassen
# von 40 bis 100 Einteilung in 5er Klassen
# 5 ist die Bin breite (also Klassen breite oder Intervall)
wartezeit<-cut(faithful$waiting,breaks=seq(40,100,5)) # Cut ist nützlich

#2.Häufigkeitin"5er"Klassen
table(wartezeit)

#3. Aufzeichnen
hist(faithful$waiting)

# Relative Häufigkeit -> Fläche des Histograms = 1
# Bin breite * Höhe für alle Balken muss 1 ergeben.
# Relative häufigkeit = Bin breite * Höhe (Density)
hist(faithful$waiting,freq=FALSE) 

# Darstellungsoptionen
hist(faithful$waiting,labels=TRUE,xlab="Wartezeit[min]", ylab="AbsoluteHäufigkeit",main="Old-Faithful-Geisir", col="lightblue",ylim=c(0,60))

# Breite der Bins ändern
hist(faithful$waiting,breaks=seq(40,100,10))

feiertage_ost <- c(20, 26, 21, 23, 21, 22, 22, 20, 20, 20, 20, 21, 24)
feiertage_west <- c(25, 24, 21, 29, 21, 21, 22, 22, 20, 25, 22, 27, 21, 25, 23)

plot(ecdf(feiertage_ost), main="Feiertage Osteuropa")
plot(ecdf(feiertage_west), main="Feiertage Westeuropa")


income <- c(125000, 60000, rep(24000, 2), rep(15000, 3), 12000, rep(100000, 7))

mean(income)
median(income)



dat_path <- paste(getwd(), '/data/datDS23t_raw.rds', sep='')
dat_path
dat <- readRDS(dat_path)

dat$Q00_Anreisezeit_an_die_ZHAW


hist(dat$Q00_Anreisezeit_an_die_ZHAW,
     labels=TRUE,
     xlab="Anreisezeit[min]",
     ylab="AbsoluteHäufigkeit",
     main="Anreisezeit an die ZHAW",
     col="lightblue",
     ylim=c(0,7))
abline(v = mean(dat$Q00_Anreisezeit_an_die_ZHAW, na.rm = TRUE), col='red', lwd = 3)
abline(v=median(dat$Q00_Anreisezeit_an_die_ZHAW, na.rm=TRUE), col='blue', lwd=3)


