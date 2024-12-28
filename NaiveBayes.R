library(e1071)

# Train Naive Bayes
nb_model <- naiveBayes(severity ~ ., data = data.frame(train_data_numeric, severity = train_data$severity))

# Predict on test data
nb_predictions <- predict(nb_model, newdata = data.frame(test_data_numeric))

# Evaluate Performance
conf_matrix <- table(Predicted = nb_predictions, Actual = test_data$severity)
print("Confusion Matrix:")
print(conf_matrix)

accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))
