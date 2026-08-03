/****************************************************************************************
                    SQL 3.6 SUBQUERIES - CHEAT SHEET
****************************************************************************************/


/****************************************************************************************
1. WHAT IS A SUBQUERY?
****************************************************************************************/

-- A query inside another query.

SELECT ...
FROM table
WHERE column OPERATOR
(
    SELECT ...
);



/****************************************************************************************
2. TYPES OF SUBQUERIES
****************************************************************************************/

Scalar          → Returns ONE value

Multi-row       → Returns MULTIPLE rows

Multi-column    → Returns MULTIPLE columns

Uncorrelated    → Runs ONCE

Correlated      → Runs for EVERY outer row



/****************************************************************************************
3. OPERATORS
****************************************************************************************/

=      Scalar

>      Scalar

<      Scalar

>=     Scalar

<=     Scalar

<>     Scalar

IN     Multi-row

NOT IN Multi-row

EXISTS Checks rows

NOT EXISTS Checks missing rows

ANY    Compare with any value

ALL    Compare with every value



/***************************************************************************************
4. SUBQUERY PATTERNS
****************************************************************************************/


-- Pattern 1
-- Compare with Overall Average

SELECT *
FROM emp
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp
);



------------------------------------------------------------


-- Pattern 2
-- Compare with Group Average

SELECT *
FROM emp e
WHERE sal >
(
    SELECT AVG(sal)
    FROM emp e2
    WHERE e2.deptno=e.deptno
);



------------------------------------------------------------


-- Pattern 3
-- Compare with Maximum

SELECT *
FROM emp
WHERE sal=
(
    SELECT MAX(sal)
    FROM emp
);



------------------------------------------------------------


-- Pattern 4
-- Highest in each Group

SELECT *
FROM emp e
WHERE sal=
(
    SELECT MAX(sal)
    FROM emp e2
    WHERE e2.deptno=e.deptno
);



------------------------------------------------------------


-- Pattern 5
-- Lowest in each Group

SELECT *
FROM emp e
WHERE sal=
(
    SELECT MIN(sal)
    FROM emp e2
    WHERE e2.deptno=e.deptno
);



------------------------------------------------------------


-- Pattern 6
-- Exists

SELECT *
FROM parent p
WHERE EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.id=p.id
);



------------------------------------------------------------


-- Pattern 7
-- Not Exists

SELECT *
FROM parent p
WHERE NOT EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.id=p.id
);



------------------------------------------------------------


-- Pattern 8
-- IN

SELECT *
FROM emp
WHERE deptno IN
(
    SELECT deptno
    FROM dept
);



------------------------------------------------------------


-- Pattern 9
-- NOT IN

SELECT *
FROM dept
WHERE deptno NOT IN
(
    SELECT deptno
    FROM emp
    WHERE deptno IS NOT NULL
);



------------------------------------------------------------


-- Pattern 10
-- HAVING + Subquery

SELECT
deptno,
SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal)>
(
    SELECT AVG(total)
    FROM
    (
        SELECT SUM(sal) AS total
        FROM emp
        GROUP BY deptno
    ) t
);



/****************************************************************************************
5. EXECUTION
****************************************************************************************/

Uncorrelated

Inner Query

↓

Outer Query



Correlated

Outer Row

↓

Inner Query

↓

Comparison

↓

Next Row



/****************************************************************************************
6. WHEN TO USE WHAT?
****************************************************************************************/

Overall Average

↓

Uncorrelated


Department Average

↓

Correlated


List Matching Values

↓

IN


List Missing Values

↓

NOT IN


Check Matching Rows

↓

EXISTS


Check Missing Rows

↓

NOT EXISTS


Compare Group Totals

↓

GROUP BY + HAVING + Subquery



/****************************************************************************************
7. COMMON MISTAKES
****************************************************************************************/

❌ '=' with multiple rows

❌ NOT IN without removing NULL

❌ Missing alias for derived table

❌ Forgetting GROUP BY

❌ AVG(SUM())

❌ EXISTS without correlation

❌ Correlated query without outer reference



/****************************************************************************************
8. INTERVIEW RULES
****************************************************************************************/

✓ Scalar → ONE value

✓ IN → Multiple values

✓ EXISTS → Checks rows

✓ NOT EXISTS → Checks missing rows

✓ Correlated → References outer query

✓ Uncorrelated → Independent query

✓ Derived Table → Must have alias

✓ HAVING can contain subqueries

✓ EXISTS usually uses SELECT 1

✓ EXISTS stops after first match

✓ NOT IN + NULL = Dangerous



/****************************************************************************************
9. SQL EXECUTION ORDER
****************************************************************************************/

Uncorrelated

Inner Query

↓

Outer Query



Correlated

Outer Row

↓

Inner Query

↓

Outer Row

↓

Inner Query

↓

Result



/****************************************************************************************
10. QUICK REVISION
****************************************************************************************/

Scalar          → One Value

Multi-row       → Multiple Values

Correlated      → Per Outer Row

Uncorrelated    → Runs Once

IN              → Value Exists

NOT IN          → Value Missing

EXISTS          → Row Exists

NOT EXISTS      → Row Missing

HAVING          → Compare Groups

Derived Table   → Subquery in FROM

****************************************************************************************
