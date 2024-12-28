# Load required library
library(rpart)
train_data <- gun_data_final[1:1000, ]
test_data <- gun_data_final[1001:1201, ]
# Train a Decision Tree model
dt_model <- rpart(
  severity ~ ., 
  data = train_data, 
  method = "class",
  control = rpart.control(maxdepth = 10)  # Limit depth
)

# Predict severity for the test data
test_predictions <- predict(dt_model, newdata = test_data, type = "class")

# Evaluate performance
conf_matrix <- table(Predicted = test_predictions, Actual = test_data$severity)
print(conf_matrix)

# Accuracy calculation
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))

