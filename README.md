
SQL Homework Assignments
This repository contains a collection of SQL homework assignments demonstrating various database concepts and techniques using the WideWorldImporters database.

## Files Overview

#### `sabun_dhital_sql_hw1.sql`
- Basic SQL queries
- Column aliasing, expressions, functions
- Filtering with `WHERE`, `IN`, `BETWEEN`, `LIKE`, `IS NULL`
- `ORDER BY`, `TOP`, and conditional operators

#### `sabun_dhital_sql_hw2.sql`
- Joins: `INNER`, `LEFT`, `CROSS`, implicit joins
- Customer and order relationship queries
- Set operations: `INTERSECT`, `EXCEPT`
- Join-based problem-solving scenarios

#### `sabun_dhital_sql_hw4.sql`
- Subqueries: `IN`, `ALL`, `ANY`, correlated subqueries
- Common Table Expressions (CTEs)
- Query optimization and performance considerations
- Advanced filtering and aggregation logic

####  `sabun_dhital_sql_hw5.sql`
- Data manipulation operations:
  - `INSERT`, `UPDATE`, `DELETE`, `MERGE`
  - `SELECT INTO`, `DEFAULT`, `NULL`
- Use of subqueries in DML
- Temporary table creation and row filtering

####  `sabun_dhital_sql_hw6.sql`
- Data type conversion: `CAST`, `CONVERT`, `TRY_CONVERT`, `STR`
- Date formatting and string manipulation
- Unicode and ASCII functions
- Combining multiple conversions in a single query

#### `sabun_dhital_sql_hw7.sql`
- CTEs, Window Functions, `CASE`, `COALESCE`, `RANK`
- Parsing strings and formatting dates
- Advanced joins and conditional logic
- Monthly invoice analysis and categorization

####  `sabun_dhital_sql_hw8.sql`
- Creation and use of Views
- `SCHEMABINDING`, `WITH CHECK OPTION`, updatable/read-only views
- View lifecycle: `CREATE`, `ALTER`, `DROP`
- Metadata queries using `sys.views` and `sys.schemas`

#### `sabun_dhital_sql_hw9.sql`
- Variables: scalar, table, and temporary
- Conditional logic: `IF`, `WHILE`, `TRY...CATCH`
- Cursors and loops
- `SET NOCOUNT`, dynamic SQL with `sp_executesql`

## Database Used
WideWorldImporters - Microsoft's sample database for SQL Server

## Getting Started

Prerequisites:
SQL Server (any recent version)
WideWorldImporters sample database installed
SQL Server Management Studio (SSMS) or similar SQL client

## Database Setup:
sql USE WideWorldImporters;

## Running the Scripts:
Execute each homework file in sequence
Some assignments build upon previous work
Check comments for specific requirements and expected results

## Sample Query Results
Many queries include expected row counts in comments, for example:

Assignment 4, Problem 1: 624 rows returned
Assignment 4, Problem 2: 10 rows returned
Assignment 7, Query 2: Top 5 longest customer names


## Learning Objectives
These assignments progressively build SQL skills from basic query construction to advanced database programming concepts. Key learning outcomes include:

Mastery of SQL syntax and query structure
Understanding of relational database concepts
Proficiency in data manipulation and transformation
Knowledge of advanced SQL features and functions
Experience with database object creation and management
Skills in T-SQL programming and error handling


## Notes
All scripts use the WideWorldImporters database
Table aliases are used extensively for readability
Comments explain the purpose and expected results of each query
Error handling and best practices are demonstrated throughout
Code follows consistent formatting and naming conventions


**Author:** Sabun Dhital  
**Tool:** Microsoft SQL Server  
**Database Used:** WideWorldImporters

