/****************************************************************************************
                    SQL 3.6 SUBQUERIES - PATTERN SHEET
****************************************************************************************/


/****************************************************************************************
PATTERN 1 : Compare with Overall Average
****************************************************************************************/

SELECT columns
FROM table
WHERE column >
(
    SELECT AVG(column)
    FROM table
);



/****************************************************************************************
PATTERN 2 : Compare with Overall Maximum
****************************************************************************************/

SELECT columns
FROM table
WHERE column =
(
    SELECT MAX(column)
    FROM table
);



/****************************************************************************************
PATTERN 3 : Compare with Overall Minimum
****************************************************************************************/

SELECT columns
FROM table
WHERE column =
(
    SELECT MIN(column)
    FROM table
);



/****************************************************************************************
PATTERN 4 : Compare with Group Average
****************************************************************************************/

SELECT columns
FROM table t1
WHERE column >
(
    SELECT AVG(column)
    FROM table t2
    WHERE t2.group_column = t1.group_column
);



/****************************************************************************************
PATTERN 5 : Highest Value in Each Group
****************************************************************************************/

SELECT columns
FROM table t1
WHERE column =
(
    SELECT MAX(column)
    FROM table t2
    WHERE t2.group_column = t1.group_column
);



/****************************************************************************************
PATTERN 6 : Lowest Value in Each Group
****************************************************************************************/

SELECT columns
FROM table t1
WHERE column =
(
    SELECT MIN(column)
    FROM table t2
    WHERE t2.group_column = t1.group_column
);



/****************************************************************************************
PATTERN 7 : IN
****************************************************************************************/

SELECT columns
FROM table
WHERE column IN
(
    SELECT column
    FROM another_table
);



/****************************************************************************************
PATTERN 8 : NOT IN
****************************************************************************************/

SELECT columns
FROM table
WHERE column NOT IN
(
    SELECT column
    FROM another_table
    WHERE column IS NOT NULL
);



/****************************************************************************************
PATTERN 9 : EXISTS
****************************************************************************************/

SELECT columns
FROM parent p
WHERE EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.parent_id = p.parent_id
);



/****************************************************************************************
PATTERN 10 : NOT EXISTS
****************************************************************************************/

SELECT columns
FROM parent p
WHERE NOT EXISTS
(
    SELECT 1
    FROM child c
    WHERE c.parent_id = p.parent_id
);



/****************************************************************************************
PATTERN 11 : Compare Group Totals
****************************************************************************************/

SELECT
group_column,
SUM(column)
FROM table
GROUP BY group_column
HAVING SUM(column) >
(
    SELECT AVG(total)
    FROM
    (
        SELECT
        SUM(column) AS total
        FROM table
        GROUP BY group_column
    ) t
);



/****************************************************************************************
PATTERN 12 : Derived Table
****************************************************************************************/

SELECT *
FROM
(
    SELECT
    group_column,
    aggregate(column) AS result
    FROM table
    GROUP BY group_column
) t;



/****************************************************************************************
PATTERN 13 : Join with Derived Table
****************************************************************************************/

SELECT
t1.*,
t2.result
FROM table t1
JOIN
(
    SELECT
    group_column,
    aggregate(column) AS result
    FROM table
    GROUP BY group_column
) t2
ON t1.group_column = t2.group_column;



/****************************************************************************************
PATTERN 14 : Compare with Derived Table Result
****************************************************************************************/

SELECT
t1.*
FROM table t1
JOIN
(
    SELECT
    group_column,
    AVG(column) AS avg_value
    FROM table
    GROUP BY group_column
) t2
ON t1.group_column=t2.group_column
WHERE t1.column > t2.avg_value;



/****************************************************************************************
PATTERN 15 : ANY
****************************************************************************************/

SELECT columns
FROM table
WHERE column > ANY
(
    SELECT column
    FROM table
    WHERE condition
);



/****************************************************************************************
PATTERN 16 : ALL
****************************************************************************************/

SELECT columns
FROM table
WHERE column > ALL
(
    SELECT column
    FROM table
    WHERE condition
);



/****************************************************************************************
PROBLEM → PATTERN MAP
****************************************************************************************/

Overall Average
→ Pattern 1

Overall Maximum
→ Pattern 2

Overall Minimum
→ Pattern 3

Department Average
→ Pattern 4

Highest in Department
→ Pattern 5

Lowest in Department
→ Pattern 6

Matching Values
→ Pattern 7

Missing Values
→ Pattern 8

Has Related Rows
→ Pattern 9

No Related Rows
→ Pattern 10

Department Totals
→ Pattern 11

Temporary Table
→ Pattern 12

Join Aggregated Data
→ Pattern 13

Compare with Group Aggregate
→ Pattern 14

Greater than Any
→ Pattern 15

Greater than All
→ Pattern 16



/****************************************************************************************
INTERVIEW CHECKLIST
****************************************************************************************/

□ Overall Average?

□ Group Average?

□ Highest in Group?

□ Lowest in Group?

□ Matching Rows?

□ Missing Rows?

□ Overall Aggregate?

□ Group Aggregate?

□ HAVING Needed?

□ Derived Table Needed?

□ EXISTS or IN?

□ Correlated or Uncorrelated?



/****************************************************************************************
END OF PATTERN SHEET
****************************************************************************************/
