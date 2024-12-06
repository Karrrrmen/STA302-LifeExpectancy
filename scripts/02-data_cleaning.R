#### Preamble ####
# Purpose: Cleans the raw marriage data into an analysis dataset
# Author: Manjun Zhu
# Date: 26 September 2024
# Contact: karmen.zhu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have simulated data
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)
data <- read_csv("data/raw_data/LifeExpectancyData.csv")

#### Rename column
colnames(data)[colnames(data) == "Life expectancy"] <- "LifeExpectancy"
colnames(data)[colnames(data) == 
                 "Income composition of resources"] <- "IncomeComposition"
colnames(data)[colnames(data) == "Total expenditure"] <- "TotalExpenditure"

#### Clean data ####
data <- selected_columns <- data[, c("Country", "Year", "LifeExpectancy", "Status", "GDP", "IncomeComposition",
                                                "Polio", "Diphtheria","TotalExpenditure", "BMI")]

#### Remove NA data ####
data <- na.omit(data)

#### Save data ####
write_csv(data, "data/analysis_data/cleaned_data.csv")
