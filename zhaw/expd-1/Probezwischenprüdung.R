load('./data/airline.rda')

# ---- Aufgabe 1 ----

# A
head(airline)
nrow(airline)

# 11331

# B
# Tag: metrisch diskret
# US.Staat: kategoriell nominal
# Flugdauer: metrisch stetig
# Verspätung: metrisch stetig

# C
airline$Grund <- factor(airline$Grund, levels = c("No Delay", "Carrier", "Late Aircraft", "National Air System", "Security", "Weather"))
airline$Grund

# D
more_six_hours <- airline[airline$Flugdauer > 6*60,]
more_six_hours
unique(more_six_hours$US.Staat)

# E
florida <- airline[airline$US.Staat == "FL",]
mean(florida$Flugdauer) # 141.6
var(florida$Flugdauer) # 218.52

# F
unique(airline$US.Staat)
delay <- airline[airline$Verspaetung, ]
nrow(delay) # Absolut: 3207
nrow(delay) / nrow(airline) # Relativ: 0.283

# G
california <- airline[airline$US.Staat == "CA",]
ca_delay <- california[california$Verspaetung & california$Grund == "Weather",]
ca_delay
nrow(ca_delay) # Absolut: 12
nrow(ca_delay) / nrow(california) # 0.006366

# ---- Aufgabe 2 ----
# A
barplot(table(airline$US.Staat), las=2)
nrow(airline[airline$US.Staat == "FL",]) # 1946

# B
boxplot(Flugdistanz ~ Verspaetung, data = airline, main="Verspaetung", col = c("red", "blue"), ylab = "Flugdistanz [mile]", xlab = "Verspaetung")

# C
?barplot
simplified <- airline[airline$US.Staat == "AZ" | airline$US.Staat == "LA" | airline$US.Staat == "MT" | airline$US.Staat == "OR" | airline$US.Staat == "PR",]
simplified
barplot(table(simplified$Verspaetung, simplified$US.Staat), col = c("blue", "red"), beside = T)
# Puerto Rico hat eine sehr hohe Verspätungsrate.
# Louisiana hat mehr Verspätungen, als rechtzeitige Flüge.

# D
scatter.smooth(airline$Flugdauer, airline$Flugdistanz)
# Sehr starker lineare positiver Zusammenhang

# ---- Aufgabe 3 ----
# A
# 1: Linksschief
# 2: 11~13
# 3: Unter
# 4: 7-8

# B
# 1: A
# 2: B
# 3: A
# 4: A -> Median mehr auf der Seite des 25% Quantil

# ---- Aufgabe 4 ----
# A: F
# B: R
# C: R
# D: F
# E: F

?stripchart
stripchart(airline$Flugdistanz, method="jitter")
