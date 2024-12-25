#Applied Machine Learning 

## Predicting Incident Severity Using Random Forest

## Overview
This repository contains the code and documentation for an assignment project focused on predicting the severity of gun violence incidents using machine learning techniques, specifically a Random Forest model. The work is part of a coursework assignment for Applied Machine Learning, demonstrating data preprocessing, model training, evaluation, and feature importance analysis.

## Project Structure
The project includes:

1. **Data Preprocessing**: Cleaning, encoding, and preparing the dataset for machine learning.
2. **Model Training**: Using a Random Forest algorithm with cross-validation to predict incident severity.
3. **Model Evaluation**: Assessing the model's performance with metrics such as accuracy, confusion matrix, and feature importance.
4. **Results Analysis**: Reviewing model predictions and feature significance.

## Repository Files
- `datasetUrl.txt`: File contains a url to download the full dataset used.
- - `data_sample_100.csv`: Csv file contais a sample (100 rows) of the full data  set.
- `ClearningDataAgreed.R`: Script to clene the cvs data.
- `RandomForest.R`: The main script that contains the R code for data preprocessing, model training, and evaluation.
- `README.md`: This documentation file providing an overview of the project.
- **Data**: Placeholder for the dataset file (not included due to size or privacy).

## Dependencies
To run the code, you need the following R packages:

- `caret`
- `randomForest`
- `dplyr`
- `lubridate`
- `tidyr`

Install the required packages using:
```R
install.packages(c("caret", "randomForest", "dplyr", "lubridate", "tidyr"))
```

## How to Use
1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Load the dataset (ensure the correct file path in the script).
3. Run the `ClearningDataAgreed.R` script in an R environment to clean the data.
4. Run the `RandomForest.R` script in an R environment.

## Dataset
This project uses a dataset of gun violence incidents. The dataset includes information such as state, number of guns involved, and incident severity. Note that the dataset must be in CSV format and properly preprocessed as per the script requirements.

## Methodology
- The dataset is split into training (80%) and testing (20%) subsets.
- A Random Forest model is trained using 3-fold cross-validation with reduced data sizes for faster computation.
- Predictions are evaluated against the test set, and feature importance is analyzed.

## Results
- **Accuracy**: The model achieved an accuracy of ~67.6% on the test set.
- **Feature Importance**: Insights into which variables most influenced severity predictions are visualized.

## Future Improvements
- Addressing class imbalance using techniques like SMOTE.
- Experimenting with alternative machine learning algorithms.
- Adding advanced feature engineering to improve predictive performance.

## Notes
This code was developed as part of an academic assignment and is intended for educational purposes. 
Contributions and feedback are welcome for improving the project.


## Author
Abdulrahman alhariri
Applied Machine Learning Course Assignment

