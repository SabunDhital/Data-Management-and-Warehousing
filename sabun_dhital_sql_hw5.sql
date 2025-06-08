--Assignment Homework 5---
----Task 1 Create a Test Table
CREATE TABLE TestCustomers (    --- Creates Table TestCustomers
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100) NOT NULL,
    BuyingGroupID INT NULL,
    PaymentDays INT NULL,
    CreditLimit DECIMAL(18,2) NULL
);

--Task 2: Use SELECT INTO to Copy Data
--Description: Copy a subset of customers from Sales.Customers into TestCustomers, only those with a CreditLimit greater than 2000.
SELECT CustomerID, CustomerName,BuyingGroupID, PaymentDays, CreditLimit
INTO TestCustomers_Copy  
FROM Sales.Customers
WHERE CreditLimit > 2000;

--Task 3: Insert a Single Row
--Description: Insert a single new customer into TestCustomers.
INSERT INTO TestCustomers
	(CustomerName,BuyingGroupID, PaymentDays, CreditLimit)
VALUES
	('Piku Dhital', 0, 7, 2000.00) -- Assign values to column--

--Task 4: Insert Multiple Rows
--Description: Insert three new customers into TestCustomers.
INSERT INTO TestCustomers
	(CustomerName,BuyingGroupID, PaymentDays, CreditLimit)
VALUES
	('Shaira Dhital', 0, 7, 2000.00),   -- Assign values to columns--
	('Robert Pattinson', 0, 7, 3000.00),  -- Assign values to columns--
	('Adi Aryal', 0, 7, 3000.00);         -- Assign values to columns--


--Task 5: Insert Rows with Default and NULL Values
--Description: Insert a new row with NULL values and default values for specific columns.
INSERT INTO TestCustomers 
	(CustomerName, BuyingGroupID, PaymentDays, CreditLimit)
VALUES
	('Chester Benington', Null, 7, Default); --Assign row with Null and Default Values

--Task 6: Insert Rows Selected from Another Table
--Inserting rows from TestCustomers to TestCustomers_Copy
INSERT INTO TestCustomers (CustomerName,BuyingGroupID, PaymentDays, CreditLimit)
 SELECT CustomerName,BuyingGroupID, PaymentDays, CreditLimit
 FROM TestCustomers_Copy;

-----Task 7: Perform an Update Operation
--Description: Update CreditLimit for customers with a NULL value, setting it to 5000.
UPDATE TestCustomers
SET CreditLimit = 5000 
WHERE CreditLimit IS Null;

--Task 8: Use a Subquery in an Update Operation
--Description: Increase the CreditLimit of customers in TestCustomers by 10% if their BuyingGroupID matches an existing BuyingGroupID in Sales.Customers.
UPDATE TestCustomers
SET CreditLimit = CreditLimit * 1.10  
WHERE BuyingGroupID IN 
    (SELECT BuyingGroupID
    FROM Sales.Customers);

--Task 9: Delete Rows Using a Subquery and Joins
--Description: Delete customers from TestCustomers who are not in TestCustomers_Copy.
DELETE TestCustomers
 WHERE CustomerID not in
  (SELECT CustomerID
   FROM TestCustomers_Copy);

--Task 10: Perform a MERGE Operation
--Description: Merge data from TestCustomers_Copy into TestCustomers, updating CreditLimit if a customer exists, inserting a new row otherwise.
MERGE INTO TestCustomers as T
 USING TestCustomers_Copy TC
 ON T.CustomerName =TC.CustomerName
 WHEN MATCHED THEN
 UPDATE SET T.CreditLimit = TC.CreditLimit
 WHEN NOT MATCHED THEN
 INSERT (CustomerName, BuyingGroupID, PaymentDays, CreditLimit)
 VALUES (TC.CustomerName, TC.BuyingGroupID, TC.PaymentDays, TC.CreditLimit);


 

 