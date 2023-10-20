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
