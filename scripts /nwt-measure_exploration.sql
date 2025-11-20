/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To generate quick into data by calculating aggregated metrics (e.g., totals, averages).
    - To identify trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- find the total number of customers
SELECT COUNT( DISTINCT CustomerID) FROM gold.dim_customers 

-- find the total number of customers that has placed an orders
SELECT COUNT( DISTINCT CustomerID) FROM gold.fact_orders 


-- find the total number of product orders
SELECT COUNT(DISTINCT ProductID) FROM gold.fact_orders  

-- find the total quantity of product ordered
SELECT SUM( Quantity) FROM gold.fact_orders 

-- find the total sales
SELECT SUM(sales) FROM gold.fact_orders 

-- find the average price
SELECT AVG(Unitprice) FROM gold.fact_orders 

-- find the average freight cost
SELECT AVG(freight) FROM gold.fact_orders 

-- find the average cost of making orders and having them shipped
SELECT AVG(TotalCost) FROM gold.fact_orders 


-- Generate a Report of Key meterics

SELECT 'Total Sale' AS measure_name,  SUM(Sales) AS measure_Value FROM gold.fact_orders
UNION ALL
SELECT 'Total Quantity' AS meaure_name, SUM(Quantity) AS measure_value FROM gold.fact_orders
UNION ALL
SELECT 'Average Price' AS measure, AVG(UnitPrice) FROM gold.fact_orders
UNION ALL
SELECT 'Average Freight Cost' AS measure, AVG(Freight) FROM gold.fact_orders
UNION ALL
SELECT 'Total Customers' AS measure, COUNT(DISTINCT CustomerID) FROM gold.dim_customers
UNION ALL
SELECT 'Total Employee' AS measure,  COUNT(DISTINCT EmployeeID) FROM gold.dim_employees
UNION ALL
SELECT 'Total Product' AS measure, SUM(Quantity) FROM gold.fact_orders
