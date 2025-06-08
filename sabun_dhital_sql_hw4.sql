-- Problem 1---
--Basic Subquery with the IN Operator
--Description: Retrieve the CustomerName and CustomerID of customers who have placed orders within 30 days of the most recent order date in the database.
--Tables: Sales.Orders, Sales.Customers
--Rows returned: 624

SELECT C.CustomerID, C.CustomerName
FROM Sales.Customers as C
WHERE CustomerID IN (
    SELECT Distinct CustomerID
    FROM Sales.Orders as O
	Where O.OrderDate >=
	 DATEADD(day, -30, (Select MAX(OrderDate) from Sales.Orders)));

--Problem 2---
--Description: Write two queries to list the names of salespersons who have processed orders with a total order value over $10,000: one using a subquery and 
--the other using a JOIN. (Note: The total order value should be calculated by summing the UnitPrice * Quantity from Sales.OrderLines.)
--Tables: Sales.Orders, Sales.OrderLines, Application.People
--Rows returned: 10

SELECT DISTINCT P.FullName as 'Full Name'
FROM Application.People as P
WHERE PersonID IN(
   SELECT SO.SalespersonPersonID
   FROM Sales.Orders as SO
   Inner join Sales.Orderlines as SOL ON SO.OrderID= SOL.OrderID
   Group by SO.SalespersonPersonID
   HAVING SUM(SOL.UnitPrice * SOL.Quantity) > 10000
);

SELECT Distinct P.FullName as 'Full Name'
FROM Application.People as P
INNER JOIN Sales.Orders as SO on P.PersonID=SO.SalespersonPersonID
INNER JOIN Sales.Orderlines as SOL ON SO.OrderID= SOL.OrderID
Group by P.FullName
HAVING SUM(SOL.UnitPrice*SOL.Quantity)>10000;


--3. Subquery with Expression Comparison
--Description: Find all stock items whose UnitPrice is higher than the average unit price of all stock items.
--Tables: Warehouse.StockItems
--Rows returned: 27
SELECT StockItemID, StockItemName
FROM   Warehouse.StockItems
WHERE UnitPrice > 
(SELECT avg(UnitPrice) FROM Warehouse.StockItems)


--4. Using the ALL Keyword
--Description: Retrieve the CustomerName for customers whose total order value is higher than all customers from the same city. 
--(Note: Use the Application.Cities table to obtain city information since Sales.Customers does not contain the CityName column.)
--Tables: Sales.Orders, Sales.OrderLines, Sales.Customers, Application.Cities
--Rows returned: 8

SELECT SC.CustomerID, SC.CustomerName
FROM Sales.Customers as SC
 INNER JOIN Application.Cities as CI
  ON SC.DeliveryCityID=CI.CityID
WHERE (
        select SUM(OL.UnitPrice * OL.Quantity)
		from sales.orders as SO
		   Inner JOIN Sales.OrderLines as OL
		   ON SO.OrderID=OL.ORDERID
		where SO.CustomerID = SC.CustomerID
)
>ALL (
       SELECT SUM(OL2.UnitPrice * OL2.Quantity)
       FROM Sales.Orders as SO2
          INNER JOIN Sales.OrderLines OL2 ON SO2.OrderID = OL2.OrderID
	      INNER JOIN Sales.Customers SC2 ON SO2.CustomerID = SC2.CustomerID
	      inner join Application.Cities CI2 ON SC2.DeliveryCityID=CI2.CityID
	  WHERE CI2.CityID=CI.CityID and SC2.CustomerID <>SC.CustomerID
	);


--5. Using ANY and SOME Keywords
--Description: List products whose UnitPrice is higher than any product in the 'Clothing' stock group. (Note: Use the Warehouse.StockGroups and Warehouse.StockItemStockGroups tables to determine product categories.)

SELECT SI.StockItemName
from Warehouse.StockItems as SI
WHERE SI.UnitPrice > any(
   select SI2.UnitPrice
   FROM Warehouse.StockItems as SI2
     INNER JOIN WareHouse.StockItemStockGroups as SISG2
	   ON SI2.StockItemID=SISG2.StockItemID
	 INNER JOIN Warehouse.StockGroups as SG2
       ON SISG2.StockItemStockGroupID=SG2.StockGroupID
    WHERE SG2.StockGroupName ='Clothing'
    ) ;
      
     
--6. Correlated Subquery
--Description: Retrieve a list of customers and the number of orders they placed, only including customers with more than 140 orders.
--Tables: Sales.Orders, Sales.Customers
--Rows returned: 9

SELECT SC.CustomerName, Count(SO.OrderID) as NumberofOrders
FROM Sales.Customers as SC
INNER JOIN Sales.Orders as SO on SC.CustomerID=SO.CustomerID
GROUP BY SC.CustomerName
Having Count(SO.OrderID)>140;

--7. Using EXISTS Operator
--Description: List customers who have never placed an order.
--Tables: Sales.Customers, Sales.Orders
--Rows returned: 0

SELECT SC.CustomerID, SC.CustomerName 
FROM Sales.Customers as SC
 WHERE NOT EXISTS 
 (SELECT* FROM Sales.Orders as SO
 WHERE SC.CustomerID =SO.CustomerID)


-- 8. Subquery in the FROM Clause
--Description: For each salesperson, show the total sales amount and the number of orders processed.
--Tables: Sales.Orders, Sales.OrderLines, Application.People
--Rows returned: 10

SELECT AP.FullName as SalesPersonName, Summary.TotalSalesAmount, Summary.NumberOfOrders
FROM Application.People as AP
	INNER JOIN (
		SELECT SO.SalespersonPersonID,sum(SOL.UnitPrice * SOL.Quantity) as TotalSalesAmount, count(SO.OrderID) as NumberOfOrders	  
		FROM Sales.Orders as SO
		INNER JOIN Sales.OrderLines as SOL on SO.OrderID = SOL.OrderID
		Group by SO.SalespersonPersonID) as Summary
		ON AP.PersonID = Summary.SalespersonPersonID






--9. Subquery in the SELECT Clause
--Description: List all products along with the number of times they have been ordered.
--Tables: Sales.OrderLines, Warehouse.StockItems
--Rows returned: 227

SELECT WS.StockItemID, WS.StockItemName,
(SELECT Count(*) FROM Sales.OrderLines as SO
WHERE SO.StockItemID=WS.StockItemID) as TimesOrdered
FROM Warehouse.StockItems as WS 
ORDER BY TimesOrdered Desc;


-- 10. Complex Query with a CTE
--Description: Create a CTE that calculates the total order value for each customer and retrieves customers whose 
--total order value exceeds $350,000. Use the CTE to simplify the main query and make it more readable.
--Tables: Sales.Orders, Sales.OrderLines, Sales.Customers
--Rows returned: 20

 WITH CustomerOrderSummary as (
    SELECT SC.CustomerID, SC.CustomerName, sum(SOL.UnitPrice * SOL.Quantity) AS TotalOrderValue
    FROM Sales.Customers as SC
    INNER JOIN Sales.Orders as SO ON SC.CustomerID = SC.CustomerID
    INNER  JOIN Sales.OrderLines as SOL ON SO.OrderID = SO.OrderID
    GROUP BY SC.CustomerID,SC.CustomerName
)
SELECT CustomerID, CustomerName, TotalOrderValue
FROM CustomerOrderSummary
WHERE TotalOrderValue>35000;









 




 
 
