# Load required libraries
library(caret)
library(randomForest)

# ---- Step 1: Reduce Data Size for Faster Training

# Set seed for reproducibility
set.seed(123)

# Reduce training and test data size for initial testing
sample_size_train <- 5000  # Reduced training rows
sample_size_test <- 1000   # Reduced testing rows

# Ensure reproducible random sampling
train_data <- train_data[sample(nrow(train_data), sample_size_train), ]
test_data <- test_data[sample(nrow(test_data), sample_size_test), ]

# ---- Step 2: Train a Random Forest Model

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

# ---- Step 3: Evaluate Model Performance

# Predict on the test set
test_predictions <- predict(rf_model, newdata = test_data)

# Convert predictions and actual values to factors with the same levels
test_predictions <- factor(test_predictions, levels = levels(test_data$severity))
test_data$severity <- factor(test_data$severity, levels = levels(test_predictions))

# Confusion matrix to evaluate the model
conf_matrix <- confusionMatrix(test_predictions, test_data$severity)
print(conf_matrix)


# ---- Step 4: Final Output ----

# Combine test predictions with actual values for comparison
test_results <- data.frame(
  Actual = test_data$severity,
  Predicted = test_predictions
)

# View the test results
head(test_results)

# ---- Step 5: Visualizations ----

# 1. Confusion Matrix Heatmap
library(ggplot2)
library(reshape2)

conf_matrix_table <- as.table(conf_matrix$table)
conf_matrix_df <- as.data.frame(conf_matrix_table)
colnames(conf_matrix_df) <- c("Prediction", "Reference", "Frequency")

ggplot(conf_matrix_df, aes(x = Prediction, y = Reference)) +
  geom_tile(aes(fill = Frequency), color = "white") +
  scale_fill_gradient(low = "white", high = "blue") +
  geom_text(aes(label = Frequency), color = "black") +
  labs(
    title = "Confusion Matrix Heatmap",
    x = "Predicted Class",
    y = "Actual Class",
    fill = "Frequency"
  ) +
  theme_minimal()

# 2. Feature Importance Plot
varImp_rf <- varImp(rf_model)
plot(varImp_rf, main = "Feature Importance from Random Forest")

# 3. Predicted vs Actual Distribution
ggplot(test_results, aes(x = Actual, fill = Predicted)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Distribution of Actual vs Predicted Classes",
    x = "Actual Class",
    fill = "Predicted Class"
  ) +
  theme_minimal()
