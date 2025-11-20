/*
===============================================================================
Trend Analysis
===============================================================================
Purpose:
    - To get insight into trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Sales Yearly Trend
-- Quick date check
SELECT 
    COUNT(DISTINCT CustomerID) AS Total_Customers,
    Year(OrderDate) AS Order_Years,
    SUM(Quantity) AS Total_Quantity,
    SUM(sales) AS TotalSales
FROM gold.fact_orders
GROUP BY Year(OrderDate)
ORDER BY Year(OrderDate)

-- Sales Yearly Trend
-- Quick date check
SELECT 
    COUNT(DISTINCT CustomerID) AS Total_Customers,
    Year(OrderDate) AS Order_Years,
    Month(OrderDate) AS Order_month,
    SUM(Quantity) AS Total_Quantity,
    SUM(sales) AS TotalSales
FROM gold.fact_orders
GROUP BY Year(OrderDate), Month(OrderDate)
ORDER BY Month(OrderDate), Year(OrderDate)

-- Sales Yearly Trend
-- Date Trunc
SELECT 
    COUNT(DISTINCT CustomerID) AS Total_Customers,
    DATETRUNC (Month, OrderDate) AS Order_Years,
    SUM(Quantity) AS Total_Quantity,
    SUM(sales) AS TotalSales
FROM gold.fact_orders
GROUP BY DATETRUNC (Month, OrderDate)
ORDER BY DATETRUNC (Month, OrderDate)


-- Bottom 3 Peforming Employees


SELECT
    EmployeeID,
    EmployeeName,
    Title,
    Total_sales,
    CASE WHEN Total_sales > 200000 THEN 'Higher Performer'
         WHEN Total_sales BETWEEN 150000 AND 200000 THEN 'Mid Performer'
         ELSE 'Low Performer'
    END AS Employee_performance
FROM
(
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

 -- customer with most order

 WITH customer_spending AS(

SELECT 
    c.customer_key,
    SUM(f.sales_amount) AS total_sales,
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order,
    DATEDIFF (Month, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)
SELECT 
    CustomerID,
    COUNT (OrderID) AS Total_Orders
FROM(
SELECT
    CustomerID,
    CASE WHEN Order >= 12 AND total_sales > 5000 THEN 'VIP'
	     WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
	     ELSE 'New'
    END customer_segement
FROM customer_spending)t
GROUP BY customer_segement
ORDER BY   total_customers DESC;


-- segements customers into various class

WITH Customer_segments AS (
    SELECT 
        c.CustomerID,
        c.CompanyName,
        SUM(o.sales) AS Total_sales,
        CASE 
            WHEN SUM(o.sales) > 100000 THEN 'Premier Tier'
            WHEN SUM(o.sales) BETWEEN 50000 AND 100000 THEN 'Advantage Tier'
            WHEN SUM(o.sales) BETWEEN 20000 AND 50000 THEN 'Classic Tier'
            ELSE 'Starter'
        END AS Customer_profile
    FROM gold.fact_orders o
    LEFT JOIN gold.dim_customers c
        ON o.CustomerID = c.CustomerID
    GROUP BY c.CustomerID, c.CompanyName
   
)
SELECT 
    CustomerID,
    CompanyName,
    Total_sales,
    Customer_profile
FROM Customer_segments
ORDER BY Total_sales DESC
