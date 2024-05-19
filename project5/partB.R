library(tidyverse)
library(rvest)

# selected David Seymour


url <- "https://www.beehive.govt.nz/minister/hon-david-seymour"


# in the releases there are high frequency use of quotation marks to quote from the ministers, 
# releases end with a link for further/additional information for the topic
# 
pages <- read_html(url) %>%
  html_elements(".release__wrapper") %>%
  html_elements("h2") %>%
  html_elements("a") %>%
  html_attr("href") %>%
  paste0("https://www.beehive.govt.nz", .)

pages
