-- 1. ==============================CONDTIONAL EXPRESSION USING CASE CLAUSE=============================================================================================
SELECT first_name, salary,
CASE 
	WHEN salary < 100000 THEN 'UNDER PAID'
    WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
    WHEN salary > 160000 THEN 'EXECUTIVE'
    ELSE 'UNPAID'
END AS employee_status
FROM employees ORDER BY salary DESC;

SELECT first_name, salary, 
	IF (salary > 100000, 'PAID WELL', 'UNDER PAID') employee_status
FROM employees ORDER BY salary DESC;

-- show the total count of the executive and all the employee that paid well and all the people that are under paid
-- the client would like to see the total count of those 3 category (paid well, under paid and executive)
-- the table expected would be 2 column (the_category, total_count)
-- HINT wrap query above in a subquery
SELECT main_sub.category AS the_category, COUNT(salary) AS total_count FROM (
SELECT first_name, salary,
CASE 
	WHEN salary < 100000 THEN 'UNDER PAID'
    WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
    WHEN salary > 160000 THEN 'EXECUTIVE'
    ELSE 'UNPAID'
END AS category
FROM employees em_sub ORDER BY salary DESC
) main_sub GROUP BY the_category ORDER BY total_count DESC;

-- transform into table column(UNDERPAID, PAID WELL, EXECUTIVE)
SELECT SUM(CASE WHEN salary < 100000 THEN 1 ELSE 0 END) 'UNDER PAID',
	   SUM(CASE WHEN salary > 100000 AND salary < 160000 THEN 1 ELSE 0 END) 'PAID WELL',
       SUM(CASE WHEN salary > 160000 THEN 1 ELSE 0 END) 'EXECUTIVE'
FROM employees;

-- 2. =====================================CASE CLAUSE=============================================================================
-- trasport a data set
SELECT department, COUNT(*) FROM employees
WHERE department IN ('Sports','Tools','Clothing','Computers')
GROUP BY department;

-- in the above query
-- transform data in the following colulmn(sports_employees, tools_employees, clothing_employees, computers_employees)
SELECT SUM(CASE WHEN department = 'Sports' THEN 1 ELSE 0 END) sports_employees,
	   SUM(CASE WHEN department = 'Tools' THEN 1 ELSE 0 END) tools_employees,
       SUM(CASE WHEN department = 'Clothing' THEN 1 ELSE 0 END) clothing_employees,
	   SUM(CASE WHEN department = 'Computers' THEN 1 ELSE 0 END) computers_employees
FROM employees;

-- generate a report that looks like shown in the image
-- the image shown the region of all employees
-- your going to need to use the CASE CLAUSE
SELECT first_name, emp_table.region_id, 
	(SELECT country FROM regions WHERE region_id IN (emp_table.region_id)) country 
FROM employees emp_table;

-- transform the query above into table column from the result
SELECT first_name, 
	(CASE WHEN region_id = 1 THEN 
		(SELECT country FROM regions WHERE region_id = 1) 
			ELSE 0 END) REGION_1,
	(CASE WHEN region_id = 2 THEN 
		(SELECT country FROM regions WHERE region_id = 2) 
			ELSE 0 END) REGION_2, 
	(CASE WHEN region_id = 3 THEN 
		(SELECT country FROM regions WHERE region_id = 3) 
			ELSE 0 END) REGION_3
FROM employees emp_table;

-- generate a report with the total of column(united_states, asia, canada)
-- HINT total of all employees work in a specific country
SELECT (CASE WHEN country = 'United States' 
			THEN (SELECT COUNT(*) FROM employees WHERE region_id IN 
				 (SELECT region_id FROM regions WHERE country = 'United States'))
			ELSE 0 END) UNITED_STATES,
		
        (CASE WHEN country = 'Canada'
			  THEN (SELECT COUNT(*) FROM employees WHERE region_id IN 
				   (SELECT region_id FROM regions WHERE country = 'Canada'))
			  ELSE 0 END) CANADA,
              
		(CASE WHEN country = 'Asia' 
			  THEN (SELECT COUNT(*) FROM employees WHERE region_id IN 
				   (SELECT region_id FROM regions WHERE country = 'Asia'))
				ELSE 0 END) ASIA
        FROM regions GROUP BY ASIA, CANADA, UNITED_STATES;
           
	-- LOGIC 2
    SELECT SUM(CASE WHEN REGION_ID IN (1, 2, 3) THEN 1 END) AS UNITED_STATES,
			SUM(CASE WHEN REGION_ID IN (4, 5) THEN 1 END) AS ASIA,
			SUM(CASE WHEN REGION_ID IN (6, 7) THEN 1 END) AS CANADA
	FROM EMPLOYEES;

-- =================CHALLENGE=================================================================================================
-- 1. Write a query that displays 3 columns. The query should display the fruit and 
-- it's total supply along with a category of either LOW, ENOUGH or FULL. Low category means 
-- that the total supply of the fruit is less than 20,000. The enough category means that the total supply is 
-- between 20,000 and 50,000. If the total supply is greater than 50,000 then that fruit falls in the full category.
SELECT name FRUITS, SUM(supply) total_supply, 
    CASE WHEN supply BETWEEN 20000 AND 50000 THEN 'ENOUGH' 
		ELSE (CASE WHEN supply > 50000 THEN 'FULL'
			ELSE ('LOW') END) END
    CATEGORY
FROM fruit_imports GROUP BY supply ORDER BY total_supply DESC;

-- logic 2
SELECT name, total_supply, CASE WHEN total_supply < 20000 THEN 'LOW'
								WHEN total_supply >= 20000 AND total_supply <= 50000 THEN 'ENOUGH'
                                WHEN total_supply > 50000 THEN 'FULL' 
							END as category

FROM (SELECT name, sum(supply) total_supply FROM fruit_imports GROUP BY name) a;

-- 2. Taking into consideration the supply column and the cost_per_unit column, 
-- 	you should be able to tabulate the total cost to import fruits by each season. The result will look something like this:
-- "Winter" "10072.50"
-- "Summer" "19623.00"
-- "All Year" "22688.00"
-- "Spring" "29930.00"
-- "Fall" "29035.00"
-- Write a query that would transpose this data so that the seasons become columns and the total cost for each season fills the first row?
SELECT * FROM fruit_imports;
SELECT (CASE WHEN season = 'Winter' THEN AVG(supply) ELSE cost_per_unit END) Winter,
		(CASE WHEN season = 'Summer' THEN AVG(supply) ELSE cost_per_unit END) Summer,
        (CASE WHEN season = 'All Year' THEN AVG(supply) ELSE cost_per_unit END) All_Year,
        (CASE WHEN season = 'Spring' THEN AVG(supply) ELSE cost_per_unit END) Spring,
        (CASE WHEN season = 'Fall' THEN AVG(supply) ELSE cost_per_unit END) Fall
FROM fruit_imports 
GROUP BY season ORDER BY season DESC;

-- answer
SELECT SUM(CASE WHEN season = 'Winter' THEN total_cost end) as Winter_total,
	   SUM(CASE WHEN season = 'Summer' THEN total_cost end) as Summer_total,
	   SUM(CASE WHEN season = 'Spring' THEN total_cost end) as Spring_total,
	   SUM(CASE WHEN season = 'Fall' THEN total_cost end) as Spring_total,
	   SUM(CASE WHEN season = 'All Year' THEN total_cost end) as Spring_total
FROM (select season, sum(supply * cost_per_unit) total_cost from fruit_imports group by season) a;

-- logic 2
SELECT SUM(CASE WHEN season = 'Winter' THEN supply*cost_per_unit ELSE 0 END) as winter,
   SUM(CASE WHEN season = 'Summer' THEN supply*cost_per_unit ELSE 0 END) as summer,
   SUM(CASE WHEN season = 'All Year' THEN supply*cost_per_unit ELSE 0 END) as all_year,
   SUM(CASE WHEN season = 'Spring' THEN supply*cost_per_unit ELSE 0 END) as spring,
   SUM(CASE WHEN season = 'Fall' THEN supply*cost_per_unit ELSE 0 END) as fall
FROM fruit_imports;