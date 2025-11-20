/*
==================================================================================
Stored Procedure: Load Silver Layer ( Source -> Silver)
===================================================================================
Scripts Purpose:
	This procedure loads data into the 'silver' schema from external csv file.
	This store procedure truncates and load the silver data. It uses  'BULK INSERT' 
	command to load file into silver Table

Parameters:
	 None
	This Store procedure does not accept any parameters or return any values

Usage Example:
		EXEC silver.load_silver
===================================================================================

*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time =  GETDATE();
		PRINT '=================================================================';
		PRINT 'Loading silver Layer';
		PRINT '=================================================================';
	

		PRINT '------------------------------------------------------------------';
		PRINT 'Loading Customers Tables'
		PRINT '------------------------------------------------------------------';

		SET @start_time =  GETDATE();
		PRINT '>> Truncating Table: silver.customers';
		TRUNCATE TABLE silver.customers;

		PRINT '>> Inserting Data Into: silver.customers';

BULK INSERT silver.customers
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_3\NorthwindTraders\customers\customers.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------------------';


	
		PRINT '------------------------------------------------------------------';
		PRINT 'Loading Employees Tables'
		PRINT '------------------------------------------------------------------';

		SET @start_time =  GETDATE();
		PRINT '>> Truncating Table: silver.employees';
		TRUNCATE TABLE silver.employees;
BULK INSERT silver.employees
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_3\NorthwindTraders\employee\employees.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
			SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------------------';


		PRINT '------------------------------------------------------------------';
		PRINT 'Loading Product Table'
		PRINT '------------------------------------------------------------------';

		SET @start_time =  GETDATE();
		PRINT '>> Truncating Table: silver.products';
		TRUNCATE TABLE silver.products;


BULK INSERT silver.products
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_3\NorthwindTraders\products\products.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
			SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------------------';


		PRINT '------------------------------------------------------------------';
		PRINT 'Loading Categories Tables'
		PRINT '------------------------------------------------------------------';

		SET @start_time =  GETDATE();
		PRINT '>> Truncating Table: silver.categories';
		TRUNCATE TABLE silver.categories;


BULK INSERT silver.categories
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_3\NorthwindTraders\products\categories.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

			SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------------------';


		PRINT '------------------------------------------------------------------';
		PRINT 'Loading Orders Tables'
		PRINT '------------------------------------------------------------------';

		SET @start_time =  GETDATE();
		PRINT '>> Truncating Table: silver.orders';
		TRUNCATE TABLE silver.orders;

BULK INSERT silver.orders
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_3\NorthwindTraders\products\orders.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

			SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------------------';

		PRINT '------------------------------------------------------------------';
		PRINT 'Loading Order  Details Table'
		PRINT '------------------------------------------------------------------';

		SET @start_time =  GETDATE();
		PRINT '>> Truncating Table: silver.order_details';
		TRUNCATE TABLE silver.order_details;
BULK INSERT silver.order_details
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_3\NorthwindTraders\products\order_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
			SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------------------';



		PRINT '------------------------------------------------------------------';
		PRINT 'Loading Shippers Table'
		PRINT '------------------------------------------------------------------';

		SET @start_time =  GETDATE();
		PRINT '>> Truncating Table: silver.shippers';
		TRUNCATE TABLE silver.shippers;


BULK INSERT silver.shippers
		FROM 'C:\Users\Pc\Desktop\DATA FOR ANALYSIS\MSS SQL FOLDER\PROJECT_3\NorthwindTraders\shippers\shippers.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

			SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT 'Loaing Silver Layer is completed';
		PRINT '   - Total Load Duration ' + CAST (DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '====================================================================='


	END TRY
	BEGIN CATCH
		PRINT '=================================================================='
		PRINT 'ERROR OCCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message:' + ERROR_MESSAGE();
		PRINT 'Error Message:' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message:' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=================================================================='
	END CATCH
END
		
