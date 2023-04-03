## Preparing data for the project
rm(list = ls())
today <- Sys.Date()

# load required packages
library(tidyverse)
library(openxlsx)
library(readxl)
library(xlsformfill)

# load xlsx tool
questions <- read.csv("input/tool/questions.csv", 
                      stringsAsFactors = F, check.names = F)

choices <- read.csv("input/tool/choices.csv",
                    stringsAsFactors = F, check.names = F)

# generate dumpy data
data <- xlsform_fill(questions, choices, n = 500)

# export data
write.xlsx(data, paste0("input/data/survey_data_",today,".XLSX"))
