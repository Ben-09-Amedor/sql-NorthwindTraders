/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/


-- find customers by their countries
SELECT 
  Country,
  COUNT (country) AS Total_Customers
FROM gold.dim_customers
GROUP BY Country 
ORDER BY Total_Customers;

-- find the types of customers you are dealing with
SELECT 
  ContactTitle, 
  Count(ContactTitle) AS Total_Dealers
FROM gold.dim_customers
GROUP BY ContactTitle
ORDER by Total_Dealers

-- find the total number of products by category
SELECT 
  CategoryID, 
  CategoryName,
  COUNT(CategoryID) AS Total_Products
FROM gold.dim_products 
GROUP BY CategoryID, CategoryName
ORDER BY Total_Products DESC


-- Total Order by customers
SELECT 
  o.customerID,
  c.CompanyName,
SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_customers c
  ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
ORDER BY Total_sales DESC

-- which  customer country is generating the highest sales
SELECT DISTINCT c. Country,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_customers c
  ON o.CustomerID = c.CustomerID
GROUP BY  c.Country
ORDER BY Total_sales DESC 


-- Total Product Category being ordered
SELECT 
  o.ProductID,
  p.ProductName,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_products p
  ON o.ProductID = p.ProductID
GROUP BY o.ProductID,  ProductName
ORDER BY Total_sales DESC

SELECT 
  o.EmployeeID,
  e.EmployeeName,
  e.Title,
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_employees e
  ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID,  e.EmployeeName, Title
ORDER BY Total_sales DESC


-- which country of employee is generating the highest revenue
SELECT 
  e. country,	
  SUM(o.sales) AS Total_sales
FROM gold.fact_orders o
LEFT JOIN gold.dim_employees e
  ON o.EmployeeID = e.EmployeeID
GROUP BY e.country
ORDER BY Total_sales DESC

-- Average cost of shipping by the providers
SELECT 
  ShippingCompany,	
  ROUND (AVG(Freight), 2) AS Avg_cost_of_shipping
FROM gold.fact_orders o
GROUP BY ShippingCompany
ORDER BY Avg_cost_of_shipping DESC
