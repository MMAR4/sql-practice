/* DAY 15 Q1

Problem Description:
The HR director wants to assess the management overhead by analyzing salary distributions mapped to individual supervisors. 

Write an SQL query to fetch the manager's name and the average salary of the employees who report directly to them. 
Group the data by the manager's identity, and only include managers where the average salary of their subordinates exceeds 1500.
Sort the final output by average salary in descending order.


case=1
output=
manager_name	average_subordinate_salary
JONES       	3000.000000
KEVIN       	2758.333333


*/
use fs;
SELECT 
 t2.ename AS manager_name,
AVG(t1.sal) AS average_subordinate_salary
FROM emp t1
JOIN emp t2
ON t1.mgr = t2.empno
GROUP BY t2.ename
HAVING AVG(t1.sal)>1500
ORDER BY average_subordinate_salary DESC;

/* Q2
Problem Description:
The operations manager wants to verify the pricing structure of active items on the menu to see if any adjustments are needed for the upcoming holiday season. 

Write an SQL query to extract the category name, the count of active food items in that category, and the average price of those items.
Only evaluate food items that are marked as available (availability = 1) and whose individual price is greater than or equal to 50.

case=1
output=
category	total_available_items	average_price
Main Course	4	207.500000
Breakfast	2	110.000000
Desserts	1	50.000000
Beverages	1	60.000000

*/
use fs;
SELECT category,COUNT(name) AS total_available_items,AVG(price) AS average_price
FROM FoodItems f
WHERE availability = 1 AND price >=50
GROUP BY category
;


/* Q3
Problem Description:
The sales strategy division wants to measure regional market penetration by identifying if there are registered customer locations that have zero transaction footprint. 

Write an SQL query to select each customer's address, full name, and the total number of orders they have placed.
Use an appropriate join to ensure that customers who have never placed an order are still listed with an order count of 0.

case=1
output=


address 	            customer_name	total_orders_placed
Delhi,  India           Amit Sharma	            4
Mumbai, India           Priya Singh	            4
Bengaluru, India        Rahul Verma	            4
Ahmedabad, India        Neha Patel	            4
Hyderabad, India        Arjun Gupta	            4


*/
use fs;
SELECT 
c.address,
CONCAT(c.first_name," ",c.last_name) AS customer_name, 
COUNT(o.customer_id) AS total_orders_placed
FROM Customers c 
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.address,CONCAT(c.first_name," ",c.last_name);



/*
Q4
Problem Description:
The executive leadership team wants to run a cost-center check on departments that employ highly paid analytical staff.

Write an SQL query to fetch the department name, location, and the total salary pool for employees within that department. 
Filter out any staff members whose salary is less than or equal to 1200 before grouping, and 
only show departments whose total combined salary pool for these qualified individuals is greater than 2500.

case=1
output=
department_name	location	qualified_salary_pool
Accounting	New York	5350.00
Sales	    Chicago	5600.00
Research	Dallas	8975.00
Operations	Boston	6250.00

*/
use fs;
SELECT d.dname AS department_name,d.location,SUM(e.sal) AS qualified_salary_pool
FROM dept d
Join emp e 
ON d.deptno = e.deptno
WHERE e.sal >1200
GROUP BY d.dname,d.location
HAVING SUM(e.sal) >2500



/* Q5
Problem Description:
The food truck operations desk wants to check the historical sales velocities specifically for quick-service categories. 

Write an SQL query to discover the order ID, the food item name, its category, and the quantity ordered.
Limit the rows to items classified under the 'Snacks' or 'Beverages' categories, and ensure only orders with an explicit quantity of 2 or more are returned. 
Sort the list by quantity in descending order.

case=1
output=
order_id	food_item_name	category	quantity
15	        Samosa	        Snacks	        5
6	        Samosa	        Snacks	        4
20	        Mango Lassi	    Beverages   	3
13	        Mango Lassi	    Beverages   	2
*/
use fs;
SELECT 
    o.order_id,
    f.name AS food_item_name,
    f.category,
    o.quantity 
FROM 
    Orders o 
JOIN 
    FoodItems f
    ON o.food_id = f.food_id
WHERE 
    f.category IN ('Snacks','Beverages') 
    AND o.quantity >= 2
ORDER BY
    o.quantity DESC;


/* Q6
Problem Description:
The reward and recognition committee is auditing the salary distribution across standard organizational tiers. 

Write an SQL query to find the salary grade numbers from the salgrade table along with the count of employees whose salaries fall into those respective grade brackets.
Only show grades that have more than 2 employees assigned to them, and sort the grades in ascending order.

case=1
output=
salary_grade	employee_count
1	                8
2	                10
3	                7
4	                6



*/
use fs;
SELECT s.grade AS salary_grade,
COUNT(e.empno) AS employee_count
FROM salgrade s
JOIN emp e
ON e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade
HAVING COUNT(e.empno)>2
ORDER BY salary_grade;



/* Q7
Problem Description:b
The corporate systems team needs a clean audit of team rosters reporting to specific mid-level managers. 

Write an SQL query to retrieve the employee name, their hire date, their salary, and their direct manager's name. 
Filter the records to include only employees who report to managers with the employee numbers 7698 or 7566,
and whose salary is greater than 1000. Sort the final output alphabetically by employee name.

case=1
output=

employee_name	hiredate	salary	manager_name
ALLEN	        1998-08-15	1600.00 	BLAKE
ALLEN	        1996-03-26	1250.00 	BLAKE
FORD	        1997-12-05	3000.00 	JONES
KEVIN	        1995-06-04	1500.00 	BLAKE
MARTIN	        1998-12-05	1250.00 	BLAKE
SCOTT	        1996-03-05	3000.00 	JONES



*/ 
use fs;
SELECT 
    t1.ename AS employee_name,
    t1.hiredate,
    t1.sal AS salary,
    t2.ename AS manager_name
FROM emp t1
JOIN emp t2
    ON t1.mgr = t2.empno
WHERE 
    t2.empno IN ('7698','7566')
    AND t1.sal > 1000
ORDER BY t1.ename;


/* Q9
Problem Description:
The point-of-sale terminal supervisor wants to analyze processing batches to check for high-ticket individual item sales transactions.
Write an SQL query to list the order date, the count of unique orders placed on that date, and the maximum total amount recorded on a single order. 
Filter the groups to show only dates where the maximum individual order amount exceeds 300.


case=1
output=
explicit_date	total_orders	max_order_amount
2026-06-17	       20	        600.00


*/
use fs;
SELECT 
    DATE(order_date) AS explicit_date,
    COUNT(DISTINCT order_id) AS total_orders,
    MAX(total_amount) AS max_order_amount
FROM Orders
GROUP BY DATE(order_date)
HAVING MAX(total_amount) > 300
;
-- DATE_FORMAT(order_date,"%Y-%m-%d")


/* Q9
Problem Description:
The email marketing team is preparing a specific discount campaign targeting users on legacy email platforms.

Write an SQL query to find the customer's full name, email address, physical location, and the total quantity of items they ordered across all transactions.
Limit the base records to customers whose email ends with '@yahoo.com'.
Sort the output based on the total quantity in descending order.

case=1
output=
customer_name	email	                address	        total_quantity_ordered
Priya Singh	    priya.singh@yahoo.com	Mumbai, India   	9
Neha Patel	    neha.patel@yahoo.com	Ahmedabad, India	9



*/
use fs;
SELECT 
    CONCAT(c.first_name," ",c.last_name) AS customer_name,
    c.email,
    c.address,
    SUM(o.quantity) AS total_quantity_ordered
FROM Customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
WHERE c.email LIKE "%@yahoo.com"
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.address
ORDER BY total_quantity_ordered DESC
    
    
/*Q10
Problem Description:
The financial controllers need to discover which active managers are supervising teams that consume large portions of the budget. 
Write an SQL query to pull the manager's employee number, the manager's name, and the sum total of all salaries earned by their immediate direct reports. 
Only return rows where the cumulative salary pool of subordinates is greater than 4000. Sort from highest pool to lowest.

case=1
output=
manager_id	manager_name	total_subordinate_payroll
7839	        KEVIN       	8275.00
7698	        BLAKE       	6550.00
7566	        JONES       	6000.00



*/
use fs;
SELECT 
    e.mgr AS manager_id,
    m.ename AS manager_name,
    SUM(e.sal) AS total_subordinate_payroll
    
FROM emp e
JOIN emp m
    ON e.mgr = m.empno
GROUP BY 
        m.empno,
        m.mgr,
        m.ename
HAVING SUM(e.sal) > 4000
ORDER BY total_subordinate_payroll DESC;



/* Q11
Problem Description:
The HR talent acquisition division wants to look back at historical hiring trends to track expansion across regional nodes.

Write an SQL query to pull the employee name, job title, hire date, 
and department name for all workers who were hired after January 1, 1995.
Exclude anyone working out of the 'Boston' or 'Tempe' regional branches.
Sort the records chronologically by hire date.

case=1
output=
employee_name	job	        hiredate	department_name
KEVIN       	SALESMAN	1995-06-04	Sales
JONES       	MANAGER 	1995-10-31	Research
SCOTT       	ANALYST 	1996-03-05	Research
ALLEN       	SALESMAN	1996-03-26	Sales
FORD        	ANALYST	    1997-12-05	Research
ALLEN       	SALESMAN	1998-08-15	Accounting
KEVIN       	CLERK	    1999-06-04	Research
FORD        	CLERK	    2000-01-21	Accounting
JAMES       	CLERK	    2000-06-23	Research



*/
use fs;
SELECT 
    e.ename AS employee_name,
    e.job,
    e.hiredate,
    d.dname AS department_name
FROM emp e
JOIN dept d
    ON e.deptno = d.deptno
WHERE e.hiredate > "1995-01-01"
AND d.location NOT IN ('Boston','Tempe')
ORDER BY e.hiredate ;


/* Q12

Problem Description:
The inventory supervisor wants to calculate delivery patterns specifically for accompaniment menu categories like 'Breads' to prepare the kitchen prep list.

Write an SQL query to retrieve the food item name, its category, and the total number of individual orders placed for that item. 
Filter the system to only look at food items categorized under 'Breads' that have a status of 'Delivered'.

case=1
output=
food_item_name	category	total_successful_orders
Butter Naan 	Breads	            2



*/
use fs;
SELECT f.name AS food_item_name,
f.category,
COUNT(o.order_id) AS total_successful_orders
FROM FoodItems f
JOIN Orders o
    ON f.food_id = o.food_id
WHERE
    f.category ="Breads" 
    AND o.status = "Delivered"
GROUP BY
    f.name,
    f.category,
    f.food_id


/* Q13
Problem Description:
The executive board wants to identify standard transaction sizes to evaluate point-of-sale pricing tiers.

Write an SQL query to calculate the total number of orders and the average total amount spent per order for each unique customer ID.
Filter out any individual orders with a total_amount less than 100 before computing metrics,
and only show customers who have placed at least 2 such orders.


case=1
output=
customer_id	qualified_orders_count	average_order_value
1	            3                   	216.666667
2	            3                   	206.666667
3	            4                   	215.000000
4	            4                   	255.000000
5	            4                   	230.000000



*/
use fs;
SELECT c.customer_id,
    COUNT(o.order_id) AS qualified_orders_count,
    AVG(o.total_amount) AS average_order_value
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.total_amount >=100
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >=2
ORDER BY customer_id;
    

/* Q14
Problem Description:
The HR internal compliance framework requires a complex cross-reference mapping that links employees to both their workspace location and their salary classification tier. 
Write an SQL query to find the employee's name, their department name, their work location, and their exact salary grade tier. 
Sort the entire output file primary by the department name alphabetically, and secondary by the salary grade in descending order.


case=1
output=
employee_name	department_name	location	salary_grade
CLARK	Accounting	New York	4
ALLEN	Accounting	New York	3
CLARK	Accounting	New York	3
CLARK	Accounting	New York	2
FORD	Accounting	New York	2
ALLEN	Accounting	New York	2
FORD	Accounting	New York	1
ALLEN	Accounting	New York	1
KEVIN	Operations	Boston	6
KEVIN	Operations	Boston	5
KEVIN	Operations	Boston	4
MARTIN	Operations	Boston	2
MARTIN	Operations	Boston	1
JONES	Research	Dallas	4
FORD	Research	Dallas	4
SCOTT	Research	Dallas	4
SCOTT	Research	Dallas	3
JONES	Research	Dallas	3
FORD	Research	Dallas	3
SCOTT	Research	Dallas	2
FORD	Research	Dallas	2
JONES	Research	Dallas	2
SMITH	Research	Dallas	1
KEVIN	Research	Dallas	1
JAMES	Research	Dallas	1
BLAKE	Sales	Chicago	4
BLAKE	Sales	Chicago	3
KEVIN	Sales	Chicago	3
ALLEN	Sales	Chicago	2
KEVIN	Sales	Chicago	2
BLAKE	Sales	Chicago	2
KEVIN	Sales	Chicago	1
ALLEN	Sales	Chicago	1

*/
use fs;
SELECT e.ename AS employee_name,
    d.dname AS department_name,
    d.location,
    s.grade AS salary_grade
FROM emp e
JOIN dept d
    ON e.deptno = d.deptno
JOIN salgrade s
    ON e.sal BETWEEN s.losal 
    AND s.hisal
ORDER BY 
    d.dname,
    s.grade DESC;


/* Q15
Problem Description:
The financial closing analyst wants to finalize the revenue figures generated exclusively from fulfilled dining transactions.
Write an SQL query to calculate the item name, its category, and the total combined amount collected across all orders. 
Restrict your dataset calculation to orders that are marked with a status of 'Delivered'.
Sort the resulting dataset matrix by the total revenue metric in descending order.


case=1
output=
food_item_name	category	revenue_collected
Masala Dosa	Breakfast	360.00
Chicken Biryani	Main Course	300.00
Dal Tadka	Main Course	300.00
Samosa	Snacks	270.00
Butter Naan	Breads	240.00
Chole Bhature	Breakfast	200.00
Mango Lassi	Beverages	180.00
Gulab Jamun	Desserts	150.00
Veg Fried Rice	Main Course	130.00



*/
use fs;
SELECT 
    f.name AS food_item_name,
    f.category,
    SUM(o.total_amount) AS revenue_collected
FROM 
    FoodItems f
INNER JOIN 
    Orders o ON f.food_id = o.food_id
WHERE 
    o.status = 'Delivered'
GROUP BY 
    f.food_id, f.name, f.category
ORDER BY 
    revenue_collected DESC;
    
    
    
