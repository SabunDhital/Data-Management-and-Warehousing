--1. Declare and Use Scalar Variables
--Objective: Demonstrate the use of scalar variables in a script.
--Description: Declare a scalar variable named @AvgUnitPrice and assign it the average UnitPrice from
--the Sales.InvoiceLines table. 
--Display the value of the variable using a SELECT statement. 
--This exercise helps you understand scalar variable 
--declaration, assignment, and output.

Declare @AvgUnitPrice decimal(18,2);

SELECT @AvgUnitPrice=avg(UnitPrice)
FROM Sales.InvoiceLines;
SELECT @AvgUnitPrice as 'Average Unit Price';


--2. Use Table Variables
--Objective: Use table variables to store and manipulate data.
--Description: Define a table variable to capture the top 5 customers based on the sum of
--ExtendedPrice. Join the Sales.InvoiceLines table with Sales.Invoices to get the CustomerID. 
--Group by CustomerID and use an ORDER BY clause with OFFSET FETCH to select only the top 5. 
--Then display the results. This will help you learn how to work with table variables and aggregate joins.

DECLARE @TopCustomers table 
   (CustomerID int , TotalExtendedAmount decimal (18,2));
INSERT @TopCustomers
SELECT I.CustomerID, sum(IL.ExtendedPrice) as TotalExtendedAmount
FROM Sales.InvoiceLines as IL
INNER JOIN Sales.Invoices as I ON I.InvoiceID=IL.InvoiceID
Group by I.CustomerID
Order by TotalExtendedAmount Desc
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;

SELECT * FROM @TopCustomers;

--3. Use Temporary Tables
--Objective: Work with temporary tables and populate data from an existing table.
--Description: Create a temporary table named #HeavyStockItems that includes StockItemID,
--StockItemName, and TypicalWeightPerUnit for all stock items where the typical weight per unit is greater
--than 500 from the Warehouse.StockItems table. Display the contents and drop the table afterward. 
--This reinforces how to use SELECT INTO for temp table creation and cleanup.

SELECT StockItemID, StockItemName, TypicalWeightPerUnit
INTO #HeavyStockItems
FROM Warehouse.StockItems
WHERE TypicalWeightPerUnit > 500;

SELECT * FROM #HeavyStockItems;

DROP Table #HeavyStockItems;


--4. Conditional Script Execution
--Objective: Demonstrate conditional logic using IF...ELSE statements.
--Description: Count how many invoices exist in the Sales.Invoices table. If the count is greater than 1000, 
--print a message stating that. Otherwise, print a message indicating fewer invoices. 
--This teaches you to use IF...ELSE logic with scalar variables and PRINT statements.

DECLARE @InvoiceList Int;
 SELECT @InvoiceList= count(*)
 FROM Sales.Invoices
 IF @InvoiceList >1000
 PRINT 'The Invoice List is More than 1000'
 ELSE 
 PRINT 'The Invoice List is 1000 or Less than 1000'


-- 5. Existence Check for Object
--Objective: Use IF EXISTS to test for an object before creating or dropping it.
--Description: Check for the existence of a temporary table named #TestTable using OBJECT_ID.
--If it exists, drop it. Then create a new temporary table with columns ID (int) and Name (nvarchar). 
--This is useful for ensuring repeatable scripts.

 IF OBJECT_ID('tempdb..#TestTable') IS NOT NULL
 DROP TABLE #TestTable;

 CREATE Table #TestTable (ColumnID int, Name nvarchar(100)) ;

-- 6. Repetitive Processing with WHILE
--Objective: Demonstrate the use of WHILE loop for repetition.
--Description: Use a WHILE loop to print the numbers 1 to 5. Store a 
--counter variable and increment it in each loop iteration. Use PRINT statements
--to output each number. This demonstrates repetitive logic and basic loop constructs.

Declare @Counter INT =1;
  WHILE @Counter <=5
BEGIN
PRINT 'Count Value is :' + Cast(@Counter as NVARCHAR)
SET @Counter = @Counter+1;
END
 
--7. Cursor Usage
--Objective: Use a cursor to iterate through a result set.
--Description: Declare and use a cursor to fetch and print customer 
--names one-by-one from the Sales.Customers table. This exercise demonstrates cursor 
--declaration, fetching, iteration, and cleanup using CLOSE and DEALLOCATE.

DECLARE @CustomerName NVARCHAR(100);

DECLARE CustomerListCursor CURSOR FOR
SELECT CustomerName FROM Sales.Customers;
OPEN CustomerListCursor;
FETCH NEXT FROM CustomerListCursor INTO @CustomerName;

WHILE @@FETCH_STATUS = 0
BEGIN
 PRINT @CustomerName;
 FETCH NEXT FROM CustomerListCursor INTO @CustomerName;
END

CLOSE CustomerListCursor;
DEALLOCATE CustomerListCursor;

--8. Error Handling
--Objective: Use TRY...CATCH to handle errors in scripts.
--Description: Use a TRY...CATCH block to attempt a division by zero operation.
--If an error occurs, catch it and print an informative error message. This reinforces
--error detection and graceful handling of unexpected issues.
BEGIN TRY
   Declare @top_value int = 8;
   Declare @bottom_value int = 0;
   SELECT @top_value/@bottom_value as Result;
END TRY
BEGIN CATCH 
 PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) +': ' + ERROR_MESSAGE();
END CATCH;

---9. Session Settings
--Objective: Use SET statements to configure session options.
--Description: Use SET NOCOUNT ON to prevent the row count message from being returned 
--during insert operations. Create a temporary table, insert a value, then display the contents. 
--Drop the table and turn SET NOCOUNT OFF afterward.
SET NOCOUNT ON;
Create Table #TempCustomerTable (CustomerName NVarchar (100))
INSERT INTO #TempCustomerTable Values('Saira')
SELECT *FROM #TempCustomerTable;
SET NOCOUNT OFF;
DROP TABLE #TempCustomerTable;

--10. Dynamic SQL
--Objective: Demonstrate use of dynamic SQL for flexibility.
--Description: Declare a variable @TableName with a value of 'Sales.Invoices'.
--Build a SQL string to select the top 5 rows from that table and execute it
--using sp_executesql. This shows how to use dynamic SQL for flexible scripting.

DECLARE @TableName NVARCHAR (50) = 'Sales.Invoices';
DECLARE @SQL NVARCHAR(MAX);
SET @SQL =' Select TOP 5 * FROM '  + @TableName;
EXEC sp_executesql @SQL;