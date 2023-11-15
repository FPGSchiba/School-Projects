# ---- Listen ----
L <- list(A = 1:10, c(12, 12, 11), m = matrix(1:4, nrow=2))
typeof(L)
length(L)
lengths(L)

# Elemente von Listen sind immer auch Listen
L[3]
typeof(L[3])
L[["A"]]
L[[3]]
typeof(L[[3]])

# Namen
names(L)
L$m

# Elemente
L[[2]][3]
L[[c(2,3)]]

L2 <- list(A = c(4, 6), c(12, 8, 29), c(4, 7, 9), c("No No"))
unlist(L2) # Alles wird zu cahracter

L2[[2]] <- c("This should be fine", "WoW")
L2

names(L)[2] <- "new_name"
names(L)

length(L)
str(L)
# ---- Aggregation ----
mpg <- readRDS('./data/mpg.rds')

tapply(mpg$cty, INDEX = mpg$manufacturer, mean, na.rm=T)

agg <- aggregate(x = mpg$cty, by = list(Manu = mpg$manufacturer, Class = mpg$class), FUN=mean)
agg

agg <- aggregate(cty ~ manufacturer+displ, data = mpg, FUN = mean)
agg

# Alle Variablen
agg <- aggregate(mpg, by=list(mpg$manufacturer), FUN = mean)
agg

# Apply Familie
X <- matrix(1:20, nrow=4)
X
apply(X, MARGIN = 1, FUN = sum)
apply(X, MARGIN = 2, FUN = sum)

lapply(L, sum) # Ergibt Liste
sapply(L, sum) # Ergibt Vektor -> Vereinfachung von lapply

# Multivariante
mapply(rep, x=5:8, times=1:4) # Nicht wichtig

tapply(mpg$cty, INDEX = mpg$manufacturer, FUN = mean)

# ---- Daten Umformatieren ----
# Nicht sehr einfach zu gebrauchen
?reshape
# White Format zu Long Format
# -> Spalten zu zeit oder andere Art von Variable umformatieren
# Land 2011 2012 2013
# DE   1231 1231 1424
# FR   1231 1231 1233

# Zu:
# Land Jahr n
# DE   2011 1231
# DE   2012 1231
# DE   2013 1424
# FR   2011 1231
# FR   2012 1231
# FR   2013 1233

library(tidyr)

# ---- Zusammenfügen ----
players <- readRDS()
songs <- readRDS()

# Natural Join
merge(x = songs, y = players,
      by = "name", all = F)

# Left Join
merge(x=songs, players, by = "name", all.x = T)

# Right Join
merge(songs, players, by = "name", all.y = T)

# Full Join
merge(songs, players, by = "name", all = T)

# ---- Aufgabe 1 ----
# A
load('./data/bestellungen.rda')
dat <- read.csv('./data/PLZO_CSV_LV03.csv', sep = ';')

merged_dat <- merge(bestellungen, dat, by=c("PLZ", "Zusatzziffer"), all.x = T)

# B
new_dat <- aggregate(merged_dat$id, by=list(Kantonskuerzel=merged_dat$Kantonskuerzel), FUN=length)
new_dat$mittelwert <- aggregate(merged_dat$preis, by=list(Canton=merged_dat$Kantonskuerzel), FUN=mean)$x
new_dat$maximum <- aggregate(merged_dat$preis, by=list(Canton=merged_dat$Kantonskuerzel), FUN=max)$x
new_dat$time <- aggregate(merged_dat$timestamp, by=list(Canton=merged_dat$Kantonskuerzel), FUN=max)$x
colnames(new_dat)[2] <- "anzahl"
new_dat

# C
merged2_dat <- merge(merged_dat, new_dat, by=c("Kantonskuerzel"), all.x = T)
merged2_dat


# ---- Aufgabe 2 ----
load('./data/currencies.rda')
head(currencies)

# A
plot(currencies$Time, currencies$EUR.CHF, type='l', col=c("red"), ylim = c(0.01,1.8))
lines(currencies$Time, currencies$USD.CHF, col="blue", lty=1)
lines(currencies$Time, currencies$GBP.CHF, col="green", lty=1)
lines(currencies$Time, currencies$JPY.CHF, col="yellow", lty=1)

# B
library(tidyr)
dat <- currencies %>% pivot_longer(
                    cols = ends_with(".CHF"),
                    names_to = "currencyRate",
                    values_to = "value")
head(dat)
# C
plot(value ~ Time, data = dat, col=c("red", "blue", "green", "yellow"), type="p", pch=16)

# ---- Aufgabe 3 ----
?airquality

head(airquality)

# A
airquality[airquality$Wind >= 12, "windstatus"] <- "windig"
airquality[airquality$Wind < 12, "windstatus"] <- "nicht-windig"
airquality$windstatus <- factor(airquality$windstatus, levels = c("windig", "nicht-windig"))

# B
unique(airquality$Month)
table(airquality$Month, airquality$windstatus)

# C
aggregate(Solar.R ~ Month, data = airquality, FUN=mean, na.rm=T)
aggregate(Wind ~ Month, data = airquality, FUN=mean, na.rm=T)

# D
str(airquality)
aggregate(Ozone~Month, data = airquality, FUN=mean, na.rm=T)
aggregate(Solar.R ~ Month, data = airquality, FUN=mean, na.rm=T)
aggregate(Wind ~ Month, data = airquality, FUN=mean, na.rm=T)
aggregate(Temp ~ Month, data = airquality, FUN=mean, na.rm=T)

