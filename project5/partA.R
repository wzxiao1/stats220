library(tidyverse)
library(rvest)

# My data context is the weather of New Zealand
# url of weather site for today's weather in nz
url = "https://weather.com/en-NZ/weather/today/l/NZXX0049:1:NZ?Goto=Redirected"
# by changing "today" to "hourbyhour", "weekend", or "monthly" we can get data for different periods of time

page = read_html(url)

current_temp = page %>%
  html_element("div") %>%
  html_element(".CurrentConditions--tempValue--MHmYY") %>%
  html_text2()

current_conditions = page %>%
  html_element("div") %>%
  html_element(".CurrentConditions--phraseValue--mZC_p") %>%
  html_text2()

current_air_quality = page %>%
  html_element("div") %>%
  html_element(".AirQualityText--severity--W9CtX") %>%
  html_text2()

location = page %>%
  html_element("div") %>%
  html_element(".CurrentConditions--location--1YWj_") %>%
  html_text2()

# concatenation of every object ran into a sentence
current_temp
current_conditions
current_air_quality
location
paste0("In ", location, " the temperature now is ", current_temp, "C, ", "the day is looking ", current_conditions, " with ", current_air_quality, " air quality")
