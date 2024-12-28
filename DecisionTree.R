library(rpart)
library(rpart.plot)

# Train Decision Tree
dt_model <- rpart(severity ~ ., data = data.frame(train_data_numeric, severity = train_data$severity), method = "class")

# Visualize the Tree
rpart.plot(dt_model, type = 2, extra = 104, under = TRUE, varlen = 0, faclen = 0)

# Predict on Test Data
dt_predictions <- predict(dt_model, newdata = data.frame(test_data_numeric), type = "class")

# Evaluate Performance
conf_matrix <- table(Predicted = dt_predictions, Actual = test_data$severity)
print("Confusion Matrix:")
print(conf_matrix)

accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))
