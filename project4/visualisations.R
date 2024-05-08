library(tidyverse)
library(magick)


youtube_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT-v3QLYeeNHZzaO-JCrye8ex_GZWSqvhFc9v4_Uqmvd6Osu8H06k4Z1ih0jrZjYmJgdL6Rd5bhJcNn/pub?output=csv") %>%
  mutate(likes_per_view = likeCount/viewCount) %>%
  mutate(title_with_biden = ifelse(str_detect(title, "Biden"), "true", "false")) %>%
  mutate(time_line = datePublished %>% str_sub(1, 4) %>% parse_number()) %>%
  arrange(datePublished)


# df where title has biden in it
biden_df <- youtube_data %>%
  filter(title_with_biden == "true") %>%
  count(channelName, time_line)

biden_df



# number of videos on each side with Biden in it
summary_values <- youtube_data %>%
  filter(title_with_biden == "true") %>%
  group_by(channelName) %>%
  summarise(n = n())

summary_values

# frequency of biden values being published

pie_chart = summary_values %>%
  ggplot() +
  geom_bar(aes(x = "", y = n, fill = channelName), stat = "identity") +
  coord_polar("y", start = 0) +
  theme_minimal() +
  labs(title = "Pie chart of number of videos\n with Biden in the title of \nFox News and MSNBC videos",
       x = "", y = "",
       caption = "Total 38")


pie_chart

bar_charts = ggplot(biden_df) +
  geom_bar(aes(x = time_line, y = n, fill = channelName),
           stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Time line of \nBiden in title of Fox and MSNBC videos",
                                     x = "Year Published",
                                     y = "Frequency")



box_whisker = youtube_data %>%
  ggplot() +
  geom_boxplot(aes(x = likes_per_view,
                   y = channelName,
                   colour = channelName)) + 
  theme_minimal() +
  labs(title = "Likes per view Box plot of \nFoxNews and MSNBC Youtube",
       x = "likes per view",
       y = "Channel Names")



