# ---- Aufgabe 4 ----
munis <- c(53.9, 54.3, 54.6, 54.6, 54.9, 55.9, 55.1, 55.2, 55.5, 55.5, 55.5, 55.5, 55.6, 55.8, 51.2, 51.4, 51.9, 51.9, 52.1, 52.6, 52.9, 52.9, 52.9, 53, 53.1, 53.1, 53.3, 55.9, 56.1, 56.1, 56.2, 56.7, 56.9, 56.9, 56.9, 57.4, 57.5, 58.8, 59.6, 53.3, 53.4, 54, 54, 54.1, 54.2, 54.6, 54.6, 54.6, 54.7, 54.8, 54.8)

table_munis <- table(munis)
median(munis)
quantile(munis)
max(munis)
min(munis)

IQR(munis) * 1.5

55.85+3.825
53.3-3.825

# ---- Aufgabe 5 ----
library(openxlsx)
klasse_raw <- read.xlsx("./data/datDS23t_raw.xlsx")
# A
klasse_raw$Q00_Koerpergroesse <- as.numeric(klasse_raw$Q00_Koerpergroesse)
hist(klasse_raw$Q00_Koerpergroesse)

# B
var(klasse_raw$Q00_Koerpergroesse, na.rm = T)
mad(klasse_raw$Q00_Koerpergroesse, na.rm = T)
IQR(klasse_raw$Q00_Koerpergroesse, na.rm = T)
sd(klasse_raw$Q00_Koerpergroesse, na.rm = T) # Standardabweichung

# C
klasse_raw$Q00_Koerpergroesse
# Gar nicht -> Keine Person über 2m