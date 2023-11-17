# ---- Aufgabe 1 ----
# A
daten<-matrix(data=c(17,19,149,141),nrow=2,ncol=2,byrow=F, dimnames=list(Täter=c("schwarz","weiss"), Strafe=c("Todesstrafe","andereStrafe")))

mosaicplot(daten)

# B
daten2<-array(data=c(6,0,97, 9,11,19,52,132),dim=c(2,2,2), dimnames=list(Taeter=c("schwarz","weiss"),Urteil=c("Todesstrafe", "andereStrafe"),Opfer=c("Opferschwarz","Opferweiss")))

mosaicplot(daten2)

# ---- Aufgabe 2 ----
load('./data/xenophobie.rda')

head(xenophobie)

# A
rel <- table(xenophobie$nation, xenophobie$straftat) / nrow(xenophobie)

barplot(rel, beside = T, legend.text = T)

install.packages('vcd', dependencies = T)
library(vcd)
mosaic(~nation+wohnort+straftat,data=xenophobie, direction= c("v","h","v"),
       highlighting ="straftat",
       highlighting_fill=c("seagreen","#F5C710","mediumvioletred"),
       main="Straftaten", cex.axis=0.7)

# B
# Es scheint, als würden allgemein sehr viel mehr ausländer Verbrchen begehen, doch der Wohnort ist ein entscheidender Faktor, der vergessen geht.
# Da mehr verbrehcen in Hölental begangen werden, wo der ausländer Anteil grösser ist.


# ---- Aufgabe 3 ----
dat <- read.table('./data/kdata.txt', sep = '\t', header = T)
head(dat)

# A
library(vcd)
mosaic(~zivilstand+kaufkraft+geschlecht, data=dat, direction= c("v","h","v"),
       highlighting ="geschlecht",
       highlighting_fill=c("seagreen","#F5C710"),
       main="Straftaten", cex.axis=0.7)
# Es gibt mehr verheiratete Männer
# Sehr hohe Kaufkraft haben sehr viel mehr Männer, als Frauen

# B
boxplot(einkauf~kaufkraft+zivilstand+geschlecht,data=dat,
        col=c('#E0607E','#0A9086','#3E5496','#EFDC60'), las = 2)
legend("topleft", legend = unique(dat$kaufkraft), fill = c('#E0607E','#0A9086','#3E5496','#EFDC60'))
# Es sieht sehr ausgeglichen aus, was das einkommen angeht, vorallem mit den gleichen Kaufkräften

# C
dat$kaufkraft <- factor(dat$kaufkraft, levels = c("tief", "mittel", "hoch", "sehr hoch"), ordered = T)
unique(dat$zivilstand)
dat$zivilstand <- factor(dat$zivilstand, levels = unique(dat$zivilstand))
dat$geschlecht <- factor(dat$geschlecht, levels = unique(dat$geschlecht))
plot.design(kaufkraft ~ einkauf + zivilstand + geschlecht, data=dat)
 
# D + E
?plot
plot(dat$einkauf, dat$alter, col = c("black", "blue")[dat$geschlecht], pch = c(1, 3)[dat$geschlecht], cex =c(0.5,1,1.5)[dat$zivilstand])
legend("topright", legend = c("Männer", "Frauen"), col = c("black", "blue"), pch=c(1,3))
legend(38000, 80, legend = unique(dat$zivilstand), pch = c(1), cex=c(0.5,1,1.5))

# F
install.packages("scatterplot3d")
library(scatterplot3d)
scatterplot3d(dat$alter,dat$pihh,dat$einkauf,type="h", color = c("darkred"))






