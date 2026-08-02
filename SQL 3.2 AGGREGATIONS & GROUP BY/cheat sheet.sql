/****************************************************************************************
                    SQL GROUP BY & AGGREGATIONS CHEAT SHEET
-----------------------------------------------------------------------------------------
Topics Covered
--------------
1. Aggregate Functions
2. COUNT()
3. SUM()
4. AVG()
5. MIN()
6. MAX()
7. GROUP BY
8. GROUP BY Multiple Columns
9. SQL Execution Order
10. WHERE vs HAVING
11. GROUP BY + WHERE
12. GROUP BY + HAVING
13. GROUP BY + ORDER BY
14. Multiple Aggregate Functions
15. COUNT(*) vs COUNT(column) vs COUNT(DISTINCT)
16. NULL Handling in Aggregate Functions
17. Common Mistakes
18. Interview Notes
19. Quick Revision
****************************************************************************************/


/****************************************************************************************
                                CREATE TABLE
****************************************************************************************/

CREATE DATABASE IF NOT EXISTS Aggregations;
USE Aggregations;

CREATE TABLE employees(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    job VARCHAR(30),
    salary DECIMAL(10,2),
    commission DECIMAL(10,2)
);


/****************************************************************************************
                                INSERT SAMPLE DATA
****************************************************************************************/

INSERT INTO employees VALUES
(101,'Alice','HR','Manager',65000,5000),
(102,'Bob','HR','Executive',40000,NULL),
(103,'Charlie','IT','Developer',75000,8000),
(104,'David','IT','Developer',72000,NULL),
(105,'Eva','IT','Manager',90000,12000),
(106,'Frank','Sales','Executive',50000,7000),
(107,'Grace','Sales','Executive',48000,NULL),
(108,'Henry','Finance','Analyst',68000,NULL),
(109,'Ivy','Finance','Manager',95000,10000);



/****************************************************************************************
1. AGGREGATE FUNCTIONS

Aggregate Functions operate on multiple rows
and return ONE value.
****************************************************************************************/

-- COUNT()

SELECT COUNT(*)
FROM employees;


-- SUM()

SELECT SUM(salary)
FROM employees;


-- AVG()

SELECT AVG(salary)
FROM employees;


-- MIN()

SELECT MIN(salary)
FROM employees;


-- MAX()

SELECT MAX(salary)
FROM employees;



/****************************************************************************************
2. COUNT()

Counts rows.
****************************************************************************************/

-- Count all rows

SELECT COUNT(*)
FROM employees;


-- Count NON-NULL values

SELECT COUNT(commission)
FROM employees;


-- Count DISTINCT values

SELECT COUNT(DISTINCT department)
FROM employees;



/****************************************************************************************
3. SUM()

Returns total of numeric values.
****************************************************************************************/

SELECT
SUM(salary) AS total_salary
FROM employees;



/****************************************************************************************
4. AVG()

Returns average value.
****************************************************************************************/

SELECT
AVG(salary) AS average_salary
FROM employees;



/****************************************************************************************
5. MIN()

Returns minimum value.
****************************************************************************************/

SELECT
MIN(salary) AS minimum_salary
FROM employees;



/****************************************************************************************
6. MAX()

Returns maximum value.
****************************************************************************************/

SELECT
MAX(salary) AS maximum_salary
FROM employees;



/****************************************************************************************
7. GROUP BY

Groups rows having the same value.

Without GROUP BY
One output row.

With GROUP BY
One output row per group.
****************************************************************************************/


-- Average salary of all employees

SELECT
AVG(salary)
FROM employees;


-- Average salary department wise

SELECT
department,
AVG(salary)
FROM employees
GROUP BY department;



/****************************************************************************************
GROUP BY Syntax
****************************************************************************************/

SELECT
column_name,
aggregate_function(column_name)
FROM table_name
GROUP BY column_name;



/****************************************************************************************
Example
****************************************************************************************/

SELECT
department,
COUNT(*) AS total_employees
FROM employees
GROUP BY department;



/****************************************************************************************
8. GROUP BY MULTIPLE COLUMNS

Creates groups using more than one column.
****************************************************************************************/

SELECT
department,
job,
AVG(salary) AS average_salary
FROM employees
GROUP BY department, job;



/****************************************************************************************
Another Example
****************************************************************************************/

SELECT
department,
job,
COUNT(*) AS total_employees
FROM employees
GROUP BY department, job;



/****************************************************************************************
9. SQL EXECUTION ORDER

SQL does NOT execute from top to bottom.
****************************************************************************************/

-- Execution Order

FROM

↓

WHERE

↓

GROUP BY

↓

HAVING

↓

SELECT

↓

ORDER BY

↓

LIMIT



/****************************************************************************************
10. WHERE vs HAVING

WHERE
-------
Filters individual rows BEFORE grouping.

HAVING
--------
Filters grouped data AFTER grouping.
****************************************************************************************/


-- WHERE Example

SELECT *
FROM employees
WHERE salary > 60000;



-- HAVING Example

SELECT
department,
AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 65000;



/****************************************************************************************
Difference
****************************************************************************************/

-- WHERE

FROM employees

↓

Remove unwanted rows

↓

GROUP BY



-- HAVING

FROM employees

↓

GROUP BY

↓

Remove unwanted groups



/****************************************************************************************
WHERE cannot use Aggregate Functions
****************************************************************************************/

-- WRONG

SELECT
department,
AVG(salary)
FROM employees
WHERE AVG(salary) > 60000
GROUP BY department;



-- CORRECT

SELECT
department,
AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;



/****************************************************************************************
END OF PART 1
****************************************************************************************/

/****************************************************************************************
11. GROUP BY + WHERE

WHERE filters rows BEFORE grouping.
****************************************************************************************/

-- Count employees with salary greater than 50000 department-wise

SELECT
department,
COUNT(*) AS total_employees
FROM employees
WHERE salary > 50000
GROUP BY department;



/****************************************************************************************
Another Example
****************************************************************************************/

SELECT
department,
SUM(salary) AS total_salary
FROM employees
WHERE salary >= 60000
GROUP BY department;



/****************************************************************************************
Execution Order

FROM
↓

WHERE
↓

GROUP BY
****************************************************************************************/



/****************************************************************************************
12. GROUP BY + HAVING

HAVING filters groups AFTER GROUP BY.
****************************************************************************************/

-- Departments having more than 2 employees

SELECT
department,
COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;



-- Departments whose average salary exceeds 70000

SELECT
department,
AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 70000;



-- Departments whose total salary exceeds 150000

SELECT
department,
SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 150000;



/****************************************************************************************
Execution Order

FROM
↓

GROUP BY
↓

HAVING
****************************************************************************************/



/****************************************************************************************
13. GROUP BY + ORDER BY

ORDER BY sorts the final grouped result.
****************************************************************************************/

SELECT
department,
AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;



-- Order by Aggregate Function

SELECT
department,
COUNT(*) AS total_employees
FROM employees
GROUP BY department
ORDER BY COUNT(*) DESC;



-- Multiple Sorting

SELECT
department,
AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC,
department ASC;



/****************************************************************************************
14. MULTIPLE AGGREGATE FUNCTIONS

Multiple aggregate functions can be used together.
****************************************************************************************/

SELECT
department,
COUNT(*) AS total_employees,
SUM(salary) AS total_salary,
AVG(salary) AS average_salary,
MIN(salary) AS minimum_salary,
MAX(salary) AS maximum_salary
FROM employees
GROUP BY department;



/****************************************************************************************
15. COUNT(*) vs COUNT(column) vs COUNT(DISTINCT)

Important Interview Question
****************************************************************************************/

-- Counts every row

SELECT
COUNT(*)
FROM employees;



-- Counts only NON-NULL values

SELECT
COUNT(commission)
FROM employees;



-- Counts unique values

SELECT
COUNT(DISTINCT department)
FROM employees;



/****************************************************************************************
Difference

COUNT(*)                 → Every row

COUNT(column)            → NON-NULL values

COUNT(DISTINCT column)   → Unique values
****************************************************************************************/



/****************************************************************************************
16. NULL HANDLING

Aggregate Functions ignore NULL values.
****************************************************************************************/

-- Commission contains NULL values

SELECT
AVG(commission)
FROM employees;



-- SUM ignores NULL

SELECT
SUM(commission)
FROM employees;



-- COUNT ignores NULL

SELECT
COUNT(commission)
FROM employees;



-- COUNT(*) counts every row

SELECT
COUNT(*)
FROM employees;



/****************************************************************************************
17. COMMON MISTAKES
****************************************************************************************/


-- WRONG
-- Aggregate function inside WHERE

SELECT
department,
AVG(salary)
FROM employees
WHERE AVG(salary) > 70000
GROUP BY department;



-----------------------------------------------------------


-- CORRECT

SELECT
department,
AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 70000;



-----------------------------------------------------------


-- WRONG
-- Missing GROUP BY

SELECT
department,
AVG(salary)
FROM employees;



-----------------------------------------------------------


-- CORRECT

SELECT
department,
AVG(salary)
FROM employees
GROUP BY department;



-----------------------------------------------------------


-- WRONG
-- Non-aggregated column not included in GROUP BY

SELECT
department,
emp_name,
AVG(salary)
FROM employees
GROUP BY department;



-----------------------------------------------------------


-- CORRECT

SELECT
department,
AVG(salary)
FROM employees
GROUP BY department;



-----------------------------------------------------------


-- WRONG
-- HAVING before GROUP BY

SELECT
department,
COUNT(*)
FROM employees
HAVING COUNT(*) > 2
GROUP BY department;



-----------------------------------------------------------


-- CORRECT

SELECT
department,
COUNT(*)
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;



/****************************************************************************************
18. INTERVIEW NOTES
****************************************************************************************/

-- Aggregate Functions
-- Return ONE value.

-- COUNT(*)
-- Counts every row.

-- COUNT(column)
-- Counts NON-NULL values.

-- COUNT(DISTINCT column)
-- Counts unique values.

-- SUM()
-- Returns total.

-- AVG()
-- Returns average.

-- MIN()
-- Returns minimum value.

-- MAX()
-- Returns maximum value.

-- GROUP BY
-- Creates groups.

-- WHERE
-- Filters rows BEFORE grouping.

-- HAVING
-- Filters groups AFTER grouping.

-- ORDER BY
-- Sorts final output.

-- Aggregate Functions ignore NULL values.

-- Every non-aggregated column in SELECT
-- must appear in GROUP BY.

-- WHERE cannot use Aggregate Functions.

-- HAVING is mainly used with Aggregate Functions.



/****************************************************************************************
19. QUICK REVISION
****************************************************************************************/

-- ==========================
-- Aggregate Functions
-- ==========================

COUNT(*)                      -- Counts every row

COUNT(column)                 -- Counts NON-NULL values

COUNT(DISTINCT column)        -- Counts unique values

SUM(column)                   -- Adds values

AVG(column)                   -- Average value

MIN(column)                   -- Smallest value

MAX(column)                   -- Largest value



-- ==========================
-- GROUP BY
-- ==========================

GROUP BY                      -- Creates groups

GROUP BY col1, col2           -- Multiple grouping



-- ==========================
-- WHERE
-- ==========================

Filters rows BEFORE grouping.



-- ==========================
-- HAVING
-- ==========================

Filters groups AFTER grouping.



-- ==========================
-- ORDER BY
-- ==========================

Sorts final output.

ASC  -> Ascending (Default)

DESC -> Descending



-- ==========================
-- SQL Execution Order
-- ==========================

FROM

↓

WHERE

↓

GROUP BY

↓

HAVING

↓

SELECT

↓

ORDER BY

↓

LIMIT



-- ==========================
-- Rules
-- ==========================

✓ Aggregate Functions return ONE value.

✓ Aggregate Functions ignore NULL values.

✓ WHERE cannot contain Aggregate Functions.

✓ HAVING is used with Aggregate Functions.

✓ Every non-aggregated column in SELECT
  must appear in GROUP BY.

✓ GROUP BY creates one result per group.

✓ COUNT(*) counts every row.

✓ COUNT(column) ignores NULL values.

✓ COUNT(DISTINCT column) counts unique values.

✓ ORDER BY always executes after SELECT.

✓ WHERE executes before GROUP BY.

✓ HAVING executes after GROUP BY.



/****************************************************************************************
END OF GROUP BY & AGGREGATIONS CHEAT SHEET
****************************************************************************************/
