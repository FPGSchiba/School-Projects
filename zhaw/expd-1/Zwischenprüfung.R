load('./data/data_zp_hs23.rda')

# ---- Aufgabe 1 ----
# A
nrow(TR)

# B
str(TR)

# C
max(table(TR$age))

# D
nrow(TR[TR$eval > 4.5,])

# E
ecdf(TR$age) == 0.65
quantile(TR$age, probs = c(0.65))
plot(ecdf(TR$age))

# F
mean(TR[TR$gender == "male",]$eval)
mean(TR[TR$gender == "female",]$eval)

# E
profs <- TR[TR$native == "yes" & TR$tenure == "yes",]
nrow(profs)
nrow(profs) / nrow(TR)

# ---- Aufgabe 2 ----
# A
CS$Price_diff <- CS$Price - CS$CompPrice
hist(CS$Price_diff)

# B
ranges <- c("-60;-41", "-40;-21", "-20;-1", "0;20", "21;40", "41;60")
CS$Price_diff_fct <- NaN

CS[-60 < CS$Price_diff & CS$Price_diff <= -40,]$Price_diff_fct <- ranges[1]
CS[-40 < CS$Price_diff & CS$Price_diff <= -20,]$Price_diff_fct <- ranges[2]
CS[-20 < CS$Price_diff & CS$Price_diff <= 0, ]$Price_diff_fct <- ranges[3]
CS[0 < CS$Price_diff & CS$Price_diff <= 20,]$Price_diff_fct <- ranges[4]
CS[20 < CS$Price_diff & CS$Price_diff <= 40,]$Price_diff_fct <- ranges[5]
CS[40 < CS$Price_diff & CS$Price_diff <= 60,]$Price_diff_fct <- ranges[6]

CS$Price_diff_fct <- factor(CS$Price_diff_fct, levels = ranges, ordered = T)

boxplot(Sales ~ Price_diff_fct, data = CS)

# C
mosaicplot(US ~ Urban, data = CS, main = "Aufteilung der Geschäfte", ylab = "Urbane Umgebung", xlab = "In USA", col = c("green", "orange"))

# ---- Aufgabe 4 ----
# File: ./data/lenses2.txt
?read.table
dat <- read.table('./data/lenses2.txt', sep = '*', na.strings = "n/a")
head(dat, 3)
