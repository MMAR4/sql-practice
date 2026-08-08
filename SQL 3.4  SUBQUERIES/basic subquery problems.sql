
-- 🟢 Level 1 — Uncorrelated Subqueries (Runs Once)
-- Problem 1 ⭐
-- Find all employees whose salary is greater than the average salary.
-- Output
-- empno
-- ename
-- sal

SELECT employee_id,employee_name,salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


-- Problem 2 ⭐
-- Find all employees earning the highest salary.
-- (Hint: use MAX())
SELECT  employee_id,employee_name,salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);


-- Problem 3 ⭐
-- Find employees whose salary is less than the company's average salary.
SELECT  employee_id,employee_name,salary
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);


-- Problem 4 ⭐⭐
-- Find all orders whose total_amount is greater than the average order amount.
-- Output
-- order_id
-- customer_id
-- total_amount

SELECT order_id,customer_id,total_amount
FROM orders
WHERE 
    total_amount >(SELECT AVG(total_amount) FROM orders);
  

-- Problem 5 ⭐⭐
-- Find all food items whose price is greater than the average food price.
SELECT name,price 
FROM fooditems
WHERE price > (SELECT AVG(price) FROM fooditems);


-- 🟢 Level 2 — IN
-- Problem 6 ⭐⭐
-- Find all orders placed by customers from Hyderabad.
-- Use IN.
-- Output:
-- order_id
-- customer_id
-- total_amount

SELECT order_id,customer_id,total_amount
FROM orders 
WHERE customer_id IN (
    SELECT customer_id 
    from customers 
    WHERE address LIKE "Hyderabad%");


-- Problem 7 ⭐⭐
-- Find all employees working in departments located in Dallas.

-- Use IN.
-- Output:
-- empno
-- ename
-- deptno
SELECT empno,ename,deptno
FROM emp 
WHERE deptno IN (
      SELECT deptno 
      FROM dept 
      WHERE location = "Dallas");


-- Problem 8 ⭐⭐⭐
-- Find all food items whose category appears more than 2 times.
-- Use IN.
SELECT name 
FROM fooditems 
WHERE category IN 
    (SELECT category
     FROM fooditems 
     GROUP BY category 
    HAVING COUNT(category)>2);

-- 🟡 Level 3 — EXISTS
-- Problem 9 ⭐⭐
-- Find departments that have at least one employee.
-- Use EXISTS.

-- Output:

-- deptno
-- dname
-- location
SELECT deptno,dname,location
FROM dept t1
WHERE EXISTS(SELECT 1 FROM emp t2 WHERE t1.deptno = t2.deptno );

-- Problem 10 ⭐⭐
-- Find customers who have placed at least one order.
-- Use EXISTS.

-- Output:

-- customer_id
-- name
-- city
SELECT customer_id,CONCAT(first_name," ",last_name),address 
FROM customers c
WHERE EXISTS(SELECT 1 FROM orders o WHERE c.customer_id=o.customer_id);




-- Problem 11 ⭐⭐⭐
-- Find departments having at least one employee with salary greater than 3000.
-- Use EXISTS.
SELECT deptno,dname,location
FROM dept d 
WHERE EXISTS(SELECT 1 FROM emp e WHERE d.deptno= e.deptno AND sal > 3000);

-- using join
-- SELECT d.deptno,dname,location
-- FROM dept d 
-- JOIN emp e 
--   ON d.deptno =e.deptno
-- WHERE e.sal >3000;


-- Problem 12 ⭐⭐⭐
-- Find customers who have at least one cancelled order.
-- Use EXISTS.

SELECT c.customer_id,first_name
FROM customers c 
WHERE EXISTS(SELECT 1 FROM orders o WHERE c.customer_id = o.customer_id AND o.status="Cancelled");

-- using join
-- SELECT DISTINCT c.customer_id,first_name
-- FROM customers c 
-- JOIN orders o 
--   ON c.customer_id = o.customer_id
-- WHERE o.status = "Cancelled";

-- 🟡 Level 4 — NOT EXISTS
-- Problem 13 ⭐⭐⭐
-- Find departments that have no employees.
SELECT deptno,dname,location
FROM dept d
WHERE NOT EXISTS(SELECT 1 FROM emp e WHERE d.deptno = e.deptno );

-- Problem 14 ⭐⭐⭐
-- Find customers who have never placed an order.
SELECT customer_id,first_name
FROM customers c
WHERE NOT EXISTS(SELECT 1 FROM orders o WHERE c.customer_id =o.customer_id );


-- Problem 15 ⭐⭐⭐
-- Find food items that have never been ordered.
SELECT  name
FROM fooditems f 
WHERE NOT EXISTS(SELECT 1 FROM orders o WHERE f.food_id =o.food_id );


-- 🟠 Level 5 — Correlated Subqueries
-- Problem 16 ⭐⭐⭐⭐
-- Find employees whose salary is greater than the average salary of their own department.
SELECT ename,sal
FROM emp e 
WHERE e.sal > (
    SELECT AVG(e2.sal) 
    FROM emp e2 
    WHERE e2.deptno = e.deptno ) ;


-- Problem 17 ⭐⭐⭐⭐
-- Find products whose price is greater than the average price of their own category.

-- i dont have products table so i did it with fooditems
SELECT name,price
FROM fooditems f 
WHERE f.price > (SELECT AVG(f2.price) FROM fooditems f2 WHERE f2.category = f.category);

-- Problem 18 ⭐⭐⭐⭐
-- Find orders whose total amount is greater than the average order amount of the same status.
SELECT order_id,total_amount
FROM orders o 
WHERE total_amount > (SELECT AVG(o2.total_amount) FROM orders o2 WHERE o2.status = o.status);

-- Problem 19 ⭐⭐⭐⭐
-- Find employees whose salary is the highest in their department.
SELECT ename,sal
FROM emp e 
WHERE sal = (SELECT MAX(e2.sal) FROM emp e2 WHERE e2.deptno = e.deptno);

-- 🔴 Level 6 — Derived Tables
-- Problem 20 ⭐⭐⭐⭐
-- Find departments whose total salary is greater than the average department salary.
-- (This is the problem you got stuck on.)
SELECT deptno,total_salary
FROM 
  (
    SELECT deptno,SUM(sal) AS total_salary
    FROM emp 
    GROUP BY deptno
  ) d
WHERE total_salary > 
    (
      SELECT AVG(total_salary) 
      FROM (SELECT SUM(sal) AS total_salary
            FROM emp 
            GROUP BY deptno
            )t
    );


-- Problem 21 ⭐⭐⭐⭐
-- Find customers whose total spending is greater than the average customer spending.

SELECT customer_id,first_name,total_spending
FROM (
      SELECT c.customer_id,c.first_name,SUM(o.total_amount) AS total_spending
      FROM orders o 
      JOIN customers c 
        ON o.customer_id = c.customer_id
      GROUP BY customer_id
      ) t1
WHERE total_spending > 
      (
        SELECT AVG(total_spending2) 
        FROM (
          SELECT SUM(total_amount) AS total_spending2
          FROM orders 
          GROUP BY customer_id
        )t2
      )
      ;
-- Problem 22 ⭐⭐⭐⭐⭐
-- Find cities whose average order amount is greater than the overall average order amount.
SELECT address,total_amount 
FROM (
      SELECT c.address,AVG(o.total_amount) AS total_amount
      FROM customers c 
      JOIN orders o 
        ON c.customer_id = o.customer_id
      GROUP BY c.address
      )t1
WHERE total_amount < 
    (
      SELECT AVG(total_amount) 
      FROM orders
    );

-- 🔴 Level 7 — Scalar Subqueries
-- Problem 23 ⭐⭐⭐⭐
-- Show every customer along with the number of orders they have placed.
-- Output:
-- customer_id
-- name
-- order_count

-- with scalar 
SELECT 
      c.customer_id,
      c.first_name,
      (SELECT COUNT(order_id) FROM orders o WHERE c.customer_id = o.customer_id) AS order_count
FROM customers c;

-- without scalar
SELECT c.customer_id,c.first_name,COUNT(o.order_id)
FROM customers c
JOIN orders o 
  ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.first_name;


-- Problem 24 ⭐⭐⭐⭐
-- Show every customer along with their total spending.
-- Use a scalar subquery in the SELECT clause.

SELECT 
      c.first_name AS name,
      (
        SELECT SUM(o.total_amount) 
        FROM orders o 
        WHERE c.customer_id = o.customer_id
      ) AS total_amount
FROM customers c;

-- second method (just for practice)
SELECT 
      (
        SELECT first_name 
        FROM customers c 
        WHERE c.customer_id = o.customer_id
      ) AS name,
      SUM(o.total_amount) AS total_amount
FROM orders o
GROUP BY customer_id;


-- Problem 25 ⭐⭐⭐⭐⭐
-- Show every food item along with the total quantity ordered.
SELECT 
      name,
      (
        SELECT SUM(quantity)
        FROM orders o
        WHERE o.food_id = f.food_id 
      ) AS total_quantity
FROM fooditems f;

