use credit_card_classification;

#Drop TABLE if exists credit_card_data_test;
CREATE TABLE credit_card_data_test (
    customer_number int NOT NULL,
    offer_accepted text COLLATE utf8mb4_unicode_ci,
    reward text COLLATE utf8mb4_unicode_ci,
    mailer_type text COLLATE utf8mb4_unicode_ci,
    income_level text COLLATE utf8mb4_unicode_ci,
    bank_accounts_open int DEFAULT NULL,
    overdraft_protection text COLLATE utf8mb4_unicode_ci,
    credit_rating text COLLATE utf8mb4_unicode_ci,
    credit_cards_held int DEFAULT NULL,
    homes_owned int DEFAULT NULL,
    household_size int DEFAULT NULL,
    own_your_home text COLLATE utf8mb4_unicode_ci, 
    average_balance varchar(50) DEFAULT NULL,
    q1_balance varchar(50) DEFAULT NULL,  
    q2_balance varchar(50) DEFAULT NULL,
    q3_balance varchar(50) DEFAULT NULL,
    q4_balance varchar(50)DEFAULT NULL,
    PRIMARY KEY (customer_number),
	CHECK (offer_accepted in ('Yes','No')),
	CHECK (overdraft_protection in ('Yes','No')),
	CHECK (own_your_home in ('Yes','No'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET SQL_SAFE_UPDATES = 0;

create or replace view avg_balance as
SELECT avg(average_balance), avg(q1_balance), avg(q2_balance), avg(q3_balance), avg(q4_balance)
FROM credit_card_data_test;

select * from avg_balance;

alter table credit_card_data_test;
update credit_card_data_test
set average_balance = 939.6, q1_balance = 909.246, q2_balance = 998.056, q3_balance = 1040.644, q4_balance = 809.1055
where average_balance = " ";

# 4) select all
select * from credit_card_data_test;

# 5) drop the column q4_balance
ALTER TABLE credit_card_data_test DROP q4_balance;
select * from credit_card_data_test limit 10;

# 6) Use sql query to find how many rows of data you have.
select count(*) as Number_of_rows from credit_card_data_test;

# 7) Now we will try to find the unique values in some of the categorical columns:
#What are the unique values in the column Offer_accepted?
select offer_accepted as Unique_values from credit_card_data_test
group by offer_accepted;

#What are the unique values in the column Reward?
select reward as Unique_values from credit_card_data_test
group by reward;

#What are the unique values in the column mailer_type?
select mailer_type as Unique_values from credit_card_data_test
group by mailer_type;

# What are the unique values in the column credit_cards_held?
select credit_cards_held as Unique_values from credit_card_data_test
group by credit_cards_held;

# What are the unique values in the column household_size?
select household_size as Unique_values from credit_card_data_test
group by household_size;

#8 Arrange the data in a decreasing order by the average_balance of the house. 
# Return only the customer_number of the top 10 customers with the highest average_balances in your data.
select customer_number, average_balance from credit_card_data_test
order by average_balance DESC
limit 10;

#9 What is the average balance of all the customers in your data?
select avg(average_balance) as Average_balance_for_all_Customers from credit_card_data_test;

#10 In this exercise we will use simple group by to check the properties of some of the categorical variables in our data. 
# Note wherever average_balance is asked, please take the average of the column average_balance: 

#What is the average balance of the customers grouped by Income Level? 
#The returned result should have only two columns, income level and Average balance of the customers. 
#Use an alias to change the name of the second column.
select avg(average_balance) as Average_balance, income_level as Income from credit_card_data_test
group by income_level;

# What is the average balance of the customers grouped by number_of_bank_accounts_open? 
# The returned result should have only two columns, number_of_bank_accounts_open and Average balance of the customers. 
# Use an alias to change the name of the second column.
select avg(average_balance) as Average_balance, bank_accounts_open as Number_of_Bankaccounts from credit_card_data_test
group by bank_accounts_open;

# What is the average number of credit cards held by customers for each of the credit card ratings? 
# The returned result should have only two columns, rating and average number of credit cards held. 
# Use an alias to change the name of the second column.
select avg(credit_cards_held) as Credit_cards_held, credit_rating as Creditrating from credit_card_data_test
group by credit_rating;

# Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open? 
# You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
# Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select avg(credit_cards_held) as AVG_Credit_cards_held, bank_accounts_open as Number_of_Bankaccounts from credit_card_data_test
group by bank_accounts_open;
# there is no correlation between those two columns

# Your managers are only interested in the customers with the following properties:
--     Credit rating medium or high
--     Credit cards held 2 or less
--     Owns their own home
--     Household size 3 or more
select customer_number as Customer, credit_rating as Creditrating, credit_cards_held as Number_of_creditcards, own_your_home as Owns_their_home, household_size as Housholdsize
from credit_card_data_test
where credit_rating in ("Medium","High") and credit_cards_held <= 2 and own_your_home = "Yes" and household_size >= 3;

#For those having accepted the offer:
select customer_number as Customer, credit_rating as Creditrating, credit_cards_held as Number_of_creditcards, own_your_home as Owns_their_home, household_size as Housholdsize
from credit_card_data_test
where credit_rating in ("Medium","High") and credit_cards_held <= 2 and own_your_home = "Yes" and household_size >= 3 and offer_accepted = "Yes";

# 12 Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database.
# Write a query to show them the list of such customers. You might need to use a subquery for this problem
select customer_number as Customer, average_balance as Average_Balance 
from credit_card_data_test
where average_balance < (
						select avg(average_balance) 
                        from credit_card_data_test)
order by Average_Balance DESC;

#13 Since this is something that the senior management is regularly interested in, create a view of the same query.
create or replace view Management_interest as
select customer_number as Customer, average_balance as Average_Balance 
from credit_card_data_test
where average_balance < (
						select avg(average_balance) 
                        from credit_card_data_test)
order by Average_Balance DESC;

#14 What is the number of people who accepted the offer vs number of people who did not?
select count(customer_number), offer_accepted as Offer_Accepted from credit_card_data_test
group by offer_accepted;

# 15 Your managers are more interested in customers with a credit rating of high or medium. 
# What is the difference in average balances of the customers with high credit card rating and low credit card rating?
create or replace view credit_rating_balance as
SELECT avg(h.average_balance) as avg_bal_high, avg(l.average_balance) as avg_bal_low FROM credit_card_data_test h
join credit_card_data_test l
on h.customer_number <> l.customer_number
where h.credit_rating in ("High") and l.credit_rating in ("Low");

select avg_bal_high - avg_bal_low as Difference_between_high_and_low_rating from credit_rating_balance;

#or another approach:
select avg_bal - lag(avg_bal, 1) OVER (ORDER BY avg_bal) as  Difference_between_high_and_low_rating 
from (
		SELECT avg(average_balance) as avg_bal FROM credit_card_data_test
		group by credit_rating
		having credit_rating in ("High", "Low"))sub1
order by Difference_between_high_and_low_rating DESC
limit 1;

#16 In the database, which all types of communication (mailer_type) were used and with how many customers?
select mailer_type as Communication, count(customer_number) from credit_card_data_test
group by mailer_type;

#17 Provide the details of the customer that is the 11th least Q1_balance in your database.
with cte as (
	select Dense_rank() over (order by q1_balance) as Ranking, q1_balance, customer_number as Customer, income_level as Income from credit_card_data_test
    )
select * from cte
where Ranking = 11;