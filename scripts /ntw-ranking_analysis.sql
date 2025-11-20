/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers, employee) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: ROW_NUMBER(), TOP 'N'
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Top 3 customers 
SELECT TOP 3
  o.customerID,
  c.CompanyName,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_customers c
  ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
ORDER BY Total_sales DESC


-- Bottom 3 customers
SELECT TOP 3
  o.customerID,
  c.CompanyName,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_customers c
  ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
ORDER BY Total_sales 


-- Best 3 Peforming Employees
SELECT
*
FROM(
SELECT 
  o.EmployeeID  AS EmployeeID,
  e.EmployeeName AS EmployeeName,
  e.Title AS Title,
  ROW_NUMBER() OVER( ORDER BY SUM(o.sales) DESC ) AS Rank_employees,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_employees e
  ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID,  e.EmployeeName, e.Title)t
WHERE Rank_employees <= 3



-- Bottom 3 Peforming Employees
SELECT
*
FROM(
SELECT 
  o.EmployeeID  AS EmployeeID,
  e.EmployeeName AS EmployeeName,
  e.Title AS Title,
ROW_NUMBER() OVER( ORDER BY SUM(o.sales) ) AS Rank_employees,
SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_employees e
  ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID,  e.EmployeeName, e.Title)t
WHERE Rank_employees <= 3


-- TOP 3 Product category with the highest sales

SELECT *
FROM
(
SELECT
  ROW_NUMBER() OVER( ORDER BY SUM(o.sales)  DESC) AS Rank_products,
  p.CategoryName,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_products p
  ON o.productID = p.productID
GROUP BY CategoryName)t
WHERE Rank_products <= 3


-- Bottom 3 Product category with the highest sales

SELECT *
FROM
(
SELECT
  ROW_NUMBER() OVER( ORDER BY SUM(o.sales) ) AS Rank_products,
  p.CategoryName,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_products p
  ON o.productID = p.productID
GROUP BY CategoryName)t
WHERE Rank_products <= 3


-- shipping company with the Highest Revenue from Freight
SELECT 
  ShippingCompany,
  SUM(Freight) AS Freight_Revenue
FROM gold.fact_orders
GROUP BY ShippingCompany
ORDER BY Freight_Revenue DESC;

-- shipping company with Most orders
SELECT 
  ShippingCompany,
  COUNT(OrderID) AS Total_orders
FROM gold.fact_orders
GROUP BY ShippingCompany
ORDER BY Total_orders DESC;

