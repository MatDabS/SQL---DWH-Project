-- Measures Exploration

-- Total Sales
SELECT
SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- How many items are sold?
SELECT
SUM(quantity) AS total_quantity
FROM gold.fact_sales;

-- Average selling price
SELECT
AVG(price) AS avg_price
FROM gold.fact_sales;

-- Total number of orders
SELECT
COUNT(order_number) AS total_orders
FROM gold.fact_sales;

SELECT
COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

-- Total number of products
SELECT
COUNT(product_key) AS total_products
FROM gold.dim_products;

-- Total number of customers
SELECT
COUNT(customer_key) AS total_customers
FROM gold.dim_customers;

-- Total number of customers that have placed an order
SELECT
COUNT(DISTINCT customer_key) AS total_orders
FROM gold.fact_sales;

-- Report showing all key metrics for the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS total_sales FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr of Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr of Products', COUNT(product_key) FROM gold.dim_products
UNION ALL
SELECT 'Total Nr of Customers', COUNT(customer_key) FROM gold.dim_customers;