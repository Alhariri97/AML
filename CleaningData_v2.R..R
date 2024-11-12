# Load required packages
# install.packages("tidyverse")
# if you got error : cannot open file 'Gun_violence.csv': No such file or directory
# set the path to your dataset directory: 
# Use getwd() to get the current path. 
# setwd("C:/path/to/your/dataset")

# if you got error: Error in library(tidyverse) : there is no package called ‘tidyverse’ 
# insall the package by runing : install.packages("tidyverse")

######################################################################
# This code only to Extract the first 100 rows and save it           #
#so i can push a small sample of the dataset to github               #
#data_sample <- data[1:100, ]                                        #
# Save the 100-row sample as a new CSV file                          #
# write.csv(data_sample, "data_sample_100.csv", row.names = FALSE)   #
######################################################################

library(tidyverse)

# Read the dataset
data <- read.csv("Gun_violence.csv", header = TRUE)

# Initial data inspection
View(data)    # Opens the data viewer to see the raw dataset
glimpse(data) # Gives a concise summary of the data structure

# Check for missing values across columns
colSums(is.na(data))

# I started with deleting coloumns that has no values.. after having a look at the dataset.
data <- data %>% select(-gun_stolen)

#Imputation (instead of dropping columns with missing values)

# It's likely that missing values in this column could mean no guns were involved.
data$n_guns_involved[is.na(data$n_guns_involved)] <- 0

# For missing coordinates, I used the mean of the existing values
data$latitude[is.na(data$latitude)] <- mean(data$latitude, na.rm = TRUE)
data$longitude[is.na(data$longitude)] <- mean(data$longitude, na.rm = TRUE)

# These fields may have missing values that can be filled using the median district number.
data$state_senate_district[is.na(data$state_senate_district)] <- median(data$state_senate_district, na.rm = TRUE)
data$state_house_district[is.na(data$state_house_district)] <- median(data$state_house_district, na.rm = TRUE)

# After Imputation: Checking again for any remaining missing values
colSums(is.na(data))  # Should now show 0 missing values for the imputed columns

 

# Final View of the Cleaned Data
View(data)  # View the updated dataset with imputed values

# Use na.omit() to clean up any rows that have missing values in other columns
data_clean <- na.omit(data)

# View the final cleaned data
View(data_clean)

# Add a casualties column: 1 if there are any casualties, 0 otherwise
data_clean <- data_clean %>%
  mutate(casualties = ifelse(n_killed > 0 | n_injured > 0, 1, 0))


# Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(data_clean), 0.7 * nrow(data_clean))
train_data <- data_clean[train_indices, ]
test_data <- data_clean[-train_indices, ]



# install.packages("randomForest")
if (!require(randomForest)) install.packages("randomForest")

# Load the randomForest library
library(randomForest)

# Ensure the target variable is a factor for classification
data_clean$casualties <- as.factor(data_clean$casualties)

# Fit a Random Forest classification model
rf_model <- randomForest(casualties ~ n_killed + n_injured + latitude + longitude +
                           state_senate_district + state_house_district + n_guns_involved,
                         data = data_clean, ntree = 100)

# View the model results
print(rf_model)
