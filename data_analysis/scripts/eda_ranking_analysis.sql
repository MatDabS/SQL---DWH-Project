-- Ranking Analysis

-- Products generating the highest revenue
SELECT TOP 5
dp.product_name,
SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS dp
ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue DESC;

SELECT *
FROM (
	SELECT
	ROW_NUMBER() OVER (ORDER BY SUM(fs.sales_amount) DESC) AS rank_products,
	dp.product_name,
	SUM(fs.sales_amount) AS total_revenue
	FROM gold.fact_sales AS fs
	LEFT JOIN gold.dim_products AS dp
	ON fs.product_key = dp.product_key
	GROUP BY dp.product_name)t
WHERE rank_products <= 5;

-- Products generating the lowest revenue
SELECT TOP 5
dp.product_name,
SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
LEFT JOIN gold.dim_products AS dp
ON fs.product_key = dp.product_key
GROUP BY dp.product_name
ORDER BY total_revenue ASC;