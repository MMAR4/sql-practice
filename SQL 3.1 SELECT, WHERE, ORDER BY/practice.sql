/* DAY 14
question 1
Problem Description:

The HR and Finance departments want to analyze employee compensation metrics across specific regional offices. 
Write an SQL query to retrieve the department name, the total salary distribution, and the average salary of employees for each department. 
Filter the records to only include departments located in Dallas or Chicago, and 
ensure that only departments with an average salary greater than 1,000 are displayed.
Sort the final output in descending order of the total salary expenditure.


case=1
output=
department_name	total_salary	average_salary
Research	11825.00	1970.833333
Sales	5600.00	1866.666667

*/

use fs;

select d.dname AS department_name,SUM(e.sal) AS total_salary,AVG(e.sal) AS average_salary from dept d
join emp e 
ON d.deptno = e.deptno
WHERE location IN ("Chicago","Dallas")
GROUP BY d.dname
HAVING AVG(e.sal) > 1000
ORDER BY total_salary DESC ; 


/*
Q2
Problem Description:
The restaurant management team wants to evaluate customer ordering patterns to optimize their inventory for the current month. 
Write an SQL query to retrieve the customer's first name, last name, and the total number of items they have ordered that are currently in a 'Delivered' status. 
The results should only include customers who have placed more than 2 delivered orders. 
Display the final output sorted in descending order of the total items ordered.

case=1 
output=
first_name	last_name	total_items_ordered
Arjun	Gupta	12
Amit	Sharma	8
Rahul	Verma	6


*/
use fs;
SELECT c.first_name,
        c.last_name, SUM(o.quantity) AS total_items_ordered
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY  c.customer_id,c.first_name,c.last_name
HAVING COUNT(o.order_id)>2
ORDER BY total_items_ordered DESC;


/* Q3
Problem Description:
The sales operations team wants to analyze high-performing sales representatives who are generating substantial revenue through commissions. 
Write an SQL query to retrieve the employee's name, their job title, their department's name, and their total compensation (calculated as salary plus commission).
Filter the results to include only employees whose job is 'SALESMAN',
whose commission is strictly greater than 0, and 
who work in departments located in either 'Chicago' or 'Tempe'. 
Sort the output by the calculated total compensation in descending order.


case=1
output=
employee_name	job_title	department_name	total_compensation
ALLEN	SALESMAN	Sales	1750.00

*/
use fs
SELECT e.ename AS employee_name,
        e.job AS job_title,
        d.dname AS department_name,
        (e.sal + e.comm) AS total_compensation
FROM emp e
JOIN dept d
ON d.deptno = e.deptno
WHERE e.job="SALESMAN" 
    AND d.location IN ("Chicago","Tempe")
    AND e.comm >0
ORDER BY total_compensation DESC;


/*Q4
Problem Description:
The restaurant finance team wants to audit the total revenue generated from high-value food items.
Write an SQL query to find the food item name, its category, and the total revenue generated from it (calculated as the sum of the total amount across all orders).
Only include items belonging to the 'Main Course' or 'Breakfast' categories where the item has been ordered a total quantity of more than 2 times. 
Sort the results by total revenue in descending order.

case=1
output=
food_item_name	category	total_revenue
Chicken Biryani	Main Course	900.00
Masala Dosa	Breakfast	600.00
Veg Fried Rice	Main Course	390.00
Chole Bhature	Breakfast	300.00

*/
use fs;
SELECT f.name AS food_item_name,
        f.category,
        SUM(o.total_amount) AS  total_revenue
FROM FoodItems f 
JOIN Orders o 
ON f.food_id = o.food_id
WHERE category IN ("Main Course","Breakfast")
GROUP BY f.food_id,f.name,category
HAVING SUM(o.quantity) > 2
ORDER BY total_revenue DESC
;


/*
Q5
Problem Description:
The HR department needs a clear view of the management reporting hierarchy to update their internal directory. 

Write an SQL query to retrieve the names of all employees alongside the names of their direct managers. 

The output should display the employee's number, employee's name, and the manager's name under the alias manager_name. 
Exclude any employees who do not report to anyone, and sort the list alphabetically by the manager's name.


case=1
output=
employee_id	employee_name	manager_name
7499	ALLEN	BLAKE
7521	ALLEN	BLAKE
7654	MARTIN	BLAKE
7844	KEVIN	BLAKE
7900	JAMES	BLAKE
7934	FORD	CLARK
7369	SMITH	FORD
7788	SCOTT	JONES
7902	FORD	JONES
7566	JONES	KEVIN
7698	BLAKE	KEVIN
7782	CLARK	KEVIN
7876	KEVIN	SCOTT
*/
use fs;

select
t1.empno as employee_id,
t1.ename as employee_name,
t2.ename as manager_name 
from emp t1
join emp t2 
on t1.mgr = t2.empno
order by t2.ename;

/*
Q6
Problem Description:
The customer relationship team wants to follow up with users who have orders currently delayed in the preparation phase. 

Write an SQL query to extract the customer's full name (first name and last name combined), their phone number,
the name of the food item ordered, and the order date.
Limit the records to orders where the status is exactly 'Preparing' and the food item price is greater than 100. 
Sort the final list chronologically by the order date.

case=1
output=
customer_full_name	phone	    food_item_name      	order_date
Arjun Gupta	        9876501234	Paneer Butter Masala	2026-06-17 11:17:55
Priya Singh     	8765432109	Masala Dosa	            2026-06-17 11:17:55


*/
use fs;
select 
concat(c.first_name ," ",c.last_name) AS customer_full_name,
c.phone,
f.name as food_item_name,
o.order_date
from Customers c
join Orders o 
on c.customer_id = o.customer_id
join FoodItems f
on o.food_id = f.food_id
where o.status = "Preparing" 
and f.price>100
order by o.order_date;


/* Q7
Problem Description:
The executive committee is preparing the budget for next year and needs to pinpoint departments with heavy payroll allocations.


Write an SQL query to calculate the maximum salary, minimum salary,
and total workforce count for each department number in the employee records.
Exclude employees who hold the title of 'PRESIDENT' from this calculation,  --job
and filter the groups to show only departments where the maximum salary is greater than 2000. --deptno


case=1
output=
deptno	maximum_salary	minimum_salary	total_employees
10	2450.00	1300.00	3
20	3000.00	800.00	6
30	2850.00	1250.00	3

*/
use fs;
select deptno, MAX(sal) AS maximum_salary,
min(sal) AS minimum_salary,
count(deptno) AS total_employees
from emp
where job != "PRESIDENT"
group by deptno
HAVING MAX(sal)>2000
;


/* Q8
Problem Description:
The marketing team wants to identify which food items are completely unpopular or haven't successfully converted into delivered sales yet. 

Write an SQL query to list the names of all food items,
their categories, and the total count of times they have been successfully delivered.
Use a left join to ensure that food items with zero delivered orders are still present in the list with a count of 0.
Sort the results alphabetically by the food item name.

case=1
output=
FoodItems.name          f.category  
food_item_name	        category	total_delivered_orders
Butter Naan	            Breads	            2
Chicken Biryani	        Main Course	        1
Chole Bhature	        Breakfast	        1
Dal Tadka	            Main Course	        1
Gulab Jamun	            Desserts	        1
Mango Lassi	            Beverages	        1
Masala Dosa	            Breakfast	        1
Paneer Butter Masala	Main Course	        0
Samosa	                Snacks	            2
Veg Fried Rice      	Main Course	        1

*/
use fs;
select f.name AS food_item_name,
f.category,
COUNT(o.food_id) AS total_delivered_orders
from FoodItems f
left join Orders o
on f.food_id = o.food_id
AND o.status = "Delivered"
group by f.food_id,f.name,f.category
order by name;


/*
Q9
Problem Description:
The operational audit team wants to review veterans working in key corporate locations to schedule long-service awards.

Write an SQL query to retrieve the employee name, their hire date, their job description, and their department location. ---
Filter the records to only display employees who were hired before January 1, 1997, and who are located in 'Dallas' or 'New York'. 
Sort the output so that the longest-serving employee appears first.



case=1
output=
employee_name	hiredate	job	    location 
CLARK	        1993-05-14	MANAGER	New York
SMITH	        1993-06-13	CLERK	Dallas
JONES	        1995-10-31	MANAGER	Dallas
SCOTT	        1996-03-05	ANALYST	Dallas

*/
use fs;
select
e.ename as employee_name ,e.hiredate,e.job,d.location 
from emp e
join dept d
on e.deptno = d.deptno
where e.hiredate < "1997-01-01"
AND d.location IN ("Dallas","New York") 
order by e.hiredate ;


/* Q10
Problem Description:
The business development team wants to reward loyal customers who frequently spend money on non-cancelled orders. 

Write an SQL query to find the customer ID, email address, and the total cumulative amount spent across all their orders. 
Exclude any orders that have a status of 'Cancelled' from the aggregation, and only include customers whose total spending exceeds 500. 
Order the final output from highest spending to lowest spending.

case=1
output=
customer_id	email	total_amount_spent
4	neha.patel@yahoo.com	1020.00
5	arjun.gupta@gmail.com	920.00
1	amit.sharma@gmail.com	730.00
2	priya.singh@yahoo.com	680.00
3	rahul.verma@gmail.com	610.00


*/
use fs;
SELECT c.customer_id,c.email,SUM(o.total_amount) AS total_amount_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.status != "Cancelled"
GROUP BY c.customer_id,c.email
HAVING SUM(o.total_amount) >500
ORDER BY SUM(o.total_amount) DESC;


/* Q11
Problem Description:
The compensation committee needs to cross-reference employee salaries against standard grade brackets to analyze workforce distribution.

Write an SQL query to retrieve the employee name, their job title, their exact salary, and the corresponding salary grade from the salgrade table. 
An employee's salary falls into a grade if it is between the low salary (losal) and high salary (hisal) boundaries.
Sort the results from the highest grade to the lowest grade.

case=1
output=
employee_name	job	salary	salary_grade
KEVIN	PRESIDENT	5000.00	6
KEVIN	PRESIDENT	5000.00	5
SCOTT	ANALYST	3000.00	4
FORD	ANALYST	3000.00	4
JONES	MANAGER	2975.00	4
CLARK	MANAGER	2450.00	4
KEVIN	PRESIDENT	5000.00	4
BLAKE	MANAGER	2850.00	4
KEVIN	SALESMAN	1500.00	3
SCOTT	ANALYST	3000.00	3
CLARK	MANAGER	2450.00	3
BLAKE	MANAGER	2850.00	3
JONES	MANAGER	2975.00	3
FORD	ANALYST	3000.00	3
ALLEN	SALESMAN	1600.00	3
CLARK	MANAGER	2450.00	2
KEVIN	SALESMAN	1500.00	2
FORD	ANALYST	3000.00	2
FORD	CLERK	1300.00	2
SCOTT	ANALYST	3000.00	2
BLAKE	MANAGER	2850.00	2
MARTIN	SALESMAN	1250.00	2
JONES	MANAGER	2975.00	2
ALLEN	SALESMAN	1250.00	2
ALLEN	SALESMAN	1600.00	2
SMITH	CLERK	800.00	1
MARTIN	SALESMAN	1250.00	1
KEVIN	SALESMAN	1500.00	1
KEVIN	CLERK	1100.00	1
JAMES	CLERK	950.00	1
ALLEN	SALESMAN	1250.00	1
ALLEN	SALESMAN	1600.00	1
FORD	CLERK	1300.00	1

employee_name	job	salary	salary_grade
*/
use fs;
SELECT 
e.ename AS employee_name ,
e.job AS job,
e.sal AS salary ,
s.grade AS salary_grade
FROM emp e
JOIN salgrade s
ON e.sal BETWEEN s.losal AND s.hisal
ORDER BY salary_grade DESC; 


/* Q12
Problem Description:
The kitchen chef wants to see which food categories are demanding the most volume during active shifts.

Write an SQL query to calculate the total quantity of items ordered for each food category. 
The query should look at all items, but filter the aggregated results to only show categories where the total ordered quantity across all transactions is greater than 5. 
Sort the categories in descending order of total quantity.

group by 
having total>5
left join items
order 

case=1
output=
category	total_quantity_ordered
Main Course	10
Snacks	9
Breakfast	8
Desserts	7
Breads	6
Beverages	6


*/
use fs;

SELECT f.category,SUM(o.quantity) AS total_quantity_ordered
FROM FoodItems f
LEFT JOIN Orders o
ON f.food_id = o.food_id
GROUP BY f.category
HAVING SUM(o.quantity) > 5
ORDER BY  total_quantity_ordered DESC;



/* Q13
Problem Description:
The organizational analysts want to check the distribution of specific clerical and administrative roles across standard corporate branches.

Write an SQL query to find the employee's name, their job, their department number, and the department name.
Filter the rows to include only those employees whose job role is exactly 'CLERK' and whose department is not located in 'New York'. 
Sort the results alphabetically by the employee's name.


case=1
output=
emp ename       ejob        e.deptno        dept.dname

employee_name	job	        deptno	        department_name
JAMES	        CLERK   	20	            Research
KEVIN	        CLERK   	20	            Research
SMITH	        CLERK   	20	            Research


*/
use fs;
SELECT e.ename AS employee_name, e.job,
e.deptno,d.dname AS department_name
FROM emp e
JOIN dept d
ON e.deptno = d.deptno
WHERE e.job = "CLERK" AND d.location !="New York"
ORDER BY e.ename;


/* Q14
Problem Description:
The shipping coordinators want to find unique transaction entries where a customer bought an unusually high volume of an individual item in a single order line.

Write an SQL query to find the order ID, customer ID, and the maximum quantity ordered in a single transaction. 
Filter the rows down to only showcase orders where the individual quantity is 3 or more and the status is listed as 'Delivered' or 'Preparing'.


case=1
output=
order_id	customer_id	maximum_quantity
15	            5           	5
6	            2           	4
12	            4           	4
16	            5           	4
2	            1           	3
14	            5           	3
20	            3           	3

*/
use fs;
SELECT o.order_id,c.customer_id,MAX(o.quantity) AS maximum_quantity
FROM Orders o
JOIN Customers c
ON o.customer_id = c.customer_id
WHERE o.quantity >=3
AND o.status IN ('Delivered','Preparing')
GROUP BY o.order_id,c.customer_id
ORDER BY maximum_quantity DESC;


/* Q15
Problem Description:
The customer service helpdesk requires a comprehensive master report to verify line-item details for pending financial reconciliations. 

Write an SQL query to combine data from three tables to extract the customer's email, the order date, the food item name, the individual item price, and the total amount charged. 
Filter the output to show only transactions where the order status is 'Pending'.
Sort the output chronologically by the order date.


case=1
output=
c.email                 o.order_date        f.name          f.price     o.total_amount

email	                order_date	        food_item_name	unit_price	total_amount
neha.patel@yahoo.com	2026-06-17 11:17:55	Chole Bhature	100.00	    100.00
neha.patel@yahoo.com	2026-06-17 11:17:55	Chicken Biryani	300.00	    600.00
priya.singh@yahoo.com	2026-06-17 11:17:55	Veg Fried Rice	130.00	    260.00

*/
use fs;

SELECT
c.email,
o.order_date,
f.name AS food_item_name ,
f.price AS unit_price,
o.total_amount

FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN FoodItems f
ON o.food_id = f.food_id
WHERE o.status = "Pending"
ORDER BY o.order_date;





