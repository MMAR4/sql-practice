/* Q16
Problem Description:
The kitchen manager needs to review details for all orders containing items priced strictly above the calculated average price of all available food items on the menu.

Write an SQL query to retrieve the unique order IDs, customer IDs, and total amounts from the Orders table for these high-value items. 
Use an uncorrelated subquery in the WHERE clause to compute the baseline average price.

case=1
output=
order_id	customer_id	    total_amount
7	            3       	250.00
17	            5       	250.00
1	            1       	300.00
11	            4       	600.00
8	            3       	300.00
9	            3       	130.00
19	            2       	260.00


*/
use fs;
SELECT DISTINCT o.order_id, o.customer_id,total_amount
FROM Orders o
JOIN FoodItems f
    ON o.food_id = f.food_id  
WHERE f.price > (SELECT AVG(price) FROM FoodItems ) ;



/* Q17
Problem Description:
The HR department wants to audit regional branches that currently house active analytical or technical staff. 
Write an SQL query to extract the department number, department name, and regional location from the dept table. 
Use a correlated subquery with an EXISTS operator to filter for departments that have at least one employee working as an 'ANALYST'.

case=1
output=
deptno	dname	    location
20  	Research	Dallas



*/
use fs;
SELECT deptno,dname,location
FROM dept d
WHERE EXISTS
    (
        SELECT 1
        FROM emp e
        WHERE e.deptno =d.deptno 
            AND e.job="ANALYST"
    );


/* Q18
Problem Description:
The financial control team wants to flag departments whose total payroll expenditure exceeds the average department-wise payroll across the company. 
Write an SQL query to find the department number and the sum of salaries for these high-expense departments. 
Group the records by department number and use a subquery inside the HAVING clause to benchmark against the overall average departmental total salary pool.

case=1
output=
deptno	total_payroll
20	    11825.00
*/
use fs;
SELECT deptno,SUM(sal) AS total_payroll
FROM emp e
GROUP BY deptno
HAVING SUM(sal) >=
    (
        SELECT AVG(total) 
        FROM 
            (
                SELECT SUM(sal) AS total 
                FROM emp e2
                GROUP BY deptno
            )t1
        
    );



/* Q19
Problem Description:
The marketing team wants a list of customers who have registered a user profile on the platform but have never placed any food orders.
Write an SQL query to select the customer ID, first name, last name, and email from the Customers table. 
Implement an uncorrelated subquery tracking all unique customer IDs present in the Orders table to filter them out using a NOT IN constraint.

case=1
output=
customer_id	first_name	last_name	email
*/
use fs;
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM
    Customers
WHERE 
    customer_id  NOT IN (
        SELECT DISTINCT customer_id 
        from Orders
        WHERE customer_id IS NOT NULL
    );



/* Q20
Problem Description:
The compensation committee wants to identify individual employees who are exceptionally well-paid relative to their specific peer job roles. 
Write an SQL query to find the employee number, name, job title, and salary from the emp table. 
Use a correlated subquery to evaluate and filter out individuals earning more than the average salary computed for their own respective job designation.


case=1
output=
empno	ename	job	            sal
7499	ALLEN	SALESMAN	1600.00
7566	JONES	MANAGER	    2975.00
7698	BLAKE	MANAGER	    2850.00
7844	KEVIN	SALESMAN	1500.00
7876	KEVIN	CLERK	    1100.00
7934	FORD	CLERK	    1300.00


*/
use fs;
SELECT empno,ename,job,e.sal
FROM emp e
WHERE e.sal > 
    (
        SELECT AVG(e2.sal) 
        FROM emp e2
        WHERE e2.job = e.job
    );


