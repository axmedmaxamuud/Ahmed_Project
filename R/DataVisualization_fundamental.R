## Data Visualization
rm(list = ls())
today <- Sys.Date()

# load packages
library(tidyverse)
library(ggplot2)
library(readxl)
library(openxlsx)

# load data
data <- read_excel("input/data/survey_data.XLSX")

# First chart (Bar chart with proportions % for two variables)
data %>% 
  ggplot()+
  aes(gender, fill = hh_head)+
  geom_bar(position = "dodge")+
  # add title and fix labs
  labs(x = "", y = "proportion (%)", title = "Household Head by Gender",
       subtitle = "% of household heads by their gender", caption = "©Organization Name, Data")+
  # adding theme
  theme_minimal()+
  theme(legend.position = "top")

