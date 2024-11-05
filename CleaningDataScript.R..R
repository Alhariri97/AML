# Make sure you're reading the correct path 
# setwd("C:/path_to_your_file")


library(tidyverse)
data <- read.csv("Gun_violence.csv", header=TRUE)
View(data)  # To View data in Data Viewer.

glimpse(data)

data %>% select(state) 



sum(is.na(data)) 
colSums(is.na(data))

# unique(data$state) ## Check for a


data_clean_1 <- data %>% select(-n_guns_involved) #Remove Specific Columns / n_guns_involved has 99451 empty values. 
data_clean_2 <- data_clean_1 %>% select(-state_senate_district ) #Remove Specific Columns / state_senate_district  has 32335  empty values. 
data_clean_3 <- data_clean_2 %>% select(-state_house_district ) #Remove Specific Columns / state_house_district  has 38772  empty values. 

View(data)  # To View data in Data Viewer.
View(data_clean_1)  # To View data in Data Viewer.
View(data_clean_2)  # To View data in Data Viewer.
View(data_clean_3)  # To View data in Data Viewer.
data_clean <- na.omit(data_clean_3) # Remove Rows with Missing Values

View(data_clean)  # To View data in Data Viewer.


# V1