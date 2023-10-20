# ---- Falscher Datensatz ----
csv_path <- paste(getwd(), '/data/BEV322OD3222.csv')
dat <- read.csv('./data/BEV322OD3222.csv')

str(dat)
# --- Variablentypen ---
# StichtagDatJahr: Metrisch - Diskret
# DatenstandCd   : Kategoriall - Nominal
# HerkunftCd     : Kategoriell - Nominal
# HerkunftLang   : Kategoriell - Nominal
# SexCd          : Kategoriell - Nominal
# SexLang        : Kategoriell - Nominal
# AnzBestWir     : Metrisch - Stetig
dat

unbekannt <- dat[dat$SexLang == "unbekannt",]

unbekannt_schweizer <- unbekannt[unbekannt$HerkunftCd == 1,]
unbekannt_ausländer <- unbekannt[unbekannt$HerkunftCd == 2,]
?plot
plot(x=unbekannt_schweizer$StichtagDatJahr, y=unbekannt_schweizer$AnzBestWir, type = "l",col = "red", xlab = "Jahr", ylab = "Anzahl Einwohner", 
     main = "Bevölkerung der Stadt Zürich")

matplot(unbekannt_schweizer$StichtagDatJahr, cbind(unbekannt_schweizer$AnzBestWir, unbekannt_ausländer$AnzBestWir), type = "l", lty = 1, 
        col = c("red", "blue"), xlab = "Jahr", 
        ylab = "Bevölkerungsanzahl", main = "Stadt Zürich Bevölkerung (bis 1933)")
legend("topright", legend = c("Schweizer", "Ausländer"), 
       col = c("red", "blue"), 
       lty = 1)

herk_sex_bev <- dat[dat$SexLang != "unbekannt",]

bev_schweizer <- herk_sex_bev[herk_sex_bev$HerkunftCd == 1,]
bev_ausländer <- herk_sex_bev[herk_sex_bev$HerkunftCd == 2,]

bev_schweizer_m <- bev_schweizer[bev_ausländer$SexCd == 1,]
bev_schweizer_w <- bev_schweizer[bev_ausländer$SexCd == 2,]

bev_ausländer_m <- bev_ausländer[bev_ausländer$SexCd == 1,]
bev_ausländer_w <- bev_ausländer[bev_ausländer$SexCd == 2,]

matplot(bev_schweizer_m$StichtagDatJahr, cbind(bev_schweizer_m$AnzBestWir, bev_schweizer_w$AnzBestWir, bev_ausländer_m$AnzBestWir, bev_ausländer_w$AnzBestWir), type = "l", lty = 1, 
        col = c("red", "blue", "green4", "orange"), xlab = "Jahr", 
        ylab = "Bevölkerungsanzahl", main = "Stadt Zürich Bevölkerung (ab 1933, bis 2022)")
legend("topright", legend = c("Schweizer", "Schweizerinnen", "Ausländer", "Ausländerinnen"), 
       col = c("red", "blue", "green4", "orange"), 
       lty = 1)

unbekannt_gesamt <- unbekannt_ausländer$AnzBestWir + unbekannt_schweizer$AnzBestWir
bekannt_gesamt <- bev_schweizer_m$AnzBestWir + bev_schweizer_w$AnzBestWir + bev_ausländer_m$AnzBestWir + bev_ausländer_w$AnzBestWir

gesamt_bev <- c(unbekannt_gesamt, bekannt_gesamt)

median(gesamt_bev)
mean(gesamt_bev)

plot(x=dat$StichtagDatJahr[!duplicated(dat$StichtagDatJahr)], y=gesamt_bev, type = "l",col = "red", xlab = "Jahr", ylab = "Anzahl Einwohner", 
     main = "Bevölkerung der Stadt Zürich")




# ---- Aufgabe 1 ----
data <- read.csv('./data/BEV390OD3903.csv')

str(data)
# --- Variablentypen ---
# StichtagDatJahr: Metrisch - Diskret
# AlterVSort     : Nicht beachtet
# AlterVCd       : Kategoriell - Ordinal
# AlterVKurz     : Metrisch - Diskret
# AlterV05Sort   : 
# AlterV10Cd     : 
# AlterV10Kurz   : 
# AlterV20Cd     : 
# AlterV20Kurz   : 
# SexCd          : Kategoriell - Nominal
# SexLang        : Kategoriell - Nominal
# SexKurz        : Kategoriell - Nominal
# KreisCd        : 
# KreisLang      : 
# QuarSort       : 
# QuarCd         : 
# QuarLang       : 
# HerkunftSort   : 
# HerkunftCd     : 
# HerkunftLang   : 
# AnzBestWir     : Metrisch - Diskret

man <- data[data$SexKurz == "M" & data$StichtagDatJahr == 1993,]
woman <- data[data$SexKurz == "W" & data$StichtagDatJahr == 1993,]

man_sum <- sum(man$AnzBestWir)
woman_sum <- sum(woman$AnzBestWir)

sums_1993 <- c(man_sum, woman_sum)

dat <- matrix(sums_1993, nrow=1, ncol = 2)
colnames(dat) <- c("Männer", "Frauen")

barplot(dat, main = "Bestand Männer und Frauen in der Stadt Zürich, Jahr: 1993", col = c("blue"))


