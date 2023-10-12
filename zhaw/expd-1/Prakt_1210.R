# ---- Logische Vektoren ----
v <- c(160, 145, 195, 173, NA, 181)

v > 175
!(v > 175)
v[v > 174]
v == 160

v > 160 | v < 190 # or

v > 160 & v < 190 # and

which(v > 175)
which.min(v)

v[which.min(v)]

all(v > 175)

any(v < 190)

all(v < 120, na.rm = T)

any(v > 175)

is.na(v)

?which

v <- v[!is.na(v)] # NA werden weggelassen
v

# ---- Zeichketten ----
namen <- c("Urs", "Anna", "Max", "Pia", "Maaike")

nchar(namen)
substring(namen, 1, 2)

paste(namen, 1:length(namen), sep = "_")
paste(namen, "Z.", sep = " ")
paste(namen, c("Z.", "M."), sep=" ")
test <- paste(namen, collapse = " ") # Join
test

length(namen)

length(test)

tolower(namen)

toupper(namen)

grep(pattern = "a", x=namen)
test <- grepl(pattern="i", namen)
test
sum(test)
sub(pattern="a", replacement = ".", tolower(namen))
gsub(pattern="a", replacement = ".", tolower(namen))

# ---- Daten Speichern ----
write.table(x=namen, file="namen.csv", sep=",", col.names=T, quote=F, fileEncoding="UTF-8")

install.packages("openxlsx", dependencies = T)
library(openxlsx)
write.xlsx(x = namen, file = "namen.xlsx")

# ---- Aufgabe 1 ----
# A
kiebitz <- read.table(file="./data/kiebitz.txt", sep=",", header = T)

kiebitz

# B
feld_nr_1411 <- kiebitz[kiebitz$Feld.Nr == 1411,]
feld_nr_1411

# C
feld_nr_1411[feld_nr$Taetigkeit == "fr",]$Anzahl


# D
ruhend <- kiebitz[kiebitz$Taetigkeit == "ru",]
ruhend

ruhend[which.max(ruhend$Anzahl),]

# ---- Aufgabe 2 ----
# A
klasse_raw <- read.xlsx("./data/datDS23t_raw.xlsx")
klasse_raw

df <- df[, -which(names(df) == "column_name_to_remove")]
klasse <- klasse_raw[, -which(names(klasse_raw) == "Antworten")]
colnames(klasse) <- gsub("Q00_", "", names(klasse))
colnames(klasse) <- gsub("\s", "_", names(klasse))
colnames(klasse) <- tolower(names(klasse))
klasse

# B
str(klasse)

klasse$koerpergroesse <- as.numeric(klasse$koerpergroesse)
klasse$sport <- as.numeric(klasse$sport)
klasse$alter <- as.numeric(klasse$alter)

str(klasse)

# C
boxplot(klasse$koerpergroesse)

# D
table(klasse$koerpergroesse[klasse$koerpergroesse > 190])

# E
mad(klasse$koerpergroesse, na.rm = T)

# F
str(klasse)
klasse
blond_sport <- klasse[klasse$haarfarbe == "blond",]
braun_sport <- klasse[klasse$haarfarbe == "braun",]
black_sport <- klasse[klasse$haarfarbe == "schwarz",]

median(blond_sport$sport) > median(braun_sport$sport)
median(black_sport$sport) > median(braun_sport$sport)

# G
v_sel <- klasse[klasse$alter < 22 &
                  klasse$schlafzimmer == "1. Stock" &
                  (klasse$anreisezeit.an.die.zhaw >= 50 |
                     klasse$handspanne > 20),]
v_sel <- v_sel[!rowSums(is.na(v_sel[-1])),]
dim(v_sel)

# H
IQR(klasse$alter, na.rm = T)
mad(klasse$alter, na.rm = T)
var(klasse$alter, na.rm = T)

klasse$alter[which.min(klasse$alter)] <- NA
klasse$alter[which.max(klasse$alter)] <- NA

IQR(klasse$alter, na.rm = T)
mad(klasse$alter, na.rm = T)
var(klasse$alter, na.rm = T)

# I
klasse$ratHKgr <- NA
?which

klasse$handspanne <- as.numeric(klasse$handspanne)

klein_sel <- which((klasse$handspanne / klasse$koerpergroesse) <= 0.11)
mittel_sel <- which(0.11 < (klasse$handspanne / klasse$koerpergroesse) & (klasse$handspanne / klasse$koerpergroesse) <= 0.12)
gross_sel <- which((klasse$handspanne / klasse$koerpergroesse) > 0.12)

klein_sel
mittel_sel
gross_sel

klasse$ratHKgr[klein_sel] <- "klein"
klasse$ratHKgr[mittel_sel] <- "mittel"
klasse$ratHKgr[gross_sel] <- "gross"
klasse$ratHKgr

# J
klasse$ID <- paste(klasse$sport, klasse$alter, klasse$postleitzahl, sep = "-")

klasse$ID

# K
write.xlsx(klasse, "./data/selfOutput.xlsx")




