/*
===================================================================================
DDL Scripts: Create Silver Table
===================================================================================
Script Purpose:
This script creates a Silver Table and will drop the existing table if it already exists. 
Run this script to redefine the DDL structure of the 'silver' table.

====================================================================================

*/

		-- Create Table for Customers
IF OBJECT_ID ('silver.customers', 'U') IS NOT NULL
	DROP TABLE silver.customers
CREATE TABLE silver.customers(
		CustomerID			NVARCHAR(50),
		CompanyName			NVARCHAR(100),
		ContactName			NVARCHAR(50),
		ContactTitle		NVARCHAR(50),
		City				NVARCHAR(50),
		Country				NVARCHAR(50)

			);

			-- Create Table for Employee
		
IF OBJECT_ID ('silver.employees', 'U') IS NOT NULL
	DROP TABLE silver.employees
CREATE TABLE silver.employees(
		EmployeeID			NVARCHAR(10),
		EmployeeName		NVARCHAR(50),
		Title				NVARCHAR(50),
		City				NVARCHAR(50),
		Country				NVARCHAR(50),
		ReportsTO			NVARCHAR(50)


		);
		

		-- Create Table for Shippers
IF OBJECT_ID ('silver.shippers', 'U') IS NOT NULL
	DROP TABLE silver.shippers
CREATE TABLE silver.shippers(
		ShipperID			NVARCHAR(10),
		CompanyName			NVARCHAR(50)

		);
		


		-- Create Table for Categories
IF OBJECT_ID ('silver.categories', 'U') IS NOT NULL
	DROP TABLE silver.categories
CREATE TABLE silver.categories(
		CategoryID				NVARCHAR(10),
		CategoryName			NVARCHAR(50),
		ProductDescription		NVARCHAR(100)

		);
		


		-- Create Table for Order Details
IF OBJECT_ID ('silver.order_details', 'U') IS NOT NULL
	DROP TABLE silver.order_details
CREATE TABLE silver.order_details(
		OrderID				NVARCHAR(20),
		ProductID			NVARCHAR(10),
		UnitPrice			DECIMAL(12,2),
		Quantity			INT,
		Discount			DECIMAL(12,2)


		);
		

		-- Create Table for Orders
IF OBJECT_ID ('silver.orders', 'U') IS NOT NULL
	DROP TABLE silver.orders
CREATE TABLE silver.orders(
		OrderID			NVARCHAR(20),
		CustomerID		NVARCHAR(50),
		EmployeeID		NVARCHAR(10),
		OrderDate		DATE,
		RequiredDate	DATE,
		ShippedDate		DATE,
		ShipperID		NVARCHAR(10),
		Freight			DECIMAL(12,2)

		);
		

		-- Create Table for Products

IF OBJECT_ID ('silver.products', 'U') IS NOT NULL
	DROP TABLE silver.products
CREATE TABLE silver.products(
		ProductID			NVARCHAR(10),
		ProductName			NVARCHAR(100),
		QuantityPerUnit		NVARCHAR(100),
		UnitPrice			DECIMAL(12,2),
		Discountinued		NVARCHAR(10),
		CategoryID			NVARCHAR(10)


		);
		


