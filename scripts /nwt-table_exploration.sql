/*
===============================================================================
Tables Exploration
===============================================================================
Purpose:
    - To explore the structure of the Tables, including the list of columns.
    - To inspect the columns of the tables.

Table Used:
    - gold.dim_products
    - gold.dim_customers
    - gold.dim_employees
    - gold.facts_orders
===============================================================================
*/



-- explore all country where customers come from
SELECT DISTINCT Country,
FROM gold.dim_customers;


-- Explore all employees and country the come from
SELECT  DISTINCT EmployeeName, Country
FROM gold.dim_employees
ORDER BY EmployeeName

 -- Explore Key products and thier categories
SELECT  ProductID, ProductName, CategoryID, CategoryName
FROM gold.dim_products;

-- Explore Order Date dimention
SELECT
    MIN(OrderDate) AS first_order_date,
    MAX(orderDate) AS last_order_date,
    DATEDIFF( Year,MIN(OrderDate), MAX (OrderDate)) As order_range_years,
    DATEDIFF( Month,MIN(OrderDate), MAX (OrderDate)) As order_range_months,
    DATEDIFF( Day,MIN(OrderDate), MAX (OrderDate)) As order_range_days
FROM gold.fact_orders;


-- Explore Dates Dimention
SELECT
    OrderID,
    DATEDIFF(Day, OrderDate, RequiredDate) AS expected_date,
    DATEDIFF(Day, OrderDate, shippedStatus) AS order_processing_days
FROM gold.fact_orders
WHERE ShippedStatus  != 'Pending'
