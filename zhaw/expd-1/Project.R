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
# AlterVSort     : Metrisch - Diskret
# AlterVCd       : Metrisch - Diskret
# AlterVKurz     : Metrisch - Diskret
# AlterV05Sort   : Kategoriell - Ordinal
# AlterV10Cd     : Kategoriell - Ordinal
# AlterV10Kurz   : Kategoriell - Ordinal
# AlterV20Cd     : Kategoriell - Ordinal
# AlterV20Kurz   : Kategoriell - Ordinal
# SexCd          : Kategoriell - Nominal
# SexLang        : Kategoriell - Nominal
# SexKurz        : Kategoriell - Nominal
# KreisCd        : Kategoriell - Nominal
# KreisLang      : Kategoriell - Nominal
# QuarSort       : Kategoriell - Nominal
# QuarCd         : Kategoriell - Nominal
# QuarLang       : Kategoriell - Nominal
# HerkunftSort   : Kategoriell - Nominal
# HerkunftCd     : Kategoriell - Nominal
# HerkunftLang   : Kategoriell - Nominal
# AnzBestWir     : Metrisch - Diskret


# Wachstum der Bevölkerung der Stadt Zürich im Kreis 1
kreis_1 <- data[data$KreisLang == "Kreis 1",]

kreis_1_years <- unique(kreis_1[,"StichtagDatJahr"])
kreis_1_years

year <- c()
bev <- c()

kreis_1_bev <- data.frame(year=integer(), bev=integer())

for (year in kreis_1_years){
  kreis_1_bev[nrow(kreis_1_bev) + 1,] <- c(year, sum(kreis_1[kreis_1$StichtagDatJahr == year, "AnzBestWir"]))
}

kreis_1_bev

mean(kreis_1_bev$bev, na.rm = T) # Mean: 5717.2

matplot(kreis_1_bev$year, cbind(kreis_1_bev$bev), type = "l", lty = 1, 
        col = c("red"), xlab = "Jahr", 
        ylab = "Bevölkerungsanzahl", main = "Stadt Zürich Bevölkerung Kreis 1")


# Anzahl Minderjähriger pro Kreis in 2022
kreis_1 <- sum(data[data$KreisLang == "Kreis 1" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_2 <- sum(data[data$KreisLang == "Kreis 2" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_3 <- sum(data[data$KreisLang == "Kreis 3" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_4 <- sum(data[data$KreisLang == "Kreis 4" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_5 <- sum(data[data$KreisLang == "Kreis 5" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_6 <- sum(data[data$KreisLang == "Kreis 6" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_7 <- sum(data[data$KreisLang == "Kreis 7" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_8 <- sum(data[data$KreisLang == "Kreis 8" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_9 <- sum(data[data$KreisLang == "Kreis 9" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_10 <- sum(data[data$KreisLang == "Kreis 10" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_11 <- sum(data[data$KreisLang == "Kreis 11" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])
kreis_12 <- sum(data[data$KreisLang == "Kreis 12" & data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19", "AnzBestWir"])

?table
kreise <- c(rep("Kreis 1", kreis_1), rep("Kreis 2", kreis_2), rep("Kreis 3", kreis_3), rep("Kreis 4", kreis_4), rep("Kreis 5", kreis_5), rep("Kreis 6", kreis_6), rep("Kreis 7", kreis_7), rep("Kreis 8", kreis_8), rep("Kreis 9", kreis_9), rep("Kreis 10", kreis_10), rep("Kreis 11", kreis_11), rep("Kreis 12", kreis_12))
kreise_fact <- factor(kreise, levels = c("Kreis 1", "Kreis 2", "Kreis 3", "Kreis 4", "Kreis 5", "Kreis 6", "Kreis 7", "Kreis 8", "Kreis 9", "Kreis 10", "Kreis 11", "Kreis 12"), ordered = T)

barplot(table(kreise_fact), col = c("green4"), ylab = "Anzahl Minderjähriger", main = "Anzahl Minderjähriger in der Stadt Zürich pro Kreis in 2022", las = 2)

# Modus: Kreis 11

# Relative Häufigkeit ^
jug_filtered_data <- data[data$StichtagDatJahr == 2022 & data$AlterV20Kurz == "0-19",]
sen_filtered_data <- data[data$StichtagDatJahr == 2022 & data$AlterVKurz >= 65,]
ges_filtered_data <- data[data$StichtagDatJahr == 2022,]
jug <- c()
sen <- c()
ges <- c()
kreise <- c("Kreis 1", "Kreis 2", "Kreis 3", "Kreis 4", "Kreis 5", "Kreis 6", "Kreis 7", "Kreis 8", "Kreis 9", "Kreis 10", "Kreis 11", "Kreis 12")
for (kreis in kreise) {
  temp <- sum(jug_filtered_data[jug_filtered_data$KreisLang == kreis,]$AnzBestWir)
  jug <- c(jug, temp)
  temp <- sum(sen_filtered_data[sen_filtered_data$KreisLang == kreis,]$AnzBestWir)
  sen <- c(sen, temp)
  temp <- sum(ges_filtered_data[ges_filtered_data$KreisLang == kreis,]$AnzBestWir)
  ges <- c(ges, temp)
}
out_jug <- jug / ges
out_sen <- sen / ges

kreise_dat <- NaN
kreise
kreise_dat <- data.frame(kreis = kreise, jug = out_jug, sen = out_sen)
kreise_dat

ggplot(kreise_dat, aes(x=kreis, y=jug))+
  geom_bar(fill="green4", stat = "identity")+
  labs(y="Relative Häufigkeit", title = "Anzahl Senioren in der Stadt Zürich pro Kreis in 2022", x="")

par(mfrow=c(2,1))
barplot(out_sen, las = 2, col = "green4", ylab = "Relative Häufigkeit", main = "Anzahl Senioren in der Stadt Zürich pro Kreis in 2022")
barplot(out_jug, las = 2, col = "green4", ylab = "Relative Häufigkeit", main = "Anzahl Minderjähriger in der Stadt Zürich pro Kreis in 2022")


# ---- Aufgabe 2 ----
dev.off()
# Idea: Box Plots AnzBestWir -> AltersGruppen
year_2022 <- data[data$StichtagDatJahr == 2022,]

alters_gruppen <- c("0-19", "20-39", "40-59", "60-79", "80-99")

# Zu finden: Innerhalb der Gruppen der Bestand für 1 Alter
alters_data <- data.frame("start"=1:20)
for (gruppe in alters_gruppen) {
  for (alter in unique(year_2022[year_2022$AlterV20Kurz == gruppe,]$AlterVKurz)) {
    print(str(alter))
    alters_data[alter, "summe"] <- sum(year_2022[year_2022$AlterVKurz == alter,]$AnzBestWir)
    alters_data[alter, "gruppe"] <- gruppe
    alters_data[alter, "alter"] <- alter
  }
}
alters_data <- subset(alters_data, select = -start)
alters_data

par(mfcol=c(1,1), mar=c(2,2,2,7), xpd =T)
boxplot(summe ~ gruppe, data = alters_data, main="20 Jahres Gruppen im Jahr 2022", xlab = "Altersgruppe", ylab="Anzahl Personen")
points_y <- c(rep(1, 20), rep(2, 20), rep(3, 20), rep(4, 20), rep(5, 19))
library(RColorBrewer)
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector_20 <- tail(unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals))), 20)
col_vector <- head(rep(col_vector_20, 5), -1)
symb_vector <- 0:19
points(y=alters_data$summe, x=points_y, col = col_vector, pch=symb_vector)
legend(x=6, y=10500, col = col_vector_20, legend = 0:19, pch=symb_vector)

plot(x=alters_data$alter, y=alters_data$summe, type = "o", ylab="Anzahl", xlab="Alter", main="Anzahl Personen pro Alter im Jahr 2022")

data$AltersArt <- NaN
data[data$AlterVKurz > 65,]$AltersArt <- "senioren"
is.na(data$Alersart)

?knitr::kable

