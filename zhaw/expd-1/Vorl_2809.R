sternzeichen<-c("Waage","Waage","Krebs","Wassermann","Schuetze", "Zwillinge","Stier","Wassermann","Waage","Loewe", "Steinbock","Krebs","Zwillinge","Steinbock","Waage", "Steinbock","Zwillinge","Waage","Zwillinge","Wassermann")

table(sternzeichen) # Absolute Häufigkeiten

table(sternzeichen)/length(sternzeichen) # Relative Häufigkeiten

cumsum(1:10) # Kombinieren von Vektoren

?barplot

barplot(sort(table(sternzeichen)))

pie(table(sternzeichen))

hobbies = c("f", "f", "f", "f", "f", "b", "b", "i", "i", "i", "i", "i", "i", "i", "s", "l", "l", "l", "g", "g", "g", "g")

table(hobbies)

length(hobbies)

table(hobbies)/ length(hobbies)

barplot(table(hobbies))
