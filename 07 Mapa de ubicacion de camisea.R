library(raster)
library(sf)
library(ggplot2)
library(png)
library(grid)
library(ggimage)
sites <- data.frame(longitude = c(-72.9451),latitude = c(-11.7175),name= c("CAMISEA"))
Peru   <- getData('GADM', country='Peru', level=1) %>% st_as_sf() 
SurAmerica <- st_read ("SHP/SurAmerica.shp")
SurAmeric  <- st_transform(SurAmerica  ,crs = st_crs("+proj=longlat +datum=WGS84 +no_defs"))
d <- data.frame(longitude = c(-72.9451),latitude = c(-11.7175),name= c("CAMISEA"),
                image = sample(c("PNG/point1.png")))
img <- readPNG("PNG\\Cap.png", FALSE)
g <- rasterGrob(img, x = unit(0.1, "npc"),y = unit(0.9, "npc"), width = unit(0.2, "npc"))
long.eur <- c(-82, -76, -76, -82)
lat.eur <- c(-15, -15, -20, -20)
group <- c(1, 1, 1, 1)
latlong.eur <- data.frame(long.eur, lat.eur, group)


Map =ggplot()+
  geom_sf(data=SurAmeric , fill="gray90", color="white")+
  geom_sf(data=Peru, fill="gray81", color="white")+
  geom_image(data = d, aes( longitude, y = latitude, image = image), size = 0.06) +
  geom_polygon(data=latlong.eur, aes(long.eur, lat.eur, group=group), fill = NA, color = "red", 
               linetype = "dashed", size = 0.3, alpha = 0.8)+
  coord_sf(xlim = c(-82, -68.5), ylim = c(-20,1))+
  #geom_sf_text(data = st_as_sf(SurAmeric), aes(label =  NOMBRE), size = 1.8) 
  annotate(geom = "text", x = -80, y = -10, label = "Pacific \nOcean", fontfamily = "serif", color = "grey22", size = 3)+
  annotate(geom = "text", x = -78, y = -2, label = "Ecuador", fontfamily = "serif", color = "grey22", size = 3)+
  annotate(geom = "text", x = -72, y = -1, label = "Colombia", fontfamily = "serif", color = "grey22", size = 3)+
  annotate(geom = "text", x = -70, y = -7, label = "Brasil",fontfamily = "serif", color = "grey22", size = 3)+
  annotate(geom = "text", x = -74, y = -5, label = "Peru",fontfamily = "serif", color = "black", size = 4.3)+
  annotate(geom = "text", x = -72.9451, y = -13, label = "Camisea",fontfamily = "serif", color = "red", size = 3)+
  annotate(geom = "text", x = -79, y = -17, 
           label = "Miembros Consorcio Camisea: \nPluspetrol (27.2%) \nHunt Oli (25.1%) \nSk Innovation (17.6%) \nRepsol (10%) \nTecpetrol (10%) \nSonatrach (10%)",
           fontfamily = "serif", color = "black", size = 4)+
  geom_segment(aes(x=-76, xend=-72.9451, y=-15, yend=-11.7175), 
               linetype = "dashed", color = "red", size = 0.3) +
  theme_void()+
  theme(panel.background = element_rect(fill = "white"))+
  annotation_custom(g)

ggsave(plot = Map,"MAPAS/Camisea.png",
       units = "cm", width = 21,height = 29, dpi = 900)# guardar grafico
