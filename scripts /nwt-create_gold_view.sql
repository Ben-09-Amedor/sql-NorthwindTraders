/*
===================================================================================
DDL Scripts: Create Gold Views
====================================================================================
Purposeof Script:
This script create gold layer for in the NorthwindTraders. 
The gold layer represents the final layer dimension and fact Table(star schema)


Each views performs transformations and combines data from the silver layer to produce
clean, rich and business ready datasets


usage: 
	- These views can be queried directly for analysis and reporting
-- =====================================================================================
*/



		-- ====================================================================================
		-- Create Dimension Table: gold.dim_customers
		-- =====================================================================================

IF OBJECT_ID ( gold.dim_customers 'V') IS NOT NULL
DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT 
	CustomerID,
	CompanyName,
	ContactName,
	ContactTitle,
	City,
	Country
FROM silver.customers;


		-- ====================================================================================
		-- Create Dimension Table: gold.dim_employees
		-- =====================================================================================

 
 IF OBJECT_ID ( gold.dim_employees 'V') IS NOT NULL
DROP VIEW gold.dim_employees;
GO
DROP VIEW gold.dim_employees
CREATE VIEW gold.dim_employees AS
SELECT 
	EmployeeID,
	EmployeeName,
	Title,
	City,
	Country,
	CASE WHEN ReportsTo = 8 THEN 'Laura Callahan'
		 WHEN ReportsTo = 2 THEN 'Andrew Fuller'
		 WHEN ReportsTo = 5 THEN 'Steven Buchanan'
		 ELSE 'CEO' -- reports to the Boss 
	END AS ReportsTo
FROM silver.employees



		-- ====================================================================================
		-- Create Dimension Table: gold.dim_products
		-- =====================================================================================


IF OBJECT_ID ( gold.dim_products 'V') IS NOT NULL
DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_products AS
SELECT
  	p.ProductID,
  	p.CategoryID,
  	p.ProductName,
  	c.CategoryName,
  	REPLACE (c.ProductDescription, '"', '') AS ProductDescription,
  	p.QuantityPerUnit,
  	p.UnitPrice,
CASE WHEN Discountinued = 0 THEN 'Not Available'
		ELSE 'Available'
END AS Discontinued	
FROM silver.products p 
LEFT JOIN silver.categories c
	ON p.CategoryID = c.CategoryID




		-- ====================================================================
		-- Create Fact Table: gold.fact_orders
		-- ====================================================================



IF OBJECT_ID ( gold.fact_orders 'V') IS NOT NULL
DROP VIEW gold.fact_orders;
GO

CREATE VIEW gold.fact_orders AS
SELECT 
  	o.OrderID,
  	o.CustomerID,
  	o.EmployeeID,
  	od.ProductID,
  	o.OrderDate,
  	o.RequiredDate,
  	COALESCE(CONVERT(VARCHAR(20), o.ShippedDate, 120), 'Pending') AS ShippedStatus,
  	s.CompanyName AS ShippingCompany,
  	o.Freight,
  	od.UnitPrice,
  	od.Quantity,
  	od.Discount,
	CAST (UnitPrice * Quantity *(1-Discount) AS  DECIMAL(12,2)) AS Sales, -- calcualted field to find total revenue to the employer
	o.Freight + CAST (UnitPrice * Quantity *(1-Discount) AS  DECIMAL(12,2)) AS TotalCost -- calcuated to find the total cost of ordering a product
FROM silver.orders o
LEFT JOIN silver.shippers s
    ON o.ShipperID = s.ShipperID
LEFT JOIN silver.order_details od
    ON od.OrderID = o.orderID









