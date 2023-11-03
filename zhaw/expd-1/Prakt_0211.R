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

alive_birbs$number <- c(alive_birbs$number, rep(0, length(dead_tutels$number) - length(alive_tutels$number)))

matplot(alive_tutels$week.number, cbind(alive_tutels$number, dead_tutels$number), type = "l", lty = 1, 
        col = c("green", "red"), xlab = "Wochen", 
        ylab = "Anzhal Tiere", main = "Tote und Lebendige Turtles gefunden")


       