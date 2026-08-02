/****************************************************************************************
                    SQL 3.1 - SELECT, WHERE, ORDER BY
-----------------------------------------------------------------------------------------
Topics Covered
--------------
1. SELECT
2. DISTINCT
3. Aliases (AS)
4. WHERE
5. Comparison Operators
6. Logical Operators
7. IN
8. BETWEEN
9. LIKE
10. IS NULL / IS NOT NULL
11. ORDER BY
12. LIMIT
13. SQL Execution Order
14. Common Mistakes
15. Interview Notes

****************************************************************************************/


/****************************************************************************************
1. SELECT
****************************************************************************************/

-- Used to retrieve data from one or more columns.

SELECT *
FROM Customers;

SELECT customer_id,
       first_name,
       email
FROM Customers;


/****************************************************************************************
2. DISTINCT
****************************************************************************************/

-- Removes duplicate values.

SELECT DISTINCT city
FROM Customers;


/****************************************************************************************
3. ALIAS (AS)
****************************************************************************************/

-- Renames a column in the output.

SELECT first_name AS customer_name,
       salary AS employee_salary
FROM Employees;


/****************************************************************************************
4. WHERE
****************************************************************************************/

-- Filters rows before they are returned.

SELECT *
FROM Orders
WHERE total_amount > 500;


/****************************************************************************************
5. COMPARISON OPERATORS
****************************************************************************************/

-- =      Equal
-- <>     Not Equal (ANSI SQL)
-- !=     Not Equal (MySQL)
-- >      Greater Than
-- <      Less Than
-- >=     Greater Than or Equal
-- <=     Less Than or Equal

SELECT *
FROM Employees
WHERE salary >= 5000;


/****************************************************************************************
6. LOGICAL OPERATORS
****************************************************************************************/

-- AND
-- All conditions must be TRUE.

SELECT *
FROM Customers
WHERE city='Hyderabad'
AND signup_date>'2024-01-01';


-- OR
-- Any condition can be TRUE.

SELECT *
FROM Customers
WHERE city='Delhi'
OR city='Mumbai';


-- NOT

SELECT *
FROM Orders
WHERE status<>'Cancelled';


/****************************************************************************************
7. IN
****************************************************************************************/

-- Checks multiple values.

SELECT *
FROM Customers
WHERE city IN ('Delhi','Mumbai','Hyderabad');


/****************************************************************************************
8. BETWEEN
****************************************************************************************/

-- Inclusive Range.

SELECT *
FROM Employees
WHERE salary BETWEEN 3000 AND 6000;


/****************************************************************************************
9. LIKE
****************************************************************************************/

-- %  -> Any number of characters

SELECT *
FROM Customers
WHERE email LIKE '%@gmail.com';


-- Starts with A

SELECT *
FROM Customers
WHERE first_name LIKE 'A%';


-- Ends with n

SELECT *
FROM Customers
WHERE first_name LIKE '%n';


-- Contains "son"

SELECT *
FROM Employees
WHERE last_name LIKE '%son%';


-- _ -> Exactly one character

SELECT *
FROM Customers
WHERE first_name LIKE '_mit';


/****************************************************************************************
10. IS NULL / IS NOT NULL
****************************************************************************************/

SELECT *
FROM Employees
WHERE manager_id IS NULL;


SELECT *
FROM Employees
WHERE commission IS NOT NULL;


/****************************************************************************************
11. ORDER BY
****************************************************************************************/

-- Ascending (Default)

SELECT *
FROM Employees
ORDER BY salary;


-- Descending

SELECT *
FROM Employees
ORDER BY salary DESC;


-- Multiple Columns

SELECT *
FROM Employees
ORDER BY department,
         salary DESC;


/****************************************************************************************
12. LIMIT
****************************************************************************************/

-- Returns first N rows.

SELECT *
FROM Employees
LIMIT 5;


-- Skip first 10 rows and return next 5

SELECT *
FROM Employees
LIMIT 10,5;


/****************************************************************************************
13. SQL EXECUTION ORDER
****************************************************************************************/

-- SQL is WRITTEN as:

-- SELECT
-- FROM
-- WHERE
-- ORDER BY

------------------------------------------------------------

-- SQL EXECUTES as:

-- FROM
-- WHERE
-- SELECT
-- ORDER BY


/****************************************************************************************
14. COMMON MISTAKES
****************************************************************************************/

-- ❌ SELECT name salary
-- ✅ SELECT name, salary

------------------------------------------------------------

-- ❌ WHERE salary ==5000
-- ✅ WHERE salary =5000

------------------------------------------------------------

-- ❌ WHERE manager_id = NULL
-- ✅ WHERE manager_id IS NULL

------------------------------------------------------------

-- ❌ WHERE city = Hyderabad
-- ✅ WHERE city = 'Hyderabad'

------------------------------------------------------------

-- ❌ LIKE '@gmail.com'
-- ✅ LIKE '%@gmail.com'

------------------------------------------------------------

-- ❌ BETWEEN 5000 AND 1000
-- (Wrong order)

------------------------------------------------------------

-- ORDER BY is usually the LAST clause.


/****************************************************************************************
15. INTERVIEW NOTES (QUICK REVISION)
****************************************************************************************/

-- SELECT
-- Retrieves data.

------------------------------------------------------------

-- DISTINCT
-- Removes duplicate rows.

------------------------------------------------------------

-- WHERE
-- Filters rows.

------------------------------------------------------------

-- ORDER BY
-- Sorts final output.

------------------------------------------------------------

-- SQL Execution Order

-- FROM
-- WHERE
-- SELECT
-- ORDER BY

------------------------------------------------------------

-- Comparison Operators

-- =
-- <>
-- >
-- <
-- >=
-- <=

------------------------------------------------------------

-- Logical Operators

-- AND
-- OR
-- NOT

------------------------------------------------------------

-- IN
-- Multiple values.

------------------------------------------------------------

-- BETWEEN
-- Inclusive.

------------------------------------------------------------

-- LIKE

-- A%      Starts with A
-- %A      Ends with A
-- %A%     Contains A
-- _A      One character before A

------------------------------------------------------------

-- NULL

-- IS NULL
-- IS NOT NULL

------------------------------------------------------------

-- LIMIT

-- LIMIT 5
-- LIMIT 10,5

------------------------------------------------------------

-- ANSI SQL

-- Prefer <> instead of !=

------------------------------------------------------------

-- Remember

-- WHERE filters rows.
-- ORDER BY sorts rows.
-- LIMIT returns first N rows.
-- BETWEEN is inclusive.
-- NULL is checked using IS NULL.
-- SQL execution order != SQL writing order.

/****************************************************************************************
END OF CHEAT SHEET
****************************************************************************************/
