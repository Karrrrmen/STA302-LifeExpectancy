#### Preamble ####
# Purpose: Simulates data
# Author: Manjun Zhu
# Date: 21 September 2024
# Contact: karmen.zhu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have simulated data
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(here)
library(arrow)

#### Read data ####
# convert some columns to the appropriate data types
data <- read_csv("data/analysis_data/cleaned_data.csv")
data <- data %>%
  mutate(
    Country = as.factor(Country),
    Year = as.numeric(Year),
    LifeExpectancy = as.numeric(LifeExpectancy),
    Status = as.factor(Status),
    GDP = as.numeric(GDP),
    Diphtheria = as.numeric(Diphtheria),
    IncomeComposition = as.numeric(IncomeComposition),
    BMI = as.numeric(BMI),
    TotalExpenditure = as.numeric(TotalExpenditure)
  )

### Model data ####
# linear model for Developed Countries' Life Expectancy based on socioeconomic factors
lm_developed <- lm(LifeExpectancy ~ GDP + BMI + Diphtheria + IncomeComposition,
                   data = data %>% filter(Status == "Developed"))


# linear model for Developing Countries' Life Expectancy based on socioeconomic factors
lm_developing <- lm(LifeExpectancy ~ GDP + BMI + Diphtheria + IncomeComposition,
                    data = data %>% filter(Status == "Developing"))

# linear model for overall Life Expectancy based on socioeconomic factors
# Since Status is concluded in this model, first need to make it be numeric
data <- data %>%
  mutate(Status = as.numeric(Status))
lm_overall <- lm(LifeExpectancy ~ Status + GDP + BMI + Diphtheria + IncomeComposition, 
                 data = data)

#### Save model ####
saveRDS(lm_developed, here::here("models/lm_developed.rds"))
saveRDS(lm_developing, here::here("models/lm_developing.rds"))
saveRDS(lm_overall, here::here("models/lm_overall.rds"))
