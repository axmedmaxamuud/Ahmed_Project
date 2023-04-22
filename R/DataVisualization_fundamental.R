## Data Visualization
rm(list = ls())
today <- Sys.Date()

# load packages
library(tidyverse)
library(ggplot2)
library(scales)
library(readxl)
library(openxlsx)

# load data
data <- read_excel("input/data/survey_data.XLSX") %>% 
  mutate(ki_age = case_when(
    age >= 18 & age <= 59 ~ "18 - 59 Years",
    age > 59 ~ "60+ Years"
  )) %>% group_by(gender) %>% 
  summarise(total = n()) %>% 
  mutate(gender_pct = round(total / 500 * 100, digits = 2))

# define color codes
wfp_blue <- "#0A6EB4"
wfp_aque <- "#26bde2"

# creating bar chart
data %>% 
  ggplot()+
  # define aesthetics
  aes(x = gender, y = gender_pct, fill = gender)+
  # define geometries 
  geom_col()+
  geom_text(aes(label = gender_pct), hjust = 0.1)+
  # applying brand colors
  scale_fill_manual(values = c(female = wfp_aque, male = wfp_blue))+
  # adding title and subtitles
  labs(title = "Household head by Gender", 
       subtitle = "% of household heads by their gender", 
       caption = "©WFP Somalia, Outcome Monitoring 2023", fill = "Gender")+
  # apply theme
  theme_void()+
  theme(legend.position = "top")
  
# save chart in png and pdf formats
ggsave(filename = "output/charts/gender_bar_chart.png",
       height = 8,
       width = 11,
       units = "in",
       dpi = 300)

# save the chart in pdf format
ggsave(filename = "output/charts/gender_bar_chart.pdf",
       height = 8,
       width = 11)


