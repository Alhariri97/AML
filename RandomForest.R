# Load required libraries
library(caret)
library(randomForest)

# ---- Step 6: Reduce Data Size for Faster Training

# Set seed for reproducibility
set.seed(123)

# Reduce training and test data size for initial testing
sample_size_train <- 5000  # Reduced training rows
sample_size_test <- 1000   # Reduced testing rows

# Ensure reproducible random sampling
train_data <- train_data[sample(nrow(train_data), sample_size_train), ]
test_data <- test_data[sample(nrow(test_data), sample_size_test), ]

# ---- Step 7: Train a Random Forest Model

# Define training control for cross-validation
train_control <- trainControl(
  method = "cv",  # Cross-validation
  number = 3,     # Reduced number of folds to speed up training
  verboseIter = TRUE # Show progress during training
)

# Train Random Forest model to predict severity
rf_model <- train(
  severity ~ .,
  data = train_data,
  method = "rf",
  trControl = train_control,
  tuneLength = 2 # Reduced tuneLength for faster training
)

# Print model summary
print(rf_model)

# ---- Step 8: Evaluate Model Performance

# Predict on the test set
test_predictions <- predict(rf_model, newdata = test_data)

# Convert predictions and actual values to factors with the same levels
test_predictions <- factor(round(test_predictions), levels = 1:5)
test_data$severity <- factor(test_data$severity, levels = 1:5)

# Confusion matrix to evaluate the model
conf_matrix <- confusionMatrix(test_predictions, test_data$severity)
print(conf_matrix)

# ---- Step 9: Feature Importance

# Plot feature importance
varImp_rf <- varImp(rf_model)
plot(varImp_rf)

# ---- Step 10: Final Output

# Combine test predictions with actual values for comparison
test_results <- data.frame(
  Actual = test_data$severity,
  Predicted = test_predictions
)

# View the test results
head(test_results)
