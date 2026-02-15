create database if not exists sales_analytics_db;
use sales_analytics_db;

select count(*)
from sales_data;

describe sales_data;

# Monthly-wise top 5 Revenue
select order_month, sum(revenue) as total_revenue
from sales_data
group by order_month
order by total_revenue desc
limit 5;

# Monthly Revenue and profit Trend 
select
	order_month,
	SUM(revenue) as total_revenue,
	SUM(profit) as total_profit
from sales_data
group by order_month
order by order_month;

# Top 10 Products by Revenue
select product_name,
sum(revenue) as total_revenue
from sales_data
group by product_name
order by total_revenue desc
limit 10;

# Best Channel Performance
select
channel,
sum(revenue) as total_revenue,
sum(profit_margin_pct) as avg_margin
from sales_data
group by channel
order by total_revenue desc;

# Region-wise Revenue
select us_region,
sum(revenue) as total_revenue,
sum(profit) as total_profit
from sales_data
group by us_region
order by total_revenue;

# High Value Orders Analysis
select 
high_value_order,
count(*) as order_count,
sum(revenue) as renue_contribution
from sales_data
group by high_value_order;


# top customers
select 
customer_name,
sum(revenue) as total_revenue
from sales_data
group by customer_name
order by total_revenue desc
limit 10;

# Profitability Analysis by category
select 
profit_category,
count(*) as orders,
sum(revenue) as total_profit
from sales_data
group by profit_category;

# State-wise Top 5 Revenue
select 
state_name,
sum(revenue) as total_revenue
from sales_data
group by state_name
order by total_revenue
limit 5;

# Create a View as -> monthly_sales_summery
create view monthly_sales_summery as 
select 
order_month,
sum(revenue) as total_revenue,
sum(profit) as total_profit
from sales_data
group by order_month;

# View command 
select * from monthly_sales_summery;

# Data Validation Query (ETL Quality)
select 
count(*) as total_rows,
count(distinct order_number) as unique_orders
from sales_data;

# check null values
select
sum(order_number is null) as null_orders,
sum(revenue is null) as null_revenue,
sum(profit is null) as null_profit
from sales_data;

# Time-Based Analysis
select
order_month,
sum(revenue) as revenue,
sum(profit) as profit
from sales_data
group by order_month
order by order_month;

# Growth over months name
select 
monthname(order_date) AS year,
sum(revenue) as revenue
from sales_data
group by monthname(order_date)
order by year;


# Year-over-Year (YoY) growth
select
year(order_date) as year,
sum(profit) as profit,
sum(revenue) as revenue
from sales_data
group by year(order_date)
order by year;

# Top 10 Product Performance
select
product_name,
sum(revenue) as revenue,
sum(profit) as profit
from sales_data
group by product_name
order by revenue desc
limit 10;

# Top 10 Low-margin products
select
product_name,
avg(profit_margin_pct) as avg_margin
from sales_data
group by product_name
order by avg_margin
limit 10;

# Customer Analytics Revenue concentration (Pareto check)
select 
count(*) as orders,
high_value_order,
sum(revenue) as revenue
from sales_data
where high_value_order = 1;

# Index for Performance 
create index idx_order_date on sales_data(order_date);

# product_name is stored as TEXT
# MySQL cannot create an index on TEXT without specifying a length, so below line will give error
-- create index idx_product on sales_data(product_name);
# avoid error
alter table sales_data
modify product_name varchar(255);
# Then execute the below line
create index idx_product on sales_data(product_name);