/*
=====================================================================
Create Database  and Schemas 
=====================================================================

Script Purpose:
This scripts create a database named "NorthwindTraders". It has two schemas: silver and gold.
It checks if the database already exists. If it exists, it is dropped and recreated.


Warning: 
Running this script will drop 'NorthwindTraders’ and permanently delete all data in the database.
Proceed with caution and ensure your data is backed up before running this script.


*/


USE master;
GO
		-- Drop and create Database if exists
IF EXISTS ( SELECT 1 FROM sys.databases WHERE name = 'NorthwindTraders')

BEGIN
	ALTER DATABASE NorthwindTraders SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE NorthwindTraders;
END;
GO


CREATE DATABASE NorthwindTraders;
GO

USE NorthwindTraders;
GO


-- create schemas
CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
