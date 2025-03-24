-- Database Exploration

-- Explore All Objects in Database

SELECT *
FROM INFORMATION_SCHEMA.TABLES;

-- Explore All Columns in Database

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_products';