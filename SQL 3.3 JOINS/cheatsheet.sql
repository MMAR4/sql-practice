/****************************************************************************************
                        SQL 3.4 JOINS - CHEAT SHEET
****************************************************************************************/


/****************************************************************************************
1. JOIN TYPES
****************************************************************************************/

INNER JOIN      → Matching rows only

LEFT JOIN       → All rows from LEFT + Matching rows from RIGHT

RIGHT JOIN      → All rows from RIGHT + Matching rows from LEFT

FULL JOIN       → All rows from BOTH tables

CROSS JOIN      → Cartesian Product

SELF JOIN       → Join a table with itself

NON-EQUI JOIN   → Join using <, >, BETWEEN, etc.



/****************************************************************************************
2. BASIC SYNTAX
****************************************************************************************/

SELECT columns
FROM table1 t1
JOIN table2 t2
ON t1.column = t2.column;



/****************************************************************************************
3. INNER JOIN
****************************************************************************************/

SELECT *
FROM emp e
JOIN dept d
ON e.deptno = d.deptno;



Returns only matching rows.



/****************************************************************************************
4. LEFT JOIN
****************************************************************************************/

SELECT *
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;



Returns

✓ All Customers

✓ Matching Orders

✓ NULL if no order exists



/****************************************************************************************
5. RIGHT JOIN
****************************************************************************************/

SELECT *
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id;



Returns

✓ All Orders

✓ Matching Customers



/****************************************************************************************
6. SELF JOIN
****************************************************************************************/

SELECT
e.ename,
m.ename AS manager
FROM emp e
JOIN emp m
ON e.mgr = m.empno;



Employee ←→ Manager



/****************************************************************************************
7. NON-EQUI JOIN
****************************************************************************************/

SELECT
e.ename,
s.grade
FROM emp e
JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal;



Salary → Salary Grade



/****************************************************************************************
8. CROSS JOIN
****************************************************************************************/

SELECT *
FROM table1
CROSS JOIN table2;



Rows Returned

Rows(table1) × Rows(table2)



/****************************************************************************************
9. COMMON PATTERNS
****************************************************************************************/


-- Employee + Department

emp
JOIN dept
ON emp.deptno = dept.deptno



--------------------------------------------


-- Customer + Orders

Customers
JOIN Orders
ON Customers.customer_id = Orders.customer_id



--------------------------------------------


-- Orders + Food

Orders
JOIN FoodItems
ON Orders.food_id = FoodItems.food_id



--------------------------------------------


-- Employee + Manager

emp e
JOIN emp m
ON e.mgr = m.empno



--------------------------------------------


-- Employee + Salary Grade

emp
JOIN salgrade
ON emp.sal BETWEEN salgrade.losal
AND salgrade.hisal



/****************************************************************************************
10. JOIN + GROUP BY
****************************************************************************************/

SELECT
department,
COUNT(*)
FROM emp
JOIN dept
ON emp.deptno=dept.deptno
GROUP BY department;



/****************************************************************************************
11. JOIN + HAVING
****************************************************************************************/

SELECT
department,
SUM(sal)
FROM emp
JOIN dept
ON emp.deptno=dept.deptno
GROUP BY department
HAVING SUM(sal)>5000;

/****************************************************************************************
SELF JOIN (Most Important)
****************************************************************************************/

A SELF JOIN joins a table with itself.

Used when one row refers to another row
in the SAME table.

Common Examples

✓ Employee → Manager

✓ Student → Mentor

✓ Category → Parent Category

✓ Friend → Friend



Example Table

emp

empno    ename     mgr

7369     SMITH     7902

7902     FORD      7566

7566     JONES     7839

7839     KING      NULL



Think of TWO COPIES of emp

Employee Table (e)

Employee              Manager

7369  SMITH      ---> 7902 FORD

7902  FORD       ---> 7566 JONES

7566  JONES      ---> 7839 KING



So SQL becomes


SELECT
e.ename,
m.ename AS manager
FROM emp e
JOIN emp m
ON e.mgr = m.empno;



Logic

Current Employee

↓

Look at mgr

↓

Find employee whose empno = mgr

↓

That employee is the manager.



Remember

e = Employee

m = Manager

e.mgr = m.empno

Left side

Employee's manager id

=

Right side

Manager's employee id

/****************************************************************************************
12. EXECUTION ORDER
****************************************************************************************/

FROM

↓

JOIN

↓

ON

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
13. COMMON MISTAKES
****************************************************************************************/

❌ Missing ON condition

❌ Wrong join column

❌ Using WHERE instead of ON

❌ Forgetting table aliases

❌ GROUP BY missing columns

❌ COUNT(*) instead of COUNT(child_id) in LEFT JOIN

❌ Ambiguous column names



/****************************************************************************************
14. INTERVIEW RULES
****************************************************************************************/

✓ INNER → Matching rows

✓ LEFT → Keep Left Table

✓ RIGHT → Keep Right Table

✓ FULL → Keep Both Tables

✓ SELF → Same Table

✓ NON-EQUI → BETWEEN, >, <

✓ CROSS → Every Combination



/****************************************************************************************
15. QUICK REVISION
****************************************************************************************/

Employee + Department
→ INNER JOIN

Customer + Orders
→ LEFT JOIN

Employee + Manager
→ SELF JOIN

Employee + Salary Grade
→ NON-EQUI JOIN

Need All Left Rows
→ LEFT JOIN

Need Matching Rows
→ INNER JOIN

Need Every Combination
→ CROSS JOIN

Need Missing Records
→ LEFT JOIN ... IS NULL

Need Aggregation
→ JOIN + GROUP BY

Need Filter on Aggregate
→ JOIN + GROUP BY + HAVING

****************************************************************************************
