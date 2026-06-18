# Employee Attrition Analysis using R

This project is my attempt to understand employee attrition using R and machine learning. I worked with the IBM HR Analytics Employee Attrition dataset and performed the complete workflow from loading and cleaning the data to building and evaluating a predictive model.

## Overview

The main goal of this project was to find out which factors influence employee attrition and whether we can predict if an employee is likely to leave the company.

I loaded the dataset directly into RStudio using the `read.csv()` function and performed all the analysis in R.

## Dataset

Dataset: IBM HR Analytics Employee Attrition Dataset

The dataset contains information such as:

* Age
* Department
* Job Role
* Monthly Income
* Education
* Job Level
* OverTime
* Years at Company
* Total Working Years
* Attrition (Yes/No)

## What I Did

* Loaded the CSV dataset into R using `read.csv()`.
* Checked the structure and data types of all columns.
* Handled missing values using mean or median wherever required.
* Removed unnecessary columns like `EmployeeCount` and `StandardHours`.
* Converted categorical variables into factors.
* Performed Exploratory Data Analysis (EDA).
* Created visualizations to understand attrition patterns.
* Generated a correlation matrix and heatmap.
* Split the dataset into training and testing sets.
* Built a Logistic Regression model.
* Evaluated the model using a Confusion Matrix.
* Analyzed variable importance to identify factors affecting attrition.

## Machine Learning Model

I used Logistic Regression to predict employee attrition.

The model was trained on 80% of the data and tested on the remaining 20% using stratified sampling to maintain the proportion of attrition classes.

## Tools and Libraries

* R
* RStudio
* dplyr
* ggplot2
* caret
* corrplot

## Key Learnings

This project helped me gain hands-on experience with:

* Data cleaning in R
* Exploratory Data Analysis (EDA)
* Data visualization using ggplot2
* Correlation analysis
* Logistic Regression
* Confusion Matrix and model evaluation
* End-to-end machine learning workflow

## Conclusion

Through this project, I learned how a complete machine learning workflow is implemented in R, starting from raw data and ending with a predictive model. The project also helped me understand how factors like age, overtime, and income can influence employee attrition.

## Author

**Vanshika Bhardwaj**
