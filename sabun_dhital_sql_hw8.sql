--Problem 1: Create a Simple View
--Objective: Understand how to define a basic view.
--Task: Create a view named vw_CustomerContacts that includes the CustomerID, CustomerName, and PhoneNumber from the Sales.Customers table.

CREATE VIEW vw_CustomerContacts as
SELECT CustomerID, CustomerName, PhoneNumber
FROM Sales.Customers;
GO

--Problem 2: Restrict Access via View
--Objective: Learn how to use views to restrict sensitive columns.
--Task: Create a view named vw_PublicSuppliers that returns only the SupplierID, SupplierName, and PhoneNumber from the Purchasing.Suppliers table, excluding credit and bank-related information.

CREATE VIEW vw_PublicSuppliers as
SELECT SupplierID, SupplierName, PhoneNumber
FROM Purchasing.Suppliers;
GO

--Problem 3: Create View with a Join
--Objective: Demonstrate joining tables inside a view.
--Task: Create a view named vw_InvoiceDetails that joins Sales.InvoiceLines and Sales.Invoices, returning InvoiceID, InvoiceDate, 
--StockItemID, and Quantity.
CREATE VIEW vw_InvoiceDetails AS
Select IL.InvoiceID, SI.InvoiceDate, IL.StockItemID, IL.Quantity
FROM Sales.InvoiceLines as IL
Inner Join Sales.Invoices as SI on IL.InvoiceID=SI.InvoiceID
GO

--Problem 4: Create a View with TOP and ORDER BY
--Objective: Create views that use ordering and row limits.
--Task: Create a view vw_Top10ExpensiveItems that shows the top 10 most expensive stock items by UnitPrice from Sales.InvoiceLines.
CREATE VIEW vw_Top10ExpensiveItems as
SELECT Top 10 StockItemID, UnitPrice
FROM Sales.InvoiceLines
ORDER by UnitPrice Desc;
GO

--Problem 5: View with UNION ALL and Column Aliases
--Objective: Combine multiple data sources into one view.
--Context: You want to create a unified view of people who are either suppliers or customers.
--Task: Create a view vw_Contacts that combines customer and supplier contact info (name and phone), with a column indicating their role.
CREATE VIEW vw_Contacts as
SELECT CustomerName as Name, PhoneNumber, 'Customer' as RoleType
FROM Sales.Customers
UNION all
SELECT SupplierName, PhoneNumber, 'Supplier'
FROM Purchasing.Suppliers
GO

--Problem 6: Create Summary View with SCHEMABINDING
--Objective: Build a summary view that can’t be broken by schema changes.
--Task: Create a view vw_SalesSummary that summarizes total invoice amounts per customer using Sales.Invoices, 
--with the WITH SCHEMABINDING option.
CREATE VIEW vw_SalesSummary
WITH SCHEMABINDING
AS 
SELECT SC.CustomerID, COUNT_BIG(*) as NumberofInvoices, sum(IL.ExtendedPrice) as TotalAmount
FROM Sales.Invoices as SC
Inner Join Sales.InvoiceLines as IL ON SC.InvoiceID=IL.InvoiceID
GROUP BY SC.CustomerID
GO

--Problem 7: Create an Updatable View
--Objective: Understand conditions for view updateability.
--Task: Create a view vw_MyTestCustomers that shows CustomerID, CustomerName, and PhoneNumber from Sales.Customers. 
--Then insert a new row into the view.
CREATE VIEW vw_TestCustomers as
Select CustomerID, CustomerName, PhoneNumber
FROM Sales.Customers;


INSERT INTO vw_MyTestCustomers (CustomerID, CustomerName, PhoneNumber)
VALUES ('Saira Dhital', '305555-0100');
GO

--Result: New row cannot be inserted--

--Problem 8: Create a Read-Only View
--Objective: Prevent data modifications via a view.
--Task: Create a view vw_ReadOnlyCustomers based on Sales.Customers that includes a computed column CustomerInfo = CustomerName + PhoneNumber.

CREATE vw_ReadOnlyCustomers as 
Select  CustomerID, CustomerName, PhoneNumber, CustomerName+ '-' + PhoneNumber as CustomerInfo
From Sales.Customers;
GO

--Problem 9: Modify and Delete Views
--Objective: Manage view lifecycle.
--Task A: Create a view vw_StaffEmails listing PersonID, FullName, and EmailAddress from Application.People.
--Task B: Modify the view to include only staff with non-null email.
--Task C: Drop the view.

--Task A--Creating view vw_StaffEmails listing PersonID, FullName, and EmailAddress 
CREATE VIEW vw_StaffEmails as
SELECT PersonID, FullName, EmailAddress 
FROM Application.People
GO

--TASK B--Modifying the view to include only staff with non-null email.
ALTER VIEW vw_StaffEmails as
SELECT PersonID, FullName, EmailAddress
FROM Application.People
WHERE EmailAddress IS NOT NULL;
GO

--Task C-- Dropping the view.
Drop VIEW vw_StaffEmails;
GO

--Problem 10: Use Views and Catalog View
--Objective: Use metadata views to explore schemas and update through a view.
--Task A: Select name and schema of all views using sys.views and sys.schemas.
--Task B: Update a row using a view and enforce integrity with WITH CHECK OPTION.

--Task A Solution: selecting name and schema of all views--
SELECT V.name AS ViewName, s.name AS SchemaName
FROM sys.views V
INNER JOIN sys.schemas S ON V.schema_id = S.schema_id;

--Task B Solution--
CREATE VIEW Sales.vw_CustomerInfo AS
SELECT CustomerID, CustomerName, PhoneNumber
FROM Sales.Customers
WHERE CustomerName LIKE 'Test%'
WITH CHECK OPTION;

--Updating view Sales.vw_CustomerInfo
--UPDATE Sales.vw_CustomerInfo
--SET PhoneNumber = '(666) 787-8901'
--­WHERE CustomerID = 1






