# ---- low-level ----
# Dinge zu einem Plot hinzufügen

# Punkte Zeichnen
points(x=seq(1, 180, 2), y = seq(1,3000, 50))

# Linie Zeichnen
lines(x=c(12, 80, 100), y = c(100, 200, 300), col = c("red"), lwd = 2)


aggregate() # Kann funktionen auf Dataframe ausführen

abline() # Zeichnet gerade Linien in den Plot ein

# Plot einstellungen
par()

# Resetted par einstellungen
dev.off()

# ---- Identify ----
plot() # Plot machen
indexes <- indentify(x=..., y=..., labels=...) # Punkte auswählen in der Grafik

dat[indexes,]

# ---- Diagramme Speichern ----
?pdf
?png
?jpeg

pdf(file="out.pdf") # Setzt den output file stream nicht mehr auf den bildschirm
plot() # Plot machen
abline(10) # ändern
dev.off() # Jetzt wird nicht mehr in das file geschrieben
# ---- Aufgabe 1 ----
dat <- read.csv('./data/oil-animals.csv')

# A
head(dat)
# 2010-05-02
# Als am 02.05.2010

# B & C
plot(dat$Longitude, dat$Latitude, ylab="Breitengrade", xlab="Längengrade")
# Die Erdrundung verzieht die Daten ein wenig, aber es sollte nicht allzu fest sein.

# D & E & F & G & I
?par
?png
?svg
svg('./exports/prakt_0211_A1I.svg')
par(mfcol=c(2,1), mar=c(2,2,2,7), xpd =T)

dat[dat$Alive == "Y", "AliveCol"] <- "green"
dat[dat$Alive == "N", "AliveCol"] <- "red"

dat$Type <- factor(dat$Type, levels = unique(dat$Type))

unique(dat$Type)

palette( c("purple", "orange"))

plot(dat$Longitude, dat$Latitude, col=dat$AliveCol, main="Tot / Lebendig")
legend(x=-81, y=31, legend = c("Dead", "Alive"), fill = unique(dat$AliveCol))
points(x=-87.68528, y=28.75389, col = "blue", pch = 10)
text(x=-87.68528, y=28.75389, label = "Deepwater Horizion", pos = 1, col = "blue")
plot(dat$Longitude, dat$Latitude, col=dat$Type, main = "Tier Art")
legend(x=-81, y=31, legend = unique(dat$Type), fill = unique(dat$Type))
points(x=-87.68528, y=28.75389, col = "blue", pch = 10)
text(x=-87.68528, y=28.75389, label = "Deepwater Horizion", pos = 1, col = "blue")

dev.off()
# H
# Es ist sehr viel überlappend und fast alle Vögel scheinen tot zu sein
# Nur wenige ausnahmen

# J
dev.off()
dat_cast <- read.csv('./data/oil-animals-cast.csv')
head(dat_cast)

tutels <- dat_cast[dat_cast$Type == "turtles", ]
birbs <- dat_cast[dat_cast$Type == "birds", ]

alive_tutels <- tutels[tutels$Alive == "Y", c("number", "week.number")]
dead_tutels <- tutels[tutels$Alive == "N", c("number", "week.number")]

alive_birbs <- birbs[birbs$Alive == "Y", c("number", "week.number")]
dead_birbs <- birbs[birbs$Alive == "N", c("number", "week.number")]

length(dead_tutels$number)
length(alive_tutels$number)

?plot
par(mfrow=c(1,2))
plot(dead_birbs$week.number, dead_birbs$number, type = "l", col = "red", main = "Birds", ylab = "number", xlab = "week")
lines(alive_birbs$week.number, alive_birbs$number, type = "l", col="green")
legend("topleft", fill = c("red", "green"), legend = c("Dead", "Alive"))

plot(alive_tutels$week.number, alive_tutels$number, type = "l", col = "red", main = "Turtles", ylab = "number", xlab = "week")
lines(dead_tutels$week.number, dead_tutels$number, type = "l", col="green")
legend("topleft", fill = c("red", "green"), legend = c("Dead", "Alive"))


# K
dev.off()
library(RgoogleMaps)
MyMap<-MapBackground(lat=dat$Latitude,lon=dat$Longitude)
PlotOnStaticMap(MyMap,lat=dat$Latitude,lon=dat$Longitude)

install.packages("devtools", dependencies = T)
devtools::install_github("stadiamaps/ggmap") #InstalliertdasPaketggmap
install.packages("tmaptools", depedencies = T) #InstalliertdasPakettmaptools


library(tmaptools)
library(ggmap)
register_stadiamaps('3f745b26-0f44-4aab-9921-e5b617ab44cb')
###Kartenausschnitt(BoundingBox)auswählenmitderFunktionbb
bbox = bb(cx=-87.68528, cy=28.75389, xlim=c(-96,-81), ylim=c(24,31))
###BoundigBoxmusseineMatrixsein
bboxDF<-matrix(bbox,nrow=1)
###KoordinatenDeepwaterHorizonalsDataFrame
coordDwH<-data.frame(lat=28.75389, long=-87.68528)
###Kartewirdheruntergeladen(Netzzugang)
mapGolfMexiko<-get_stadiamap(bbox=bboxDF,zoom=6)
###KarteZeicheninkl.derKoordinatendergefundenenTiere
ggmap(mapGolfMexiko) + #Kartezeichnen
  geom_point(data=dat,
             aes(x=Longitude,y=Latitude, #Fundorteeinzeichnen
                 color=Alive,shape=Type))+
  geom_point(data=coordDwH, #KreuzDwH
             mapping=aes(x=long,y=lat), shape=3,color="black")+
  geom_text(data=coordDwH, #BeschriftungDwH
            mapping=aes(x=long,y=lat), label='DeepwaterHorizon',
            hjust=0,nudge_x=0.2,size=3)



       