/*
=====================================================================================
Product Report
=====================================================================================
Purpose: 
		This report integrates key product metrics and behaviours

Highlights:
		1. Gathers essential fields such as product names, category, subcategory and cost.
		2. Segments products by revenue (High-Performance, Mid-Range, Low-Performance).
		3. Aggregates product-level metrics:
			- total orders
			- total sales
			- total quantity sold
			- total products (unique)
			- lifespan (in months)
		4. Calculates valuable KPIs:
			- recency (months since last sale)
			- average order revenue
			- average monthly revenue
=====================================================================================
*/

CREATE VIEW gold.report_products AS

/*-------------------------------------------------------------------------------------
1. Base Query: Retrieves core columns from tables
-------------------------------------------------------------------------------------*/

WITH base_query AS
(
	SELECT
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
	FROM gold.fact_sales AS f
	LEFT JOIN gold.dim_products AS p
	ON f.product_key = p.product_key
	WHERE f.order_date IS NOT NULL
),

/*-------------------------------------------------------------------------------------
2. Product Aggregation: Summarizes key metrics at the product level
-------------------------------------------------------------------------------------*/

product_aggregation AS
(
	SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	MAX(order_date) AS last_order_date,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
	FROM base_query
	GROUP BY
	product_key,
	product_name,
	category,
	subcategory,
	cost
)

/*-------------------------------------------------------------------------------------
3. Final Query: Provides ultimate report
-------------------------------------------------------------------------------------*/

SELECT
product_key,
product_name,
category,
subcategory,
cost,
last_order_date,
DATEDIFF(month, last_order_date, GETDATE()) AS recency_in_months,
CASE
	WHEN total_sales > 50000 THEN 'High-Performance'
	WHEN total_sales >= 10000 THEN 'Mid-Range' 
	ELSE 'Low-Performance'
END AS product_segment,
total_orders,
total_sales,
total_quantity,
lifespan,
CASE
	WHEN total_orders = 0 THEN 0
	ELSE total_sales / total_orders
END AS avg_order_revenue,
avg_selling_price,
CASE
	WHEN lifespan = 0 THEN total_sales
	ELSE total_sales / lifespan
END AS avg_monthly_revenue
FROM product_aggregation