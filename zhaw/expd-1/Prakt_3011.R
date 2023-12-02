# ---- GGPlot part 2 ----

library(ggplot2)
ggplot(mpg, aes(displ,hwy))+
  geom_point(aes(colour=class))+
  scale_x_continuous() + #Def.Skalax-Achse
  scale_y_continuous() + #Def.Skalay-Aches
  scale_colour_discrete() #Def.Farbskala

ggplot(mpg, aes(displ,hwy))+ geom_point(aes(colour=class))+ scale_x_continuous(name="Variabledispl")+ scale_y_continuous(name="Variablehwy")+ scale_colour_discrete()


ggplot(mpg,aes(displ, hwy)) +
  geom_point(aes(colour=class))+
  #Beschriftungx-Achse
  xlab("Variable displ")+ #Beschriftungy-Achse
  ylab("Variable hwy") + #BeschriftungLegende 
  labs(colour="TitelLegende")+ #PositionLegende 
  theme(legend.position="bottom") +
  ggtitle(label ="Titel") #Titel


ggplot(mpg, aes(displ,hwy))+ geom_point(aes(colour=class))+ scale_x_continuous( breaks=c(1.7,2.14,4.2,6.52,7.11) )


ggplot(mpg, aes(displ,hwy))+ geom_point(aes(colour=class))+ scale_x_continuous( breaks=c(1.7, 2.14,4.2,6.52,7.11), labels=LETTERS[1:5])


ggplot(mpg, aes(displ,hwy))+ geom_point(aes(colour=class))+ scale_x_sqrt() + scale_y_log10()


ggplot(mpg, aes(x =sqrt(displ), y=log10(hwy)))+ geom_point(aes(colour=class))+ labs(x=expression(sqrt(displ)), y=expression(log[10](hwy)))


# Colors
ggplot(mpg, aes(displ,hwy))+ geom_point(aes(colour=class))+ scale_color_manual(values= c("orangered", "palegreen", "magenta","rosybrown1", "gray27","wheat", "lightgoldenrod4"))


ggplot(mpg, aes(x =hwy,y=cty,color= displ))+ geom_point()


ggplot(mpg, aes(x =hwy,y=cty,color= displ))+ geom_point() + scale_x_continuous()+ scale_y_continuous()+ scale_color_gradient2( name="Hubraum[l]", labels=c('small', 'medium', 'large'), breaks=c(1.6,2,3), low= 'blue',mid= 'red',high= 'yellow', midpoint=4)


dat<-data.frame( manufacturer =c("lincoln", "mercury","dodge"), count=c(3,4,37))

ggplot(data = dat,aes(x=manufacturer,y=count, fill= count))+ geom_col()

ggplot(data =dat,aes(x=manufacturer,y=count, fill= count))+ geom_col()+ coord_flip()

ggplot(data =dat,aes(x=manufacturer,y=count, fill= count_()))+ geom_col()+ coord_polar()


# Faceting
ggplot(mpg, aes(displ,hwy))+ geom_point(size= 0.5)+ facet_wrap(facets= ~manufacturer)


ggplot(mpg, aes(displ,hwy)) + geom_point(size= 0.5)+ facet_grid(. ~drv) #Alternativefacet_grid(cols=vars(drv))


ggplot(mpg,aes(displ,hwy))+ geom_point(size =0.5)+ facet_grid(drv ~.) #Alternativefacet_grid(rows=vars(drv))


ggplot(mpg, aes(displ,hwy))+ geom_point(size=0.5)+ facet_grid(.~cut(cty,5)) #cty=citymilespergallon


ggplot(mpg, aes(displ,hwy))+ geom_point(size= 0.5)+ facet_grid(drv ~cyl)


ggplot(mpg, aes(displ,hwy))+ geom_point(size= 0.5)+ facet_wrap(facets= drv ~cyl)


# Themes
ggplot(mpg, aes(x=displ,y=hwy))+ geom_point(aes(colour=class))+ theme_grey() #default


ggplot(mpg, aes(x=displ,y=hwy))+ geom_point(aes(colour=class))+ theme_bw()


ggplot(mpg, aes(x=displ,y=hwy))+ geom_point(aes(colour=class))+ theme_dark()


install.packages("ggthemes") #einmalausführen
library(ggthemes)

ggplot(mpg, aes(x =displ, y=hwy))+ geom_point(aes(colour=class))+ theme_tufte()


ggplot(mpg, aes(x =displ, y=hwy))+ geom_point(aes(colour=class))+ theme_economist()


ggplot(mpg, aes(x =displ, y=hwy))+ geom_point(aes(colour=class))+ theme_excel()

# theme_grey<-function(base_size=11,base_family=""){ Definiton derThemeElemente}
ggplot(mpg, aes(x =displ, y=hwy))+ geom_point(aes(colour=class))+ theme_grey(base_size=30)

ggplot(mpg, aes(x= displ, y=hwy,shape=drv, colour=class))+
  geom_point() +
  ggtitle('Titelinmono')+
  theme(plot.title=element_text(family = 'mono'), axis.line.x =element_line(linetype=4, colour= 'red',linewidth=3), panel.background= element_rect(fill= rgb(0.596,1, 0.8)), panel.grid= element_blank())


theme_custom <- function() {
  theme_bw(base_size=12, base_family= "Times") %+replace%
    theme(
      axis.line.x=element_line(linetype=4,colour= 'red',linewidth=3),
      panel.background=element_rect(fill=rgb(0.596,1,0.8)),
      panel.grid=element_blank(),
    )
}

ggplot(mpg, aes(x =displ,y=hwy, shape=drv, colour=class))+ geom_point() + ggtitle('TitelinTimes') + theme_custom()




# ---- Aufgabe 1 ----

ggplot(diamonds, aes(x=price, y=carat)) +
  geom_point() +
  facet_grid(cut ~color)

# ---- Aufgabe 2 ----

load('./data/EconomistData.Rdata')

str(EconomistData)

countries <- sample(EconomistData$Country, 5)

reduced <- EconomistData[EconomistData$Country %in% countries,]

install.packages('ggrepel')
library(ggrepel)

ggplot(EconomistData, aes(x=CPI, y=HDI)) +
  geom_point(shape=1, size=3) +
  geom_smooth(method='lm', color='red') +
  geom_text_repel(data = reduced, mapping = aes(label = Country))

# ---- Aufgabe 3 ----
load('./data/trees.Rdata')

str(trees)

sort(table(trees$type))

tree_types <- c('domestica', 'platanoides', 'x hispanica', 'betulus', 'hippocastanum', 'pendula', 'excelsior', 'pseudoacacia', 'baccata', 'abies')

trees <- trees[trees$type %in% tree_types,]


library(ggmap) # muss installiert sein
library(tmaptools) # muss installiert sein
register_stadiamaps('3f745b26-0f44-4aab-9921-e5b617ab44cb') # bbox vonZ ürich
bbox_zurich<-rbind(as.numeric(paste(geocode_OSM("Zurich")$bbox)))
map_zurich<-get_stadiamap(bbox_zurich,zoom=13) ##Kartezeichnen
ggmap(map_zurich,extent= 'device')+
  geom_point(data=trees, mapping = aes(x=long, y=lat, color=type), size=2, alpha=0.4)+
  facet_wrap(.~type)
