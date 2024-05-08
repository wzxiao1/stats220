intro = image_blank(width = 1200,
                    height = 400,
                    color = "white") %>% 
  image_annotate(font = "Helvetica", gravity = "center", color = "turquoise", text = "Fun data exploration into \nFoxNews and MSNBC channels\n with William", size = 50)

image_annotate()

slide1 = image_blank(width = 1200, 
                     height = 400,
                     color = "white") %>% 
  image_annotate(font = "Helvetica", gravity = "center", color = "turquoise", text = "That pie chart showed the proportions of Biden in title of Fox and MSNBC videos\n With a total of 38\n31.58% was from MSNBC\n68.42% was from FoxNews\n We can see Fox has a larger proportional of videos dedicated to Biden then MSNBC", size = 25)


slide2 = image_blank(width = 1200,
                     height = 400,
                     color = "white") %>% 
  image_annotate(font = "Helvetica", gravity = "center", color = "turquoise", text = "That bar chart displays the frequency of vidoes with Biden in it by\n Fox and MSNBC from 2020 to 2024 with their values side by side", size = 25)

slide3 = image_blank(width = 1200,
                     height = 400,
                     color = "white") %>% 
  image_annotate(font = "Helvetica", gravity = "center", color = "turquoise", text = "The box and whisker graph shows the quartiles of the likes to view ratio of FOX and MSNBC Biden videos", size = 25)

final = image_blank(width = 1200,
                    height = 400,
                    color = "white") %>% 
  image_annotate(font = "Helvetica", gravity = "center", color = "turquoise", text = "In conclusion, it would seem like that fox has a higher proportion of videos with Biden in the title \n a higher posting frequency throughout the 2020\n and on top of that has a higher mean likes to view ratio\n then MSNBC", size = 20)


pie = ggsave("pie.png", pie_chart,
             width = 5,
             height = 2)



bar = ggsave("bar.png", bar_charts,width = 5,
             height = 2)
box = ggsave("boxw.png", box_whisker, width = 5,
             height = 2)


pie_img = image_read(pie) %>%
  image_scale("1200 x 400")

bar_img = image_read(bar) %>%
  image_scale("1200 x 400")

box_img = image_read(box) %>%
  image_scale("1200 x 400")


frames = c(intro, intro, intro, intro, intro, pie_img, pie_img, pie_img, pie_img, pie_img, pie_img, slide1, slide1, slide1, slide1, slide1, bar_img, bar_img, bar_img, bar_img, bar_img, slide2, slide2, slide2, slide2, slide2, box_img, box_img, box_img, box_img, box_img, slide3, slide3, slide3, slide3, slide3, final, final, final, final, final)


animation = frames %>%
  image_animate(fps = 1)


animation

my_animation = animation %>%
  image_write('data_story.gif')