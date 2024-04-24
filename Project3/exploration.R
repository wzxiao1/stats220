library(tidyverse)
library(jsonlite)
library(magick)
json_data <- fromJSON("pixabay_data.json")
pixabay_photo_data <- json_data$hits
glimpse(pixabay_photo_data)


selected_photos <- pixabay_photo_data %>%
  mutate(big_image = ifelse(imageSize > mean(imageSize) + 750000, "big", "small")) %>%
  mutate(likes_per_view_percentage = 100 * likes/views) %>%
  mutate(comments_per_view_percentage = 100 * comments/views) %>%
  select(views, likes, comments, imageSize, big_image, likes_per_view_percentage, comments_per_view_percentage, previewURL, pageURL) %>%
  filter(big_image == "big")

glimpse(selected_photos)

selected_photos_csv = write_csv(selected_photos, "selected_photos.csv")

mean_likes <- selected_photos$likes %>% mean(na.rm = TRUE)
mean_views <- selected_photos$views %>% mean(na.rm = TRUE)
mean_likes_per_view_percentage <- selected_photos$likes_per_view_percentage %>% mean(na.rm = TRUE)

summary_values <- selected_photos %>%
  summarise(mean_likes,
            mean_views,
            mean_likes_per_view_percentage)

urls <- selected_photos %>%
  pull(previewURL)

urls

animation <- urls %>%
  image_read() %>%
  image_scale(500)%>%
  image_append() %>%
  image_animate()

animation

my_animation = animation %>%
  image_write('my_animation.gif') # saved as GIF

