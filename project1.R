library(tidyverse)
library(magick)

# setting up image variables
explosion_url = "https://static.vecteezy.com/system/resources/previews/027/292/456/original/bomb-explosion-with-fire-flames-and-smoke-isolated-on-transparent-background-png.png"
explosion_image = image_read(explosion_url)
emotions = c(":)", ":|", ":/", ":(", "x(")
circle_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Circle_-_black_simple.svg/800px-Circle_-_black_simple.svg.png"
happy_people_url = "https://t3.ftcdn.net/jpg/04/84/87/34/360_F_484873483_hg1ofIdXbMha5lKEDG3hJBrwKh1oikTq.jpg"
happy_people = image_read(happy_people_url) %>% image_scale(500)

# image manipulation
face_image = image_read(circle_url) %>%
  image_scale(500)
meme_text_linux = image_blank(height = 500,
                        width = 500,
                        color = "black") %>%
            image_annotate(font = "comic sans", gravity = "North", color = "white", text = "Linux users:\nbuilding from source", size = 50)
meme_text_windows = image_blank(width = 500,
                                height = 500,
                                color = "black") %>%
  image_annotate(font = "comic sans", gravity = "center", color = "white", text = "Everyone else:\ninstalling R packages", size = 50)

#animation for Linux half
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

# making the different rows requiring for the GIF
first_row = c(happy_people, meme_text_windows) %>% 
  image_append()
second_row = c(frame1, meme_text_linux) %>% 
  image_append()
second_row2 = c(frame2, meme_text_linux) %>% 
  image_append()
second_row3 = c(frame3, meme_text_linux) %>% 
  image_append()
second_row4 = c(frame4, meme_text_linux) %>% 
  image_append()
second_row5 = c(frame5, meme_text_linux) %>% 
  image_append()
second_row6 = c(frame6, meme_text_linux) %>% 
  image_append()

# creation of the different frames of the meme
meme = c(first_row, second_row) %>%
  image_append(stack = TRUE)
meme2 = c(first_row, second_row2) %>%
  image_append(stack = TRUE)
meme3 = c(first_row, second_row3) %>%
  image_append(stack = TRUE)
meme4 = c(first_row, second_row4) %>%
  image_append(stack = TRUE)
meme5 = c(first_row, second_row5) %>%
  image_append(stack = TRUE)
meme6 = c(first_row, second_row6) %>%
  image_append(stack = TRUE)

# making frames for animation
frames = c(meme, meme2, meme3, meme4, meme5, meme6)
animation = frames %>%
  image_animate()
# the animation
animation

# the finalized meme and GIF
my_meme = meme %>%
  image_write('my_meme.png')
my_animation = animation %>%
  image_write('my_animation.gif')
my_meme
my_animation

