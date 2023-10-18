# ---- Aufgabe 1 ----
csv_path <- paste(getwd(), '/data/BEV322OD3222.csv')
dat <- read.csv('./data/BEV322OD3222.csv')

str(dat)
# --- Variablentypen ---
# StichtagDatJahr: TBD
# DatenstandCd   : TBD
# HerkunftCd     : TBD
# HerkunftLang   : TBD
# SexCd          : TBD
# SexLang        : TBD
# AnzBestWir     : TBD
dat

unbekannt <- dat[dat$SexLang == "unbekannt",]

unbekannt_schweizer <- unbekannt[unbekannt$HerkunftCd == 1,]
unbekannt_ausländer <- unbekannt[unbekannt$HerkunftCd == 2,]
?plot
plot(x=unbekannt_schweizer$StichtagDatJahr, y=unbekannt_schweizer$AnzBestWir, type = "o",col = "red", xlab = "Jahr", ylab = "Anzahl Einwohner", 
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



