-- SQLHW1---
Use WideWorldImporters;

--1. Code Column Specifications and Name Columns in the Result Set--
--Retrieve the name, buying group ID and website of all customers from the Sales.Customers table. --
--Rename the columns as Customer Name, Buying Group, and Website URL in the result set.--

SELECT 
CustomerName as "Customer Name", BuyingGroupID as "Buying Group", WebsiteURL as "Website URL"
FROM Sales.Customers;

--2. Code String Expressions
--Retrieve the full name of each employee from the Application.People table by 
--concatenating their FullName with the string "- Employee". 
--Rename the column as Employee Full Name.

SELECT 
FullName +'-'+' '+'Employee' As "Employee Full Name"
FROM Application.People;

--3. Code Arithmetic Expressions
--Retrieve the StockItemID, UnitPrice, and a new column called Discounted Price from Warehouse.StockItems. 
--The Discounted Price should be 90% of the UnitPrice (i.e., a 10% discount).--

SELECT 
StockItemID, UnitPrice, UnitPrice*0.90 as "Discounted Price"
FROM Warehouse.StockItems;

--4. Use Functions
--Retrieve the FullName and the length of the Full Name from Application.People. 
--Rename the computed column as Name Length.

SELECT  
FullName, Len(FullName) as "Name Length"
FROM Application.People;

--5.Use DISTINCT to Eliminate Duplicate Rows
--Retrieve all unique cities from the Application.Cities table.
SELECT 
DISTINCT CityName
FROM Application.Cities;

--6. Use the TOP Clause to Return a Subset of Selected Rows
--Retrieve the top 5 most expensive stock items (StockItemID and UnitPrice) from 
--the Warehouse.StockItems table, sorted in descending order of UnitPrice.

SELECT TOP 5 
StockItemID, UnitPrice
FROM Warehouse.StockItems
ORDER BY UnitPrice Desc;

--7. Use Comparison Operators with Logical Operators (AND, OR, NOT)
--Retrieve all customers from Sales.Customers where BuyingGroupID is greater than 1 and 
--the IsOnCreditHold field is false.

SELECT 
CustomerID,CustomerName,BuyingGroupID,IsOnCreditHold
FROM Sales.Customers
WHERE BuyingGroupID >1 AND IsOnCreditHold=0;

--8. Use IN, BETWEEN, and LIKE Operators
--Retrieve all stock items (StockItemName, UnitPrice) from Warehouse.StockItems where:
--•	The StockItemID is either 10, 20, or 30 (use IN operator).
--•	The UnitPrice is between 5 and 50 (use BETWEEN operator).
--•	The StockItemName contains the word "Chocolate" (use LIKE operator).

SELECT 
StockItemName, UnitPrice
FROM Warehouse.StockItems
WHERE StockItemID IN (10,20,30)
AND UnitPrice BETWEEN 5 and 50
AND StockItemName LIKE '%Chocolate%';

--9. Use IS NULL Clause
--Retrieve all suppliers (SupplierName) from Purchasing.Suppliers where the FaxNumber is NULL.

SELECT SupplierName
FROM Purchasing.Suppliers
WHERE FaxNumber IS NULL;

--10. Sort a Result Set by Column Name, Alias, Expression, and Column Number
--Retrieve the top 10 orders (InvoiceID, TransactionDate, and TransactionAmount) from the Sales.CustomerTransactions table, sorted by:
--•	TransactionDate in descending order (column name).
--•	TotalAmount ascending (alias).
--•	InvoiceID descending (column number).

SELECT top 10 
InvoiceID, TransactionDate, TransactionAmount AS TotalAmount
FROM Sales.CustomerTransactions
ORDER BY TransactionDate Desc, TotalAmount ASC, InvoiceID Desc;


