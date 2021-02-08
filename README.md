# IronhackMidProject

This repository contains the group project by the ... team for the Ironhack Mid-Bootcamp Project.

# Team
BootCamp : Ironhack Berlin Data Analytics Full-Time January Cohort /
Alice
Arabella 
Dina
Oliver

# Code and Resources Used
..

# SQL
..

# Data Cleaning
We needed to clean up the data to make it usable for our model. We worked in two teams, splitting categoricals and numericals
categoricals:

Numericals:
Selected Average, and the Quarterly Balances as our numericals
Replaced null values with the median

Categoricals:
Applied a loop that checks the number of unique values in the column and based on this number splits the columns into numericals and categoricals. We used 10 as a threshold (less than 10 unique values -> categorical). As a result we ended up with the following categorical columns:
['offer_accepted',
 'reward',
 'mailer_type',
 'income_level',
 'bank_accounts_open',
 'overdraft_protection',
 'credit_rating',
 'credit_cards_held',
 'homes_owned',
 'Household_size',
 'Own_your_home']
No null values in the categorical columns


# EDA
Numericals, we looked at:
Multicollinearity Matrix
VIF scores (the Quarters values were in a range of 476 - 871
Generated 3 new columns to look for max, min, and range of quarterly values
Final columns: Average, Max, Min, Range
Chi-Squared on Max and Min (p=0.0)
Applied Log transformation to the 2 Numerical columns
Possible problem with them being binomial distributions?
Checked for multicollinearity between the categorical variables.
We run the chi2 test on each combination of 2 categorical variables and checked whether any chi2 value is below 0.05. Result - none of the columns pairs has chi2 value lower than 0.05, hence there is no correlation between the categorical variables.
After adding two additional categorical variables (max_quater, min_quarter) we run the chi2 test again.
Result: variables max_quarter and min_quarter are correlated with each other and with other categorical variables (mailer_type, credit_raiting, credit_cards_held). So we drop the variables max_quarter and min_quarter.

# Model Building



# Model performance
..

# Visualization
..
