/*
======================================================
Create Database and Schemas
======================================================
Script purpose:
	This script creates a new database named 'DataWarehouse' after checking if it already exists. If the database exists.
	If the database exists, it is dropped and recreated. Additionally the script sets up three schemas within the database:
	'bronze', 'silver' and 'gold'.

WARNING:
Running the script will drop the database 'DataWarehouse' if it exists and all data within the database will be
permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/

USE master;
GO

--Drop and recereate the 'DataWarehouse' database

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Create Database 'DataWarehouse'

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
