/****************************************************************************************
                       📖 Detailed Notes SQL SUBQUERIES (CHEAT SHEET)
-----------------------------------------------------------------------------------------
Topics Covered
--------------
1. What is a Subquery?
2. Types of Subqueries
3. Scalar Subquery
4. Multi-row Subquery
5. Multi-column Subquery
6. Uncorrelated Subquery
7. Correlated Subquery
8. SQL Execution Order (Subqueries)
9. Basic Examples
****************************************************************************************/


/****************************************************************************************
                                CREATE DATABASE
****************************************************************************************/

CREATE DATABASE IF NOT EXISTS Subqueries;

USE Subqueries;


/****************************************************************************************
                                CREATE TABLES
****************************************************************************************/

CREATE TABLE dept(
    deptno INT PRIMARY KEY,
    dname VARCHAR(30),
    location VARCHAR(30)
);

CREATE TABLE emp(
    empno INT PRIMARY KEY,
    ename VARCHAR(30),
    job VARCHAR(30),
    sal DECIMAL(10,2),
    deptno INT,
    FOREIGN KEY(deptno) REFERENCES dept(deptno)
);


/****************************************************************************************
                                INSERT SAMPLE DATA
****************************************************************************************/

INSERT INTO dept VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

INSERT INTO emp VALUES
(7369,'SMITH','CLERK',800,20),
(7499,'ALLEN','SALESMAN',1600,30),
(7521,'WARD','SALESMAN',1250,30),
(7566,'JONES','MANAGER',2975,20),
(7654,'MARTIN','SALESMAN',1250,30),
(7698,'BLAKE','MANAGER',2850,30),
(7782,'CLARK','MANAGER',2450,10),
(7788,'SCOTT','ANALYST',3000,20),
(7839,'KING','PRESIDENT',5000,10),
(7844,'TURNER','SALESMAN',1500,30),
(7876,'ADAMS','CLERK',1100,20),
(7900,'JAMES','CLERK',950,30),
(7902,'FORD','ANALYST',3000,20),
(7934,'MILLER','CLERK',1300,10);



/****************************************************************************************
1. WHAT IS A SUBQUERY?

A subquery is a query written inside another SQL query.

It is also called:

• Inner Query
• Nested Query
• Inner SELECT

The outer query uses the result produced by the inner query.
****************************************************************************************/


-- General Syntax

SELECT columns
FROM table
WHERE column operator
(
    SELECT ...
);



/****************************************************************************************
Execution

Outer Query

↓

Inner Query Executes

↓

Returns Result

↓

Outer Query Uses Result

****************************************************************************************/



/****************************************************************************************
2. TYPES OF SUBQUERIES
****************************************************************************************/

1. Scalar Subquery

Returns exactly ONE value.

Example

SELECT AVG(sal)
FROM emp;



------------------------------------------------------------

2. Multi-row Subquery

Returns multiple rows.

Example

SELECT deptno
FROM dept;



------------------------------------------------------------

3. Multi-column Subquery

Returns multiple columns.

Example

SELECT deptno,dname
FROM dept;



------------------------------------------------------------

4. Uncorrelated Subquery

Runs only ONCE.

Does NOT depend on outer query.



------------------------------------------------------------

5. Correlated Subquery

Runs once for EVERY OUTER ROW.

Depends on outer query.



/****************************************************************************************
3. SCALAR SUBQUERY

Returns exactly ONE value.

Used with:

=

>

<

>=

<=

<>

****************************************************************************************/


-- Employees earning above average salary

SELECT
empno,
ename,
sal
FROM emp
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp
);



/****************************************************************************************
Execution

SELECT AVG(sal)

↓

2073.21

↓

Outer query compares every employee
with 2073.21

****************************************************************************************/



/****************************************************************************************
Another Example
****************************************************************************************/


-- Employee(s) earning maximum salary

SELECT
empno,
ename,
sal
FROM emp
WHERE sal =
(
    SELECT MAX(sal)
    FROM emp
);



/****************************************************************************************
4. MULTI-ROW SUBQUERY

Returns MORE THAN ONE ROW.

Used with:

IN

NOT IN

ANY

ALL

EXISTS

NOT EXISTS

****************************************************************************************/


-- Employees working in departments
-- located in DALLAS or NEW YORK

SELECT
empno,
ename,
deptno
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
    WHERE location IN ('DALLAS','NEW YORK')
);



/****************************************************************************************
Execution

Inner Query

10

20

↓

Outer Query

WHERE deptno IN (10,20)

****************************************************************************************/



/****************************************************************************************
Wrong Example

Returns Multiple Rows

Cannot use '='

****************************************************************************************/


-- WRONG

SELECT *
FROM emp
WHERE deptno =
(
    SELECT deptno
    FROM dept
);



-- ERROR

Subquery returns more than 1 row



/****************************************************************************************
Correct

Use IN

****************************************************************************************/


SELECT *
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
);



/****************************************************************************************
5. UNCORRELATED SUBQUERY

Runs ONLY ONCE.

Does not reference the outer query.

****************************************************************************************/


SELECT
empno,
ename,
sal
FROM emp
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp
);



Notice

The inner query has NO reference to
the outer query.

So it executes once.



/****************************************************************************************
Execution

AVG(sal)

↓

2073.21

↓

Outer query uses same value
for every row.

****************************************************************************************/



/****************************************************************************************
6. CORRELATED SUBQUERY

Runs once for EVERY outer row.

References outer query columns.

****************************************************************************************/


SELECT
empno,
ename,
deptno,
sal
FROM emp e
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp e2
    WHERE e2.deptno = e.deptno
);



Notice

e2.deptno = e.deptno

The inner query uses

e.deptno

from the outer query.



/****************************************************************************************
Execution

Current Employee

↓

Current Department

↓

Average Salary
of that Department

↓

Compare Salary

↓

Next Employee

****************************************************************************************/



/****************************************************************************************
Difference

Uncorrelated

Runs Once

↓

Same result used everywhere



Correlated

Runs for every outer row

↓

Result changes for each row

****************************************************************************************/



/****************************************************************************************
7. SQL EXECUTION ORDER (Subqueries)

Uncorrelated Subquery

Inner Query

↓

Outer Query



Correlated Subquery

Outer Row

↓

Inner Query

↓

Comparison

↓

Next Outer Row

****************************************************************************************/


/****************************************************************************************
END OF PART 1
****************************************************************************************/

/****************************************************************************************
8. IN

IN is used when the subquery returns MULTIPLE ROWS.

Checks whether a value exists in the returned list.

****************************************************************************************/


-- Employees working in departments
-- located in DALLAS

SELECT
empno,
ename,
deptno
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
    WHERE location='DALLAS'
);



/****************************************************************************************
Execution

Inner Query

↓

20

↓

Outer Query

WHERE deptno IN (20)

****************************************************************************************/



/****************************************************************************************
Another Example

Departments located in
NEW YORK or DALLAS

****************************************************************************************/

SELECT
empno,
ename,
deptno
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
    WHERE location IN ('NEW YORK','DALLAS')
);



/****************************************************************************************
Execution

Inner Query

↓

10

20

↓

Outer Query

WHERE deptno IN (10,20)

****************************************************************************************/



/****************************************************************************************
IN Syntax
****************************************************************************************/

SELECT columns
FROM table
WHERE column IN
(
    SELECT column
    FROM table
);



/****************************************************************************************
9. NOT IN

Returns rows whose value does NOT exist
inside the subquery result.

****************************************************************************************/


-- Departments having no employees

SELECT
deptno,
dname
FROM dept
WHERE deptno NOT IN
(
    SELECT DISTINCT deptno
    FROM emp
);



/****************************************************************************************
Execution

Employee Departments

↓

10

20

30

↓

Department NOT IN (10,20,30)

↓

Returns

40

****************************************************************************************/



/****************************************************************************************
IMPORTANT

If the subquery returns NULL,

NOT IN may return NO ROWS.

****************************************************************************************/


-- Dangerous Example

SELECT *
FROM dept
WHERE deptno NOT IN
(
    SELECT deptno
    FROM emp
);



If deptno contains NULL,

Result may become EMPTY.



/****************************************************************************************
Safer Version

****************************************************************************************/

SELECT *
FROM dept
WHERE deptno NOT IN
(
    SELECT deptno
    FROM emp
    WHERE deptno IS NOT NULL
);



/****************************************************************************************
10. EXISTS

Checks whether the subquery returns
AT LEAST ONE ROW.

Returns TRUE or FALSE.

Mostly used with correlated subqueries.

****************************************************************************************/


-- Departments having employees

SELECT
deptno,
dname
FROM dept d
WHERE EXISTS
(
    SELECT 1
    FROM emp e
    WHERE e.deptno=d.deptno
);



/****************************************************************************************
Execution

Department 10

↓

Employee Exists?

↓

TRUE

↓

Return Department



Department 40

↓

Employee Exists?

↓

FALSE

↓

Skip Department

****************************************************************************************/



/****************************************************************************************
Why SELECT 1 ?

****************************************************************************************/

SELECT 1

SELECT *

SELECT 'A'

All are equivalent.

EXISTS only checks whether
a row exists.

It ignores selected columns.



/****************************************************************************************
EXISTS Syntax

****************************************************************************************/

SELECT columns
FROM parent p
WHERE EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.column=p.column
);



/****************************************************************************************
11. NOT EXISTS

Returns rows for which
the subquery returns NO ROWS.

****************************************************************************************/


-- Departments having NO employees

SELECT
deptno,
dname
FROM dept d
WHERE NOT EXISTS
(
    SELECT 1
    FROM emp e
    WHERE e.deptno=d.deptno
);



/****************************************************************************************
Execution

Department 40

↓

Employee Exists?

↓

NO

↓

Return Department

****************************************************************************************/



/****************************************************************************************
NOT EXISTS Syntax

****************************************************************************************/

SELECT columns
FROM parent p
WHERE NOT EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.column=p.column
);



/****************************************************************************************
12. EXISTS vs IN

IN

• Compares VALUES.

• Usually used with
  uncorrelated subqueries.

• Best when matching a list
  of values.

Example

WHERE deptno IN
(
    SELECT deptno
    FROM dept
);



------------------------------------------------------------

EXISTS

• Checks whether a ROW exists.

• Usually used with
  correlated subqueries.

• Stops searching after finding
  the first matching row.

Example

WHERE EXISTS
(
    SELECT 1
    FROM emp e
    WHERE e.deptno=d.deptno
);



/****************************************************************************************
IN vs EXISTS

IN

Compare Values

↓

deptno IN (10,20,30)



EXISTS

Compare Rows

↓

Does a matching row exist?

TRUE / FALSE

****************************************************************************************/



/****************************************************************************************
13. ANY

Compares a value with ANY value
returned by the subquery.

Meaning

> ANY

Greater than at least one value.



< ANY

Less than at least one value.



= ANY

Equivalent to IN

****************************************************************************************/


-- Employees earning more than
-- at least one manager

SELECT
empno,
ename,
sal
FROM emp
WHERE sal > ANY
(
    SELECT sal
    FROM emp
    WHERE job='MANAGER'
);



/****************************************************************************************
14. ALL

Compares a value with ALL values
returned by the subquery.

Meaning

> ALL

Greater than every value.



< ALL

Less than every value.

****************************************************************************************/


-- Employees earning more than
-- every manager

SELECT
empno,
ename,
sal
FROM emp
WHERE sal > ALL
(
    SELECT sal
    FROM emp
    WHERE job='MANAGER'
);



/****************************************************************************************
Difference

Managers

2450

2850

2975



> ANY

Greater than ONE manager

Example

2500 ✔



> ALL

Greater than EVERY manager

Example

3000 ✔

2500 ✖

****************************************************************************************/



/****************************************************************************************
END OF PART 2
****************************************************************************************/


/****************************************************************************************
15. SUBQUERY IN HAVING

Used to compare grouped results with another
aggregate value.

Very common in coding interviews.

****************************************************************************************/


-- Departments whose total salary
-- is greater than the average
-- departmental salary.

SELECT
deptno,
SUM(sal) AS total_salary
FROM emp
GROUP BY deptno
HAVING SUM(sal) >
(
    SELECT AVG(total_salary)
    FROM
    (
        SELECT
        SUM(sal) AS total_salary
        FROM emp
        GROUP BY deptno
    ) t
);



/****************************************************************************************
Execution

GROUP BY deptno

↓

Department Totals

↓

Average of Department Totals

↓

HAVING compares each department

****************************************************************************************/



/****************************************************************************************
Why Derived Table?

This query is WRONG

****************************************************************************************/


SELECT AVG(SUM(sal))
FROM emp
GROUP BY deptno;



-- ERROR

Aggregate function cannot directly
contain another aggregate.



/****************************************************************************************
Correct

****************************************************************************************/

SELECT AVG(total_salary)
FROM
(
    SELECT
    SUM(sal) AS total_salary
    FROM emp
    GROUP BY deptno
) t;



/****************************************************************************************
HAVING Syntax

****************************************************************************************/

SELECT
group_column,
AGGREGATE(column)
FROM table
GROUP BY group_column
HAVING AGGREGATE(column)
operator
(
    SELECT ...
);



/****************************************************************************************
16. SUBQUERY IN FROM

Also called

Derived Table

Inline View

Temporary Table

****************************************************************************************/


SELECT *
FROM
(
    SELECT
    deptno,
    AVG(sal) AS avg_salary
    FROM emp
    GROUP BY deptno
) t;



/****************************************************************************************
The subquery behaves like a table.

Always provide an alias.

Example

) t

****************************************************************************************/



/****************************************************************************************
Another Example

Employees earning above
their department average

****************************************************************************************/

SELECT
e.empno,
e.ename,
e.sal,
a.avg_salary
FROM emp e
JOIN
(
    SELECT
    deptno,
    AVG(sal) AS avg_salary
    FROM emp
    GROUP BY deptno
) a
ON e.deptno=a.deptno
WHERE e.sal>a.avg_salary;



/****************************************************************************************
Execution

Derived Table

↓

deptno   avg_salary

10       2916.67

20       2175.00

30       1562.50

↓

JOIN

↓

Comparison

****************************************************************************************/



/****************************************************************************************
17. CORRELATED vs UNCORRELATED

****************************************************************************************/


-- Uncorrelated

SELECT *
FROM emp
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp
);



Runs

ONE TIME



------------------------------------------------------------


-- Correlated

SELECT *
FROM emp e
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp e2
    WHERE e2.deptno=e.deptno
);



Runs

FOR EVERY OUTER ROW



/****************************************************************************************
Comparison

****************************************************************************************/


Uncorrelated

Runs Once

↓

Same result used
for every row



Correlated

Runs once

↓

Current row changes

↓

Subquery result changes

↓

Comparison changes



/****************************************************************************************
18. SQL EXECUTION ORDER

Uncorrelated Subquery

****************************************************************************************/


SELECT *
FROM emp
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp
);



Execution

Inner Query

↓

AVG(sal)

↓

Outer Query

↓

Result



/****************************************************************************************
Correlated Subquery

****************************************************************************************/


SELECT *
FROM emp e
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp e2
    WHERE e2.deptno=e.deptno
);



Execution

Outer Row

↓

Current deptno

↓

Inner Query

↓

Average Salary

↓

Comparison

↓

Next Row



/****************************************************************************************
19. SUBQUERY PATTERNS

Pattern 1

Compare with Overall Average

****************************************************************************************/


SELECT *
FROM table
WHERE column >
(
    SELECT AVG(column)
    FROM table
);



/****************************************************************************************
Pattern 2

Compare with Group Average

****************************************************************************************/


SELECT *
FROM table t1
WHERE column >
(
    SELECT AVG(column)
    FROM table t2
    WHERE t2.group_col=t1.group_col
);



/****************************************************************************************
Pattern 3

Check if Related Rows Exist

****************************************************************************************/


SELECT *
FROM parent p
WHERE EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.id=p.id
);



/****************************************************************************************
Pattern 4

Check if Related Rows Do NOT Exist

****************************************************************************************/


SELECT *
FROM parent p
WHERE NOT EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.id=p.id
);



/****************************************************************************************
Pattern 5

Compare Group Totals

****************************************************************************************/


SELECT
group_col,
SUM(column)
FROM table
GROUP BY group_col
HAVING SUM(column)>
(
    SELECT AVG(total)
    FROM
    (
        SELECT
        SUM(column) AS total
        FROM table
        GROUP BY group_col
    ) t
);



/****************************************************************************************
END OF PART 3
****************************************************************************************/


/****************************************************************************************
20. COMMON MISTAKES
****************************************************************************************/


------------------------------------------------------------
-- WRONG
-- Using '=' with a multi-row subquery
------------------------------------------------------------

SELECT *
FROM emp
WHERE deptno =
(
    SELECT deptno
    FROM dept
);



-- ERROR

Subquery returns more than 1 row



------------------------------------------------------------
-- CORRECT
------------------------------------------------------------

SELECT *
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
);




------------------------------------------------------------
-- WRONG
-- NOT IN with NULL values
------------------------------------------------------------

SELECT *
FROM dept
WHERE deptno NOT IN
(
    SELECT deptno
    FROM emp
);



-- If the subquery returns even one NULL,
-- the result may become EMPTY.




------------------------------------------------------------
-- CORRECT
------------------------------------------------------------

SELECT *
FROM dept
WHERE deptno NOT IN
(
    SELECT deptno
    FROM emp
    WHERE deptno IS NOT NULL
);




------------------------------------------------------------
-- WRONG
-- Forgetting correlation
------------------------------------------------------------

SELECT *
FROM emp e
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp
);



-- This compares with the overall average,
-- not the department average.




------------------------------------------------------------
-- CORRECT
------------------------------------------------------------

SELECT *
FROM emp e
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp e2
    WHERE e2.deptno = e.deptno
);




------------------------------------------------------------
-- WRONG
-- Missing alias for derived table
------------------------------------------------------------

SELECT *
FROM
(
    SELECT deptno,
           AVG(sal)
    FROM emp
    GROUP BY deptno
);



-- ERROR

Every derived table must have its own alias.




------------------------------------------------------------
-- CORRECT
------------------------------------------------------------

SELECT *
FROM
(
    SELECT deptno,
           AVG(sal)
    FROM emp
    GROUP BY deptno
) t;




------------------------------------------------------------
-- WRONG
-- Aggregate inside aggregate
------------------------------------------------------------

SELECT AVG(SUM(sal))
FROM emp
GROUP BY deptno;



------------------------------------------------------------
-- CORRECT
------------------------------------------------------------

SELECT AVG(total_salary)
FROM
(
    SELECT SUM(sal) AS total_salary
    FROM emp
    GROUP BY deptno
) t;




------------------------------------------------------------
-- WRONG
-- EXISTS without correlation
------------------------------------------------------------

SELECT *
FROM dept
WHERE EXISTS
(
    SELECT 1
    FROM emp
);



-- If emp has one row,
-- every department is returned.




------------------------------------------------------------
-- CORRECT
------------------------------------------------------------

SELECT *
FROM dept d
WHERE EXISTS
(
    SELECT 1
    FROM emp e
    WHERE e.deptno = d.deptno
);




/****************************************************************************************
21. INTERVIEW NOTES
****************************************************************************************/

-- A subquery is a query inside another query.

-- Inner query is executed first
-- except correlated subqueries.

-- Scalar subquery returns ONE value.

-- Multi-row subquery returns MANY rows.

-- Multi-column subquery returns MANY columns.

-- Uncorrelated subquery
-- executes only ONCE.

-- Correlated subquery
-- executes once for every outer row.

-- IN is used for multiple returned values.

-- NOT IN should avoid NULL values.

-- EXISTS checks whether
-- at least one matching row exists.

-- NOT EXISTS checks whether
-- no matching row exists.

-- EXISTS usually performs better
-- than IN for large correlated searches.

-- SELECT 1 and SELECT *
-- behave the same inside EXISTS.

-- Every derived table
-- must have an alias.

-- HAVING can contain subqueries.

-- FROM can contain subqueries
-- (Derived Tables).

-- Correlated subqueries usually
-- reference outer table aliases.

-- Use GROUP BY + HAVING when comparing
-- grouped results.

-- Window Functions can solve many
-- correlated subquery problems
-- more efficiently (Advanced SQL).



/****************************************************************************************
22. QUICK REVISION
****************************************************************************************/


-- ==========================
-- Types of Subqueries
-- ==========================

Scalar Subquery

Returns ONE value.


Multi-row Subquery

Returns multiple rows.


Multi-column Subquery

Returns multiple columns.


Uncorrelated Subquery

Runs once.


Correlated Subquery

Runs once for every outer row.



-- ==========================
-- Operators
-- ==========================

=             One value

>             One value

<             One value

>=            One value

<=            One value

<>            One value

IN            Multiple values

NOT IN        Multiple values

EXISTS        Checks row existence

NOT EXISTS    Checks row absence

ANY           Compare with any value

ALL           Compare with every value



-- ==========================
-- WHERE
-- ==========================

Compare rows using a subquery.



-- ==========================
-- HAVING
-- ==========================

Compare grouped results using a subquery.



-- ==========================
-- FROM
-- ==========================

Derived Table

Temporary Result Set

Must have an alias.



-- ==========================
-- Correlated vs Uncorrelated
-- ==========================

Uncorrelated

Runs Once

↓

Same result reused



Correlated

Runs for every row

↓

Result changes for each row



-- ==========================
-- Most Common Patterns
-- ==========================

✓ Compare with overall average

WHERE column >
(
    SELECT AVG(column)
    FROM table
);


✓ Compare with group average

WHERE column >
(
    SELECT AVG(column)
    FROM table t2
    WHERE t2.group_col=t1.group_col
);


✓ Check matching rows

WHERE EXISTS
(
    SELECT 1
    FROM child
    WHERE child.id=parent.id
);


✓ Check missing rows

WHERE NOT EXISTS
(
    SELECT 1
    FROM child
    WHERE child.id=parent.id
);


✓ Compare grouped totals

GROUP BY group_col

HAVING SUM(column)>
(
    SELECT AVG(total)
    FROM
    (
        SELECT SUM(column) AS total
        FROM table
        GROUP BY group_col
    ) t
);



-- ==========================
-- Rules
-- ==========================

✓ Scalar subquery returns one value.

✓ Multi-row subquery returns many rows.

✓ Use IN for multiple values.

✓ Avoid NOT IN when NULL values may exist.

✓ EXISTS returns TRUE if at least one row exists.

✓ NOT EXISTS returns TRUE if no rows exist.

✓ Correlated subqueries reference outer query columns.

✓ Derived tables must have aliases.

✓ HAVING can contain subqueries.

✓ FROM can contain subqueries.

✓ GROUP BY is often used with subqueries for comparisons.

✓ EXISTS stops searching after finding the first matching row.

✓ Correlated subqueries run once per outer row.

✓ Uncorrelated subqueries run only once.



/****************************************************************************************
END OF SQL SUBQUERIES CHEAT SHEET
****************************************************************************************/
