library(tidyverse)
library(magick)
explosion_url = "https://static.vecteezy.com/system/resources/previews/027/292/456/original/bomb-explosion-with-fire-flames-and-smoke-isolated-on-transparent-background-png.png"
explosion_image = image_read(explosion_url)
emotions = c(":)", ":|", ":/", ":(", "x(")
circle_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Circle_-_black_simple.svg/800px-Circle_-_black_simple.svg.png"
face_image = image_read(circle_url) %>% image_scale(500)

frame1 = face_image %>% 
  image_annotate(text=emotions[1], size = 100, gravity="center", degrees = 90) %>% 
  image_scale(500) %>%
  image_extent("500x500")

frame2 = face_image %>% 
  image_annotate(text=emotions[2], size = 100, gravity="center", degrees = 90) %>% 
  image_scale(400) %>%
  image_extent("500x500")

frame3 = face_image %>% 
  image_annotate(text=emotions[3], size = 100, gravity="center", degrees = 90) %>% 
  image_scale(300) %>%
  image_extent("500x500")

frame4 = face_image %>% 
  image_annotate(text=emotions[4], size = 100, gravity="center", degrees = 90) %>% 
  image_scale(200) %>%
  image_extent("500x500")

frame5 = face_image %>% 
  image_annotate(text=emotions[5], size = 100, gravity="center", degrees = 90) %>% 
  image_scale(100) %>%
  image_extent("500x500")

frame6 = explosion_image %>%
  image_scale(500) %>%
  image_extent("500x500")

frames = c(frame1,frame2,frame3,frame4,frame5,frame6)
animation = image_animate(frames, fps=5)
animation