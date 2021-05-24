SELECT * FROM employees 
WHERE salary > 40000
AND salary < 100000
AND department IN ('Automotive', 'Sports')
-- AND gender IN ('M', 'F')
AND email IS NOT NULL
ORDER BY salary DESC
LIMIT 3;

SELECT * FROM students WHERE student_age <= 20
AND (student_no BETWEEN 3 AND 5 OR student_no = 7)
OR (student_age > 20 AND student_no >= 4);

SELECT concat(first_name, '  ', last_name) FULL_NAME, department, IF (salary > 140000, 'true', 'false') 
SALARY_RANGE from employees ORDER BY SALARY_RANGE DESC;
SELECT ('Norbert' IN ('ANGELO', 'norbert', 'rose'));
SELECT department, IF (department LIKE '%oth%', 'TRUE', 'FALSE') FROM employees; 

SELECT * FROM departments;
SELECT department, SUBSTRING(department FROM 11) EXTRACTED_TEXT,
REPLACE(department, 'Fishing', 'NORBERT POGI') REPLACE_TEXT
FROM departments WHERE division = 'Outdoors';

SELECT department, CONCAT(department,'  ', 'Department') 'MODIFIED DEPARTMENT'  from departments;

SELECT email, SUBSTRING(email FROM POSITION('@' IN email) + 1) EXTRACTED_DOMAIN,
IF (email IS NULL, REPLACE(email,'','empty_email'), COALESCE(email, 'exist')) P_EMAIL
FROM employees;

SELECT COALESCE(SUBSTRING(email FROM POSITION('@' IN email) + 1), email, 'NOT_EXIST') 
EXTRACTED_DOMAIN FROM employees;

SELECT * FROM employees;
SELECT salary FROM employees ORDER BY salary DESC LIMIT 5;
SELECT ROUND(AVG(salary)) FROM employees;
SELECT COUNT(employee_id) FROM employees WHERE email IS NOT NULL;

SELECT * FROM proffessors;
SELECT CONCAT(last_name, '  ', 'works in the', ' ', department, '  ', 'department') EMPLOYEE_STATUS
FROM proffessors;

SELECT
CONCAT('It is ', IF (salary > 95000, 'true', 'false'), '  ', 'that proffessor', '  ', last_name, '  ', 'is highly paid')
PROFFESSORS_STATUS
FROM proffessors;

SELECT *, UPPER( SUBSTRING(department, 1, 3)) SHORT_DEPT
FROM proffessors;

SELECT * FROM proffessors WHERE salary = 105000 OR salary = 88000 AND last_name != 'Wilson';

select * from proffessors;
SELECT *, MIN(hire_date) MIN_hire_date FROM proffessors;

SELECT region_id, department, SUM(salary) SALARY_PER_DEPT, COUNT(department) FROM employees WHERE region_id IN (4,5,6,7) GROUP BY(department);
SELECT  DEPARTMENT, COUNT(*) TOTAL_NUM_OF_EMPLOYEE,
ROUND(AVG(salary)) AVG_SALARY, MIN(salary) MIN_SALARY, MAX(salary) MAX_SALARY
from employees
GROUP BY(department) ORDER BY TOTAL_NUM_OF_EMPLOYEE DESC;
SELECT department, gender, COUNT(*) FROM employees GROUP BY department, gender ORDER BY department;
SELECT department, COUNT(*) FROM employees  GROUP BY department HAVING COUNT(*) > 35 ORDER BY department;

-- how many people have the same first name in the company (FIRST_NAME and the TOTAL_COUNT)
SELECT FIRST_NAME, COUNT(first_name) COUNT_FIRST_NAME FROM employees GROUP BY first_name HAVING COUNT(*) > 2;
-- get the unique department in the employees table by not using DISCTINCT
SELECT department  FROM employees GROUP BY DEPARTMENT;

-- give domain name of a company and a total number of a employee that have that given domain name
-- expect to see 2 column first column is domain_name and count
SELECT SUBSTRING(email FROM POSITION('@' IN email) + 1) EMAIL_DOMAIN, COUNT(email) COUNTED_DOMAIN FROM employees 
WHERE email IS NOT NULL GROUP BY EMAIL_DOMAIN ORDER BY COUNTED_DOMAIN DESC;

-- show the following , broken down the region_id, gender
SELECT gender, region_id, MIN(salary) MIN_SALARY, MAX(salary) MAX_SALARY, ROUND(AVG(salary)) AVG_SALARY
FROM employees GROUP BY gender, region_id ORDER BY gender;

SELECT * FROM fruit_imports;
-- 1. Write a query that displays only the state with the largest amount of fruit supply.
SELECT MAX(supply) FROM fruit_imports;
SELECT state, supply
FROM fruit_imports 
GROUP BY state
ORDER BY SUM(supply) desc;

-- 2. Write a query that returns the most expensive cost_per_unit of every season. 
-- The query should display 2 columns, the season and the cost_per_unit
SELECT season, cost_per_unit, count(season) FROM fruit_imports GROUP BY cost_per_unit;
SELECT season, MAX(cost_per_unit) highest_cost_per_unit
FROM fruit_imports
GROUP BY season;

-- 3. Write a query that returns the state that has more than 1 import of the same fruit.
SELECT state, COUNT(state) COUNT_STATE FROM fruit_imports GROUP BY state HAVING COUNT(COUNT_STATE) > 1 ORDER BY COUNT_STATE DESC;

-- 4. Write a query that returns the seasons that produce either 3 fruits or 4 fruits.
SELECT season, COUNT(name)FRUIT_NAME FROM fruit_imports GROUP BY season HAVING COUNT(FRUIT_NAME) = 3 OR COUNT(FRUIT_NAME) = 4;

-- 5. Write a query that takes into consideration the supply and cost_per_unit columns 
-- for determining the total cost and returns the most expensive state with the total cost.
SELECT state, supply, cost_per_unit FROM fruit_imports GROUP BY supply ORDER BY supply DESC;
SELECT SUM(cost_per_unit) FROM fruit_imports;

-- 6. Write a query that returns the count of 4. You'll need to count on the column fruit_name and not use COUNT(*)
-- HINT: You'll need to use an additional function inside of count to make this work.
SELECT * FROM fruits;
SELECT COUNT(COALESCE(fruit_name, 'EMPTY')) TOTAL_RECORD FROM fruits;

SELECT  e.department AS EMP_DEPT, d.department AS DEPT_DEPT FROM employees e, departments d;

