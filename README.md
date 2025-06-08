# README: SQL Homework Collection  
**Author:** Sabun Dhital  
**Course:** Business Analytics  
**Tool:** Microsoft SQL Server  
**Database Used:** WideWorldImporters

## Contents

This repository contains SQL scripts for a series of structured homework assignments demonstrating core and advanced SQL skills. Each script is well-commented and grouped by the respective homework number.

---

## 🧾 Files Overview

### `sabun_dhital_sql_hw1.sql`
- Basic SQL queries
- Column aliasing, expressions, functions
- Filtering with `WHERE`, `IN`, `BETWEEN`, `LIKE`, `IS NULL`
- `ORDER BY`, `TOP`, and conditional operators

###  `sabun_dhital_sql_hw2.sql`
- Joins: `INNER`, `LEFT`, `CROSS`, implicit joins
- Customer and order relationship queries
- Set operations: `INTERSECT`, `EXCEPT`
- Join-based problem-solving scenarios

###  `sabun_dhital_sql_hw4.sql`
- Subqueries: `IN`, `ALL`, `ANY`, correlated subqueries
- Common Table Expressions (CTEs)
- Query optimization and performance considerations
- Advanced filtering and aggregation logic

###  `sabun_dhital_sql_hw5.sql`
- Data manipulation operations:
  - `INSERT`, `UPDATE`, `DELETE`, `MERGE`
  - `SELECT INTO`, `DEFAULT`, `NULL`
- Use of subqueries in DML
- Temporary table creation and row filtering

### `sabun_dhital_sql_hw6.sql`
- Data type conversion: `CAST`, `CONVERT`, `TRY_CONVERT`, `STR`
- Date formatting and string manipulation
- Unicode and ASCII functions
- Combining multiple conversions in a single query

### `sabun_dhital_sql_hw7.sql`
- CTEs, Window Functions, `CASE`, `COALESCE`, `RANK`
- Parsing strings and formatting dates
- Advanced joins and conditional logic
- Monthly invoice analysis and categorization

### `sabun_dhital_sql_hw8.sql`
- Creation and use of Views
- `SCHEMABINDING`, `WITH CHECK OPTION`, updatable/read-only views
- View lifecycle: `CREATE`, `ALTER`, `DROP`
- Metadata queries using `sys.views` and `sys.schemas`

### `sabun_dhital_sql_hw9.sql`
- Variables: scalar, table, and temporary
- Conditional logic: `IF`, `WHILE`, `TRY...CATCH`
- Cursors and loops
- `SET NOCOUNT`, dynamic SQL with `sp_executesql`

---

## How to Run

1. Open SQL Server Management Studio (SSMS)
2. Connect to the **WideWorldImporters** database
3. Copy and execute each `.sql` script separately
4. Review results in the Results pane and Messages pane

---

## 📌 Notes
- Each script contains detailed inline comments for guidance.
- Recommended to run in order if building upon created tables or views.
- Ensure `WideWorldImporters` database is restored/available before execution.
