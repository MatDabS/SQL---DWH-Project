-- Date Exploration

-- Find the first and the last order
-- How many years of sales are available
SELECT
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales;

-- Find youngest and oldest customer
SELECT
MIN(birthdate) AS oldest_birthdate,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;