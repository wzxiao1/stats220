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
  mutate(high_number_of_views = ifelse(views > mean(views), "high", "low"))
  select(views, likes, comments, imageSize, big_image, likes_per_view_percentage, comments_per_view_percentage, previewURL, pageURL, high_number_of_views) %>%
  filter(big_image == "big")

glimpse(selected_photos)

selected_photos_csv = write_csv(selected_photos, "selected_photos.csv")

mean_likes <- selected_photos$likes %>% mean(na.rm = TRUE)
mean_views <- selected_photos$views %>% mean(na.rm = TRUE)
mean_likes_per_view_percentage <- selected_photos$likes_per_view_percentage %>% mean(na.rm = TRUE)

summary_values <- selected_photos %>%
  group_by(high_number_of_views) %>%
  summarise(mean_likes = mean(likes))

summary_values



selected_photos %>%
  ggplot() +
  geom_bar(aes(x = high_number_of_views, fill = big_image)) +
  labs(title = "Big or smaller images get higher views?",
       subtitle = "comparing the proportion of high view and low view of big and small sized images",
       caption = "selected photos",
       x = "high_number_of_views",
       y = "count")


urls <- selected_photos %>%
  pull(previewURL)

animation <- urls %>%
  image_read() %>%
  image_scale(500) %>%
  image_animate(fps = 5)

animation

my_animation = animation %>%
  image_write('my_photos.gif') # saved as GIF
