# ---- Faktoren ----
dat <- readRDS('./data/datDS23t.rds')

str(dat$programmierkenntnisse)

unique(dat$programmierkenntnisse)

prog_kentnisse <- factor(dat$programmierkenntnisse)
levels(prog_kentnisse)
nlevels(prog_kentnisse)
str(prog_kentnisse)

boxplot(anreisezeit_an_die_zhaw ~ programmierkenntnisse, data = dat)

summary(prog_kentnisse)

dat$programmierkenntnisse <- factor(dat$programmierkenntnisse, levels = c('nicht vorhanden', 'gering', 'mittel', 'gross'), ordered = T)
dat$programmierkenntnisse

summary(prog_kentnisse)

boxplot(anreisezeit_an_die_zhaw ~ programmierkenntnisse, data = dat)

# Levels umbennenen: Variante 1
dat$programmierkenntnisse <- as.character(dat$programmierkenntnisse)
dat$programmierkenntnisse[dat$programmierkenntnisse == "nicht vorhanden"] <- "keine"
dat$programmierkenntnisse

dat$programmierkenntnisse <- factor(dat$programmierkenntnisse, levels = c("keine", "gering", "mittel", "gross"), ordered = T)

boxplot(anreisezeit_an_die_zhaw ~ programmierkenntnisse, data = dat)

# Levels umbenennen: Variante 2
dat$programmierkenntnisse <- factor(dat$programmierkenntnisse, labels = c("keine", "gering", "mittel", "gross"))
dat$programmierkenntnisse

boxplot(anreisezeit_an_die_zhaw ~ programmierkenntnisse, data = dat)

# ---- Kategorien ----
range(dat$alter, na.rm = T)
dat$alter
dat$alter_kat <- cut(x=dat$alter, breaks = c(18, 20, 25, 30, 45),
                     labels = c("jung", "mittel", "älter", "alt"))

boxplot(anreisezeit_an_die_zhaw ~ alter_kat, data = dat)

# ----- Pakete Installieren ----
# Dependencies = T -> Dependencies werden auch heruntergeladen
install.packages('tidyverse', dependencies = T)

library(ggplot2)
ggplot2::ggplot(dat, aes(y = koerpergroesse, x= geschlecht))+geom_boxplot()

# Speicher pfad für libraries
.libPaths()

# ---- Aufgabe 1 ----
install.packages('nc', dependencies = T)
library(openxlsx)
dat <- read.xlsx('./data/selfOutpu.xlsx')

# A
dat$AugFaFact <- factor(tolower(dat$augenfarbe), levels = c("blau", "grün", "braun", "schwarz"))

dat$AugFaFact

# B
table(dat$AugFaFact)

# C
str(dat$AugFaFact)

# D
lvls <- c("schwarz", "braun", "blau", "grün")

dat$augenfarbe

out <- rep(NA, length(dat$augenfarbe))

library(nc)
for (level in lvls) {
  print(level)
  temp <- nc::capture_first_vec(
    tolower(dat$augenfarbe), 
    chromStart=paste(level, sep=""),
    nomatch.error = F
    )
  out[!is.na(temp$chromStart)] <- level
}

dat$AugFaFactSimple <- factor(out, levels = lvls)
dat$AugFaFactSimple

# E
barplot(table(dat$AugFaFactSimple) / length(dat$AugFaFactSimple), ylab = "Relative Häufigkeit")

# F
dat$haarfarbe
mosaicplot(AugFaFactSimple ~ haarfarbe, data = dat, col = c("brown", "yellow", "black"))

# G
dat$schlafzimmer <- factor(dat$schlafzimmer, levels = c("0. (Parterre)", "1. Stock", "2. Stock", "3. Stock", "4. Stock", "5. Stock", "6. Stock"), ordered = T)
dat$schlafzimmer
quantile(table(dat$schlafzimmer))

ecdf(table(dat$schlafzimmer))(3) # 0.5714









# ---- Aufgabe 2 ----
?read.table
dat <- read.table('./data/censUSA.txt', sep = "\t", header = T, na.strings = "?")
str(dat)

# A
dat$education <- gsub('[\t\n ]','',dat$education)
dat$education

dat$education <- factor(dat$education, levels = c("Preschool", "1st-4th", "5th-6th", "7th-8th", "9th", "10th", "11th", "12th", "HS-grad", "Prof-school", "Assoc-acdm", "Assoc-voc", "Some-college", "Bachelors", "Masters", "Doctorate"))

# B
mosaicplot(occupation ~ education, data = dat, las=2, col=c("red", "blue", "green"))


# C
unique(dat$education)

# Levels: 
# early school (Preschool, 1st-4th, 5th-6th)
# middle school (7th-8th, 9th
# high school (10th, 11th, 12th, HS-grad)
# college (Some-college, Assoc-acdm, Assoc-voc, Prof-school)
# higher education (Bachelors, Masters, Doctorate)

dat$education

dat$education <- as.character(dat$education)
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "1st-4th", "early school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Preschool", "early school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "5th-6th", "early school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "7th-8th", "middle school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "9th", "middle school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "10th", "middle school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "11th", "high school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "12th", "high school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "HS-grad", "high school"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Some-college", "college"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Assoc-acdm", "college"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Prof-school", "college"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Assoc-voc", "college"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Bachelors", "higher education"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Masters", "higher education"))
dat$education <- with(data.frame(x = dat$education), replace(dat$education, dat$education == "Doctorate", "higher education"))

unique(dat$education)

dat$education <- factor(dat$education, levels = c("early school", "middle school", "high school", "college", "higher education"))

mosaicplot(occupation ~ education, data = dat, las = 2, col = c("red", "blue", "green", "yellow", "black"))

# ---- Aufgabe 3 ----
# A
dat <- readRDS('./data/nzz.rds')
dat

# B
str(dat)
length(dat)


# C
dat <- gsub("ä", "ae", dat)
dat <- gsub("ö", "oe", dat)
dat <- gsub("ü", "ue", dat)
dat


# D
split <- strsplit(dat, "[.?!]")
split

str(split)

# E
split_edit <- replace(split, rep(" ", length(split)), "")
split_edit

# F
out <- c()
for (sent in split) {
  for (i in sent) {
    out <- c(out, grep("AHV", i))
  }
}

sum(out)

# ---- Aufgabe 4 ----
install.packages("ggmap") # Installiert das Paket ggmap
install.packages("tmaptools") # Installiert das Paket tmaptools

library(ggmap)
library(tmaptools)
bbox_winti<-rbind(as.numeric(paste(geocode_OSM("Winterthur")$bbox)))
map_winti<-get_stamenmap(bbox_winti,zoom=13)
Koord<-data.frame(lon=c(8.7293),lat=c(47.4974))
ggmap(map_winti,extent='device')+ geom_point(data=Koord,aes(x=lon,y=lat),colour="red")

