use WideWorldImporters;

--Section 1: Data Conversion with CAST
--1.	Converting Data Types with CAST:
--Retrieve the InvoiceID (integer) and calculate the total invoice amount by summing the ExtendedPrice (money) from the Sales.InvoiceLines table for each invoice.
--Convert the total invoice amount to VARCHAR(20) using CAST and display both the original and converted values.
--You will need to use a subquery in the FROM clause to get the total invoice amount:

SELECT IL.InvoiceID, IL.TotalInvoiceAmount, CAST(IL.TotalInvoiceAmount AS varchar(20)) AS ConvertedTotalInvoiceAmount  
from (
        SELECT I.InvoiceID, SUM(ExtendedPrice) AS TotalInvoiceAmount
         FROM Sales.InvoiceLines AS I
	Group by I.InvoiceID) as IL;
 

--2.	Integer Division with CAST:
--o	Retrieve the OrderID and Quantity from Sales.OrderLines, and divide Quantity by 3.
--o	Display the result before and after using CAST to convert Quantity to DECIMAL(10,2), ensuring proper division.

Select OrderID, Quantity, (Quantity/3) as QuantityDivided,
Quantity/CAST(3 as Decimal(10,2)) as QuantityAfterCast  
from Sales.OrderLines;

--3.	Formatting Date Using CONVERT:
--o	Retrieve InvoiceID and InvoiceDate from Sales.Invoices.
--o	Use CONVERT to display InvoiceDate in the following formats: 
--	101 (MM/DD/YYYY)
--	103 (DD/MM/YYYY)
--	120 (YYYY-MM-DD HH:MI:SS)

SELECT InvoiceID,
CONVERT (varchar, InvoiceDate, 101) as VarcharDate,  --Converting invoice date to different date format
CONVERT (varchar, InvoiceDate, 103) as VarcharDate,
COnvert (varchar, InvoiceDate, 120) as VarcharDate
 FROM Sales.Invoices;


-- 4.	Converting Real to Character Using CONVERT:
--o	Retrieve TypicalWeightPerUnit from Warehouse.StockItems where TypicalWeightPerUnit is greater than 5.
--o	Convert it to VARCHAR(20) using CONVERT and display both original and converted values.

SELECT TypicalWeightPerUnit,
CONVERT (varchar, TypicalWeightPerUnit, 20) as ConvertedWeightPerUnit  --Using CONVERT to convert to VARCHAR 20
FROM Warehouse.StockItems 
where TypicalWeightPerUnit > 5;


--5.	Converting Money to Character Using CONVERT:
--o	Retrieve the invoice ID and total invoice amount calculated by summing the ExtendedPrice from the Sales.InvoiceLines table for each invoice where the total is greater than 500. You will need to use a similar approach to build your query as in Problem 1.
--o	Convert it to VARCHAR(20) using CONVERT with style 1 (commas as thousand separators) and style 0 (default).
--o	Display the original and converted values.
SELECT IL.InvoiceID, IL.TotalInvoiceAmount, 
CONVERT(VARCHAR(20), TotalInvoiceAmount, 0) as 'TotalInvoiceAmount Style1',  --Using VARCHAR 20 and Style 0
CONVERT(VARCHAR(20) , TotalInvoiceAmount, 1) as 'TotalInvoiceAmount Style0'    --Using VARCHAR 20 and Style 1
from (
       SELECT I.InvoiceID, SUM(ExtendedPrice) as TotalInvoiceAmount
       FROM Sales.InvoiceLines as I
	   Group by I.InvoiceID
HAVING sum(ExtendedPrice) > 500) as IL;

-- Section 3: Error Handling with TRY_CONVERT
--6.	Using TRY_CONVERT to Handle Conversion Errors: 
--o	Attempt to convert StockItemName from Warehouse.StockItems to INT using TRY_CONVERT.
--o	Return NULL values for non-convertible data instead of throwing an error.

Select StockItemID, StockItemName,
TRY_CONVERT(INT, StockItemName) as ConvertedStockItemName  --Converting stock item name to INT using TRY_CONVERT
FROM Warehouse.StockItems;

--7.	Using STR to Convert Numeric Data:
--o	Retrieve TypicalWeightPerUnit from Warehouse.StockItems where TypicalWeightPerUnit is greater than 5.
--o	Convert it to CHAR(10) using STR and display both original and converted values.

SELECT  TypicalWeightPerUnit,
str(TypicalWeightPerUnit, 10) as TypicalWeightPerUnitConverted  --Using STR to convert to char 10
FROM Warehouse.StockItems
WHERE TypicalWeightPerUnit >5;

--8.	Using CHAR and ASCII to Examine Character Codes:
--o	Retrieve CustomerName from Sales.Customers where CustomerID is less than 10.
--o	Extract the first letter of each CustomerName and display its ASCII code using ASCII.

SELECT CustomerName,substring(CustomerName, 1, 1) AS NameInitials,
ASCII(CustomerName) as ASCIICODE  -- Using ASCII to extract first letter ASCII Code
From Sales.Customers
WHERE CustomerID<10;


--9.	Using NCHAR and UNICODE to Work with Unicode Data:
--o	Retrieve CustomerName from Sales.Customers where CustomerID is less than 10.
--o	Extract the first letter and display both its Unicode representation using UNICODE and its character equivalent using NCHAR.

SELECT CustomerName,
UNICODE(CustomerName) as CustomerNameUnicode,  --Extracting first letter using UNICODE
NChar(UNICODE(CustomerName)) as NCharEquivalent  --Using NCHAR to obtain character equivalent
FROM Sales.Customers
WHERE CustomerID < 10;


--10.	Challenge: Using Multiple Conversions Together:
--o	Retrieve InvoiceID, InvoiceDate, and calculate the total invoice amount by summing the ExtendedPrice from the Sales.InvoiceLines table for each invoice where the total is greater than 5000.
--o	Convert InvoiceDate to VARCHAR(10) format YYYY-MM-DD using CONVERT.
--o	Convert the total invoice amount to VARCHAR(20) using CAST.
--o	Display all converted values along with original data.


SELECT I.InvoiceID, I.InvoiceDate, IL.TotalInvoiceAmount,
CONVERT(Varchar(10), I.InvoiceDate, 111) as 'Date Format',    --converting InvoiceDate using Vrachar10--
CAST(IL.TotalInvoiceAmount as varchar(20)) as 'TotalInvoiceAmount Converted'  --Foramtting TotalInvoice Amount to using Vrachar20--
 FROM Sales.Invoices I
 JOIN                      --Joining InvoicesTable to InvoicesLines using subquery--
 (SELECT InvoiceID, SUM(ExtendedPrice) AS 'TotalInvoiceAmount'
FROM Sales.InvoiceLines
Group by InvoiceID
Having Sum(ExtendedPrice) > 5000) as IL
 ON I.InvoiceID = IL.INVOICEID;






 
