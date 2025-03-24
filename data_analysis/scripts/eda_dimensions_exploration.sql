-- Dimensions Exploration

-- All countries
SELECT DISTINCT
country
FROM gold.dim_customers;

-- All Categories 'The major divisions'
SELECT DISTINCT
category,
subcategory,
product_name
FROM gold.dim_products
ORDER BY 1, 2, 3;