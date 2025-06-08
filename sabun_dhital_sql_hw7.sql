--SQL Assignment 7
Use WideWorldImporters;

--Query 1: Advanced String Manipulation with CTE
--Description: Extract the domain name from the EmailAddress column in the Application.People table and count the number
--of occurrences of each domain.
--Concepts: CHARINDEX, SUBSTRING, CTE, COUNT, GROUP BY

WITH EmailProviders as (
SELECT Substring(EmailAddress, CHARINDEX('@', EmailAddress)+1, Len(EmailAddress)) AS DomainName
FROM Application.People
Where EmailAddress is NOT Null
)
SELECT DomainName, Count(*) as DomainCount
FROM EmailProviders
Group by DomainName
Order by DomainCount DESC;

--Query 2: Complex String Problem Solving with Subquery
--Description: Find the top 5 customers with the longest CustomerName in the Sales.Customers table.
--Concepts: LEN, ORDER BY, TOP
SELECT TOP 5 CustomerName, Len(CustomerName) as CustomerNameLength
FROM Sales.Customers
order by Len(CustomerName) Desc;

--Query 3: Advanced Numeric Data Handling with Window Functions
--Description: Calculate the average UnitPrice for each StockItemID in the Sales.OrderLines table, rounded to 2 decimal places, and include the overall average UnitPrice for all items.
--Concepts: AVG, ROUND, GROUP BY, OVER

SELECT StockItemID, Round(Avg(UnitPrice),2) as AverageUnitPrice, Round(Avg(Avg(UnitPrice)) OVER(), 2) as OverAllAverageUnitPrice
FROM Sales.OrderLines
Group By StockItemID;

--Query 4: Floating-Point Number Search with Conditions and Subquery
--Description: Find all StockItems in the Warehouse.StockItems table where the RecommendedRetailPrice is a floating-point number 
--and greater than the average RecommendedRetailPrice.
--Concepts: ISNUMERIC, CAST, AVG, SUBQUERY

SELECT StockItemID, StockItemName, RecommendedRetailPrice
FROM Warehouse.StockItems
WHERE ISNUMERIC(RecommendedRetailPrice)=1 
 AND CAST (RecommendedRetailPrice as float) > 
   (SELECT AVG(cast(RecommendedRetailPrice as float)) from Warehouse.StockItems 
    WHERE ISNUMERIC(RecommendedRetailPrice)=1);

--Query 5: Advanced Date/Time Data Handling with CTE
--Description: Calculate the number of days between the InvoiceDate and the current date for each invoice in the Sales.Invoices table and 
--categorize them into 'Recent' (within 30 days) and 'Old' (more than 30 days).
--Concepts: DATEDIFF, GETDATE, CTE, CASE

With InvoiceTimeline As (
Select InvoiceID, DATEDIFF(Day,InvoiceDate,GETDATE()) as InvoiceStatus
FROM Sales.Invoices )
SELECT InvoiceID, InvoiceStatus,
CASE WHEN InvoiceStatus <=30 then 'Recent'
Else 'Old'
End as InvoiceCategory
FROM InvoiceTimeline;

--Query 6: Parsing and Formatting Dates with Subquery
--Description: Using the InvoiceDate column in the Sales.Invoices table, find the month with the highest number of invoices.
--Concepts: DATENAME, MONTH, GROUP BY, COUNT, ORDER BY, TOP

Select Top 1 DATENAME(month,InvoiceDate) as IMonth, Count(*) as MonthlyInvoiceCount
From Sales.Invoices
Group by DATENAME(month,InvoiceDate)
Order by MonthlyInvoiceCount Desc;

--Query 7: Advanced Date Operations with Window Functions
--Description: Calculate the end of the month for each InvoiceDate in the Sales.Invoices table and
--find the running total of invoices for each month.
--Concepts: EOMONTH, COUNT, OVER, PARTITION BY

SELECT InvoiceID, InvoiceDate, EOMONTH(InvoiceDate) as EndofMonth,
Count(*) OVER (Partition by EOMONTH(InvoiceDate) ORDER by InvoiceDate) as RunningTotal
FROM Sales.Invoices;

--Query 8: Complex CASE Expression with Joins
--Description: Categorize StockItems based on their QuantityPerOuter and RecommendedRetailPrice in the Warehouse.StockItems table 
--and include the supplier name from the Purchasing.Suppliers table.
--Concepts: CASE, JOIN

SELECT SI.StockItemName, S.SupplierName, SI.QuantityPerOuter,SI.RecommendedRetailPrice,
 Case
 WHEN SI.QuantityPerOuter > 100 and SI.RecommendedRetailPrice > 50 THEN 'High Quantity and High Price'
 WHEN SI.QuantityPerOuter > 100 and SI.RecommendedRetailPrice <= 50 THEN 'High Quantity and Low Price'
 WHEN SI.QuantityPerOuter <= 100 and SI.RecommendedRetailPrice > 50 THEN 'Low Quantity and High Price'
 Else 'Low Quantity and Low Price'
 End AS Category
From Warehouse.StockItems SI
JOIN Purchasing.Suppliers S ON SI.SupplierID = S.SupplierID;

--Query 9: Advanced COALESCE Usage with Window Functions
--Description: Replace NULL values in the CustomerCategoryID column of the Sales.Customers table with the average 
--CustomerCategoryID and include the overall average for reference.
--Concepts: COALESCE, AVG, OVER
SELECT CustomerID, CustomerName,
COALESCE(CustomerCategoryID, Avg(CustomerCategoryID) OVER ()) As CustomerCategoryID,
Avg(CustomerCategoryID) OVER() AS OverallAverageCategoryID
FROM Sales.Customers ;

--Query 10: Advanced Ranking Functions with CTE and Subquery
--Description: Rank Customers based on their total InvoiceAmount in descending order, and include only those customers whose total invoice amount is above the average. Use the Sales.Customers, Sales.Invoices, and Sales.InvoiceLines tables.
--Concepts: RANK, SUM, OVER, JOIN, CTE, SUBQUERY

with CustomerTotals as(
SELECT C.CustomerID, C.CustomerName, Sum(IL.ExtendedPrice) As TotalInvoiceAmount,
Rank() over (Order by Sum(IL.ExtendedPrice) Desc) As CustomerRank
FROM Sales.Customers C
Join Sales.Invoices I ON C.CustomerID=I.CustomerID
Join Sales.InvoiceLines IL ON I.InvoiceID=IL.InvoiceID
Group by C.customerID,C.CustomerName 
)
SELECT CustomerID, CustomerName, TotalInvoiceAmount, CustomerRank
FROM CustomerTotals
WHERE TotalInvoiceAmount >(SELECT Avg(TotalInvoiceAmount)FROM CustomerTotals);