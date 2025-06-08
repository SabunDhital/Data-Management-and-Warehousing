-- SQL HW1--
--*1.	Write a query to retrieve a list of customers and their sales orders, displaying the customer name and order date. Use table aliases for readability.
--a.	Tables: Sales.Customers, Sales.Orders

SELECT C.CustomerName, O.OrderDate, O.OrderID
from Sales.Customers as C
   inner join  Sales.Orders as O on C.CustomerID =O.CustomerID;

--2. Retrieve a list of stock items, purchase prices, order dates, and supplier names for items that do not require refrigeration.
--a.	Tables: Warehouse.StockItems, Purchasing.PurchaseOrderLines, Purchasing.PurchaseOrders, Purchasing.Suppliers
--b.	The PurchaseOrderLines table links stock items to purchase orders, which in turn links to suppliers.

select PS.StockItemID, StockItemName, PS.UnitPrice as Purchase_Prices, P.OrderDate, PD.SupplierName
from Purchasing.PurchaseOrderLines as PL
INNER JOIN Warehouse.StockItems as PS ON PL.StockItemID=PS.StockItemID
INNER JOIN Purchasing.PurchaseOrders as P ON PL.PurchaseOrderID = P.PurchaseOrderID
INNER JOIN Purchasing.Suppliers as PD ON P.SupplierID = PD.SupplierID
Where PS.IsChillerStock =0;

--3.	Retrieve the names of employees from the WideWorldImporters database along with the order numbers they serviced in the WideWorldImportersDW 
--database. a.	Tables: WideWorldImporters.Application.People, WideWorldImportersDW.Fact.[Order]
Select P.FullName as EmployeeName, F.[WWI Order ID]
FROM WideWorldImporters.Application.People as P
INNER JOIN  WideWorldImportersDW.Fact.[Order] AS F ON P.PersonID = F.[WWI Order ID]
WHERE IsEmployee>0;

 
--4.	Retrieve a list of customers located in the same city as another customer. The output should include:
--a.	The first customer's name.
--b.	The second customer's name (who is from the same city).
--c.	The city they both share.
--d.	Tables: Sales, Customers, Application, Cities. To join the tables, use DeliveryCityID from the Customers table.

SELECT C.CustomerName as First_Customer_Name, C1.CustomerName as Second_Customer_Name, CT.CityName
FROM Sales.Customers as C
INNER JOIN Sales.Customers as C1 ON C.DeliveryCityID=C1.DeliveryCityID
AND C.CustomerID < C1.CustomerID 
INNER JOIN Application.Cities as CT ON C.DeliveryCityID =CT.CityID
ORDER BY ct.CityName, C.CustomerName, C1.CustomerName;

--5.	Retrieve a list of orders along with customer names and the stock items they purchased.
--a.	Tables: Sales.Orders, Sales.OrderLines, Warehouse.StockItems, Sales.Customers

SELECT SO.OrderID, C.CustomerName, SI.StockItemName
FROM Sales.Orders SO
INNER JOIN Sales.OrderLines as SOL ON SO.OrderID=SOL.OrderID
INNER JOIN Sales.Customers as C ON SO.CustomerID=C.CustomerID
INNER JOIN Warehouse.StockItems as SI ON SOL.StockItemID=SI.StockItemID
Order by OrderID;

--6.	Retrieve a list of invoices along with customer details using implicit join syntax instead of INNER JOIN.
--a.	Tables: Sales.Invoices, Sales.Customers
SELECT SI.InvoiceID, SI.InvoiceDate, SC.CustomerName
FROM Sales.Invoices SI, Sales.Customers as SC
WHERE SI.CustomerID=SC.CustomerID
ORDER BY InvoiceID;

--7.	Retrieve a list of customers and their orders, ensuring that all customers appear in the output, even if they have no orders.
--a.	Tables: Sales.Customers, Sales.Orders
SELECT O.OrderID, O.OrderDate, C.CustomerName
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O ON C.CustomerID=O.OrderID
AND OrderID >0
ORDER BY OrderID;

--8.	Retrieve a list of orders, including details of the customer and salesperson, ensuring that all orders appear even if the customer or salesperson information is missing.
--a.	Tables: Sales.Orders, Sales.Customers, HumanResources.Employees
SELECT O.OrderID, O.SalespersonPersonID, O.OrderDate, S.CustomerName
FROM Sales.Orders as O 
LEFT JOIN Sales.Customers as S ON O.CustomerID=S.CustomerID
LEFT JOIN Application.People as PE ON O.SalespersonPersonID =PE.PersonID;

--9.	Generate a combination of all possible stock items and suppliers.
--a.	Tables: Warehouse.StockItems, Purchasing.Suppliers
SELECT SI.StockItemID, SI.StockItemName, PS.SupplierName
FROM Warehouse.StockItems as SI
CROSS JOIN Purchasing.Suppliers as PS;

--10.	Retrieve:
--a.	A list of customers who have placed an order but have not received an invoice.
--b.	A list of customers who have placed an order and also received an invoice.
--c.	Tables: Sales.Customers, Sales.Orders, Sales.Invoices

--a A list of customers who have placed an order but have not received an invoice.
SELECT CustomerID FROM Sales.Orders
EXCEPT
SELECT customerID from Sales.Invoices;

--b. A list of customers who have placed an order and also received an invoice.
SELECT CustomerID from Sales.Orders
INTERSECT
SELECT CustomerID FROM Sales.Invoices;



















