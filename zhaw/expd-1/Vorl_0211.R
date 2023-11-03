# ---- Aufgabe 3 ----

x = seq(-10, 10, 1)

plot(x, y=x**2)
# Macht sinn, da das einfach eine Funktion darstellt.

# ---- Aufgabe 4 ----
load('./data/wohnungen.rda')

# A
plot(x=wg$m2, y=wg$Miete)
# Zusammenhang: Schwach positiv linear

# B
cor(x=wg$m2, y=wg$Miete, method = "pearson")
# Pearson, da es schon ein Linearer Zusammenhang ist und Spearman man daten Verliert.
# Eher starker Zusammenhang mit ~0.8

# C
unique(wg$Ort)

wg_z <- wg[wg$Ort == "Zuerich",]
cor(x=wg_z$m2, y=wg_z$Miete, method = "pearson") # 0.878
cor(x=wg_z$m2, y=wg_z$Miete, method = "spearman") # 0.912

wg_bern <- wg[wg$Ort == "Bern",]
cor(x=wg_bern$m2, y=wg_bern$Miete, method = "pearson") # 0.827
cor(x=wg_bern$m2, y=wg_bern$Miete, method = "spearman") # 0.84

wg_basel <- wg[wg$Ort == "Basel",]
cor(x=wg_basel$m2, y=wg_basel$Miete, method = "pearson") # 0.861
cor(x=wg_basel$m2, y=wg_basel$Miete, method = "spearman") # 0.93

wg_l <- wg[wg$Ort == "Luzern",]
cor(x=wg_l$m2, y=wg_l$Miete, method = "pearson") # 0.839
cor(x=wg_l$m2, y=wg_l$Miete, method = "spearman") # 0.753

# Es gibt stärkere Zusammenhänge in Zürich und Basel, aber Allgemein ist zu sagen, dass in Städten die m2 und Miete stärker zusammenhängt, als über alle 4 Städte verteilt.


