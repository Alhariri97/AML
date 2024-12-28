library(class)
library(caret)
library(kknn)

# ---- Step 1: Data Preparation ----
train_data <- gun_data_final[1:10000, ]
test_data <- gun_data_final[10001:12000, ]

train_data$severity <- as.factor(train_data$severity)
test_data$severity <- as.factor(test_data$severity)

# Convert categorical variables to numeric and scale
train_data_numeric <- scale(model.matrix(~ . - 1, data = train_data[, -ncol(train_data)]))  # Exclude severity
test_data_numeric <- scale(model.matrix(~ . - 1, data = test_data[, -ncol(test_data)]))

# Remove near-zero variance columns
nzv <- nearZeroVar(train_data_numeric, saveMetrics = TRUE)
train_data_numeric <- train_data_numeric[, !nzv$nzv]
test_data_numeric <- test_data_numeric[, !nzv$nzv]

# ---- Step 2: Dimensionality Reduction ----
pca_train <- prcomp(train_data_numeric, center = TRUE, scale. = TRUE)
num_components <- min(5, ncol(pca_train$x))  # Reduce to 5 components
train_data_pca <- pca_train$x[, 1:num_components]
test_data_pca <- predict(pca_train, newdata = test_data_numeric)[, 1:num_components]

# ---- Step 3: Run Weighted KNN ----
knn_model <- kknn(
  severity ~ ., 
  train = data.frame(train_data_pca, severity = train_data$severity), 
  test = data.frame(test_data_pca), 
  k = 3,  # Number of neighbors
  kernel = "triangular"  # Weighted KNN
)
knn_predictions <- fitted(knn_model)

# ---- Step 4: Evaluate Performance ----
conf_matrix <- table(Predicted = knn_predictions, Actual = test_data$severity)
print("Confusion Matrix:")
print(conf_matrix)

accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))
