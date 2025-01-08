-- create database 
create database Amazondb;

-- Use database 
use amazondb;

1. **Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening.** This will help answer the question on which part of the day most sales are made.
2. Add a new column named dayname that contains the **extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri).** This will help answer the question on which week of the day each branch is busiest.
3. Add a **new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar)**. Help determine which month of the year has the most sales and profit.

-- creating a view to do the above operation 
create view amazon1_view  as 
select*,
case 
  when hour(Time)<12 then "Morning"
  when hour(Time) <16 then "afternoon"
  else "evening"
end as time_of_day,
dayname(Date) as day_name,
monthname(Date) as month_name
from amazon;

select * from amazon1_view;

-- Questions
-- 1. What is the count of distinct cities in the dataset?
select count(distinct city) as distinct_city from amazon1_view;
select distinct city from amazon1_view;

-- 2. For each branch, what is the corresponding city?
select Branch,city from amazon1_view
group by branch,city;

-- 3. What is the count of distinct product lines in the dataset?
select product_line, count(distinct product_line)
from amazon1_view
group by product_line;

-- 4. Which payment method occurs most frequently?
select Payment,count(*) from amazon1_view
group by payment
order by count(*) desc;

-- 5. Which product line has the highest sales?
select product_line,round(sum(cogs),2) from amazon1_view
group by product_line 
order by sum(cogs) desc
limit 1;

-- 6. How much revenue is generated each month?
select month_name, sum(gross_income) as revenue 
from amazon1_view
group by month_name;

-- 7. In which month did the cost of goods sold reach its peak?
select month_name ,sum(cogs) as cost_of_goods_sold
from amazon1_view 
group by month_name;

-- 8. Which product line generated the highest revenue?
select * from amazon1_view;
select product_line, sum(gross_income) from amazon1_view
group by product_line
order by sum(gross_income) desc;

-- 9. In which city was the highest revenue recorded?
select city, sum(gross_income) from amazon1_view
group by city
order by sum(gross_income) desc;

-- 10. Which product line incurred the highest Value Added Tax?
select Product_line,sum(VAT)
from amazon1_view
group by product_line 
order by sum(VAT) desc;

-- 11. Calculate the average rating for each product line.
select * from amazon1_view;
select product_line,avg(Rating)
from amazon1_view
group by product_line;

-- 12. Determine the city with the highest VAT percentage.
select city ,sum(VAT)
from amazon1_view
group by city;

-- 13. Identify the customer type with the highest VAT payments.
select * from amazon1_view;
select Customer_type, sum(vat)
from amazon1_view
group by Customer_type;

-- 14. What is the count of distinct customer types in the dataset?
select Customer_type, count(distinct Customer_type)
from amazon1_view
group by Customer_type;

-- 15. What is the count of distinct payment methods in the dataset?
select distinct Payment, count(Payment)
from amazon1_view
group by Payment;

-- 16. Which customer type occurs most frequently?
select Customer_type,count(Customer_type)
from amazon1_view
group by Customer_type;

-- 17. Determine the predominant gender among customers.
select * from amazon1_view;
select distinct Customer_type,Gender,count(Gender)
from amazon1_view
group by Customer_type,Gender ;

-- 18. Examine the distribution of genders within each branch.
select Gender,count(Gender),branch
from amazon1_view
group by Gender,branch
order by branch;

-- 19. Identify the time of day when customers provide the most ratings.
select time_of_day,round(avg(Rating),1)
from amazon1_view
group by time_of_day
order by round(avg(Rating),1) desc;

-- 20. Determine the time of day with the highest customer ratings for each branch.
select branch,time_of_day,round(avg(Rating),1)
from amazon1_view
group by time_of_day,branch
order by branch,round(avg(Rating),1) desc;

-- 21. Identify the day of the week with the highest average ratings.
select day_name,round(avg(Rating),1)
from amazon1_view
group by day_name
order by round(avg(Rating),1) desc;

-- 22. Determine the day of the week with the highest average ratings for each branch.
select branch,day_name,round(avg(Rating),1)
from amazon1_view
group by day_name,branch
order by branch, round(avg(Rating),1) desc;