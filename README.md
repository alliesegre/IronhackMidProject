# IronhackMidProject

This repository contains the group project by the ... team for the Ironhack Mid-Bootcamp Project.

# Team
BootCamp : Ironhack Berlin Data Analytics Full-Time January Cohort /
Alice
Arabella 
Dina
Oliver
<br/>
# Code and Resources Used
..
<br/>
# SQL
..
<br/>
# Data Cleaning
We needed to clean up the data to make it usable for our model. We worked in two teams, splitting categoricals and numericals
categoricals:
<br/>
- Numericals:
Selected Average, and the Quarterly Balances as our numericals
Replaced null values with the median
<br/>
- Categoricals:
Applied a loop that checks the number of unique values in the column and based on this number splits the columns into numericals and categoricals. We used 10 as a threshold (less than 10 unique values -> categorical). <br/>
No null values in the categorical columns
<br/>

# EDA
We looked at:
Multicollinearity Matrix <br/>
VIF scores (the Quarters values were in a range of 476 - 871 <br/>
Generated 3 new columns to look for max, min, and range of quarterly values <br/>
Final columns: Average, Max, Min, Range <br/>
Chi-Squared on Max and Min (p=0.0)<br/> <br/>
Applied Log transformation to the 2 Numerical columns <br/>
Possible problem with them being binomial distributions? <br/>
Checked for multicollinearity between the categorical variables. <br/>
We run the chi2 test on each combination of 2 categorical variables. <br/>

# Transformation
Removing outliers: <br/>
 Using IQR limit setting <br/>
 + 1.5 for average_balance and min <br/>
 +1 for q3 <br/>
 Boxplots to check distributions <br/>

Transformation:Square Root transformation for ‘min’ and q3_balance <br/>
Encoding: OneHot Encoder <br/>
Scaling: Normalization <br/>
 
# Model Building
First, we transformed the data and split the data into train and test sets with a test size of 30%.
We tried three different models and evaluated them based on the recall value.
- Logistic Regression – Our final Model.
- Random Forest Classifier – Considering the imbalanced dataset, we would have expected this model to be the best, which was not true.
- KNN – We tested this model also assuming that it could handle the data imbalance.

# Model performance
The Logistic Regression model outperformed the other approaches on the test and validation sets. We considered the recall value to decide:
- Logistic Regression : Recall  = 0.7
- Random Forest Classifier: Recall = 0.3
- KNN: Recall = 0.31

# Visualization
..
