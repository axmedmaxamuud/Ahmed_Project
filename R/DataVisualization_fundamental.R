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

### Table demonistration

# Install and load the necessary packages
install.packages("gt")
library(gt)

# Sample data
data <- data.frame(
  gender = c("Male", "Female", "Male", "Male", "Female", "Female", "Male", "Female"),
  activity = c("Walking", "Running", "Walking", "Running", "Walking", "Running", "Walking", "Running"),
  food_security = c(5, 6, 4, 7, 3, 8, 5, 6)
)

# Create an empty table
tbl <- gt()

# Group the data and calculate the sum of food security scores
tbl <- data %>%
  group_by(gender, activity) %>%
  summarise(food_security_sum = sum(food_security))

# Categorize food security scores
tbl$food_security_category <- cut(tbl$food_security_sum, breaks = c(0, 10, 15, Inf), labels = c("Low", "Medium", "High"), right = FALSE)

# Add the grouped data to the table
tbl <- gt(tbl) %>%
  tab_header(title = "Food Security Scores by Gender and Activity") %>%
  cols_label(gender = "Gender", activity = "Activity", food_security_sum = "Food Security Score", food_security_category = "Category")

# Print the final table
print(tbl)

# version with %

# Install and load the necessary packages
install.packages("gt")
library(gt)

# Sample data
data <- data.frame(
  gender = c("Male", "Female", "Male", "Male", "Female", "Female", "Male", "Female"),
  activity = c("Walking", "Running", "Walking", "Running", "Walking", "Running", "Walking", "Running"),
  food_security = c(5, 6, 4, 7, 3, 8, 5, 6)
)

# Create an empty table
tbl <- gt()

# Group the data and calculate the proportions of food security scores
tbl <- data %>%
  group_by(gender, activity) %>%
  summarise(count = n(), food_security_prop = sum(food_security) / sum(count) * 100)

# Add the grouped data to the table
tbl <- gt(tbl) %>%
  tab_header(title = "Food Security Proportions by Gender and Activity") %>%
  cols_label(gender = "Gender", activity = "Activity", count = "Count", food_security_prop = "Proportion") %>%
  fmt_percent(columns = "food_security_prop", decimals = 2)

# Print the final table
print(tbl)












