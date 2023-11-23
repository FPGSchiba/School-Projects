# ---- GGPlot ----
install.packages("ggplot2", dependencies = T)
library(ggplot2)

# Ohne angabe der Shape des Plots
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))

# Standard GGPlot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point()

# Weitere Variable als Farbe
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = class))+
  geom_point()

# Weitere Variable als Shape der Punkte
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, shape = drv))+
  geom_point()

# Beides Kombiniert
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, shape = drv, color = class))+
  geom_point()

# Geom Überschreiben
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, shape = drv, color = class))+
  geom_point(color = "blue", shape = 17)

# ACHTUNG: Farben und shapes nicht im AES shreiben, da diese auf Daten gemapped werden.
test <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = "blue"))+
  geom_point()

# Bild speichern:

# letzte speichern
ggsave(filename = "Test.pdf")

# Spezifisches GGPlot Objekt speichern
ggsave(filename = "Test.pdf", plot = test)


# ---- Aufgabe 1 ----
