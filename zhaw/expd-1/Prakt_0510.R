# ---- Einlesen von Daten ----
file_path <-  paste(getwd(), '/data/datDS23t.csv', sep='')
dat <- read.table(file = file_path, header = TRUE, sep = ",")
dat <- read.csv(file = file_path, header = TRUE)

library(readxl)
file_path <- paste(getwd(), '/data/datDS23t.xlsx', sep='')
dat1 <- read_excel(path=file_path) # Ergibt einen Tibble -> Neuere Variante -> Kann aber nicht von allen Funktionen verwendet werden
dat1
dat1 <- as.data.frame(dat1) # Casting to Dataframe
dat1

# Workspace
getwd()
setwd(getwd())
history()

ls()
rm(dat1)


# ---- Auswahl von Elementen ----
# Vectors
x <- 1:16
x
x[4]
x[c(1, 3)]
x[seq(2, 16, 2)]

x[17]
x[-2]

summary_x <- c(max(x), min(x), sum(x))
names(summary_x) <- c("Max", "Min", "Sum")
summary_x
summary_x["Max"]


# Data Frames 
dat2 <- data.frame(x = 1:15, b=letters[1:15], c=16:30)
dat2[1, 3]
dat2[1, 'c']
dat2[c(1, 3), c(2, 3)]
dat2[1, ]
dat2
dat2[, -2]
dat2[-2,]


# ---- None Umgang ----
mean(dat$koerpergroesse, na.rm = TRUE)

par(mfrow = c(1, 3))

stripchart(dat$koerpergroesse, method="stack", width=100)


# ---- Aufgabe 1 ----
# CSV
csv_path <- paste(getwd(), '/data/datDS23t.csv', sep='')
csvDat <- read.csv(csv_path, header = TRUE)

# TXT
txt_path <- paste(getwd(), '/data/datDS23t.txt', sep='')
txtDat <- read.table(txt_path, header = TRUE, sep = '\t')

# RDS
rds_path <- paste(getwd(), '/data/datDS23t.rds', sep='')
rdsDat <- readRDS(rds_path)

# RDA 
rda_path <- paste(getwd(), '/data/datDS23t.rda', sep='')
?load
load(file = rda_path) # Named: dat

# Excel
excel_path <- paste(getwd(), '/data/datDS23t.xlsx', sep='')
excelDat <- read_excel(path=excel_path)
excelDat <- as.data.frame(excelDat)

all.equal.character(csvDat, txtDat)
all.equal.character(txtDat, rdsDat)
all.equal.character(rdsDat, dat)
all.equal.character(rdsDat, excelDat)


# ---- Aufgabe 2 -----
# A
kibi_path <- paste(getwd(), '/data/kiebitz.txt', sep = '')
kibi_dat <- read.table(kibi_path, header = TRUE, sep = ',')

# B
length(kibi_dat) # Merkmale: 3
length(kibi_dat$Feld.Nr) # Datenpunkte: 9

# C
str(kibi_dat)

# F
dat_1411 <- kibi_dat[kibi_dat$Feld.Nr == 1411,]
dat_1411

# E
sum(dat_1411$Anzahl) # Anzahl: 61

# ---- Aufgabe 3 ----
rds_raw_path <- paste(getwd(), '/data/datDS23t_raw.rds', sep='')
rdsRawDat <- readRDS(rds_raw_path)
rdsRawDat <- as.data.frame(rdsRawDat)

rdsRawDat$Q00_Koerpergroesse[12] # 1: Wahr
rdsRawDat$Q00_Statistische_Vorkenntnisse[16] # 2: Wahr
rdsRawDat$Q00_Ausbildung[15] # 3: Falsch
rdsRawDat[24,] # 4: Wahr
rdsRawDat[20,] # 5:Wahr
rdsRawDat[c(7, 19),] # 6: Wahr
rdsRawDat[seq(20,22),] # 7: Wahr
barplot(table(rdsRawDat$Q00_Geschlecht[seq(1,20)])) # 8: Wahr
barplot(table(rdsRawDat$Q00_Schlafzimmer[seq(1,15)])) # 9: Wahr
mean(rdsRawDat$Q00_Handspanne, na.rm = TRUE) # 10: Wahr
mean(rdsRawDat$Q00_Koerpergroesse, na.rm = TRUE) # 11: Wahr
median(rdsRawDat$Q00_Koerpergroesse, na.rm = TRUE) # 12: Falsch
median(rdsRawDat$Q00_Koerpergroesse[c(seq(1,9), seq(11, 25))], na.rm = TRUE)
mean(rdsRawDat$Q00_Anreisezeit_an_die_ZHAW[c(10,13,23)]) # 13: Falsch
mean(rdsRawDat$Q00_Anreisezeit_an_die_ZHAW, na.rm = TRUE)
rdsRawDat$Q00_Sport[c(2, 3, 8, 10)] # 14: Wahr
rdsRawDat[c(13, 16, 21), c("Q00_Geschlecht", "Q00_Postleitzahl")] # 15: Falsch
rdsRawDat[c(10, 21), c("Q00_Ausbildung")] # 16: Wahr

# ---- Aufgabe 4 ----
sleep_path <- paste(getwd(), '/data/sleep.txt', sep='')
sleepDat <- read.table(sleep_path, header = TRUE, sep = '\t')

length(sleepDat$ID) # 10 Personen

diff <- abs(c(sleepDat$Placebo - sleepDat$Schlafmittel))
length(diff)

mean(diff)
median(diff)

stripchart(diff, method = "stack")
hist(diff)
# Es gibt wenige Ausreisser, die meisten liegen aber zwischen 0-2 Stunden

plot(ecdf(diff))
# Mehr als eine Stunde Schlaf: 80%
# Mehr als 3 Stunden Schlaf: 10%