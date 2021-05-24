SELECT department FROM employees WHERE department NOT IN(SELECT department FROM departments);

SELECT e.EMP_NAME, e.YRLY_SAL FROM (SELECT first_name EMP_NAME, salary YRLY_SAL
 FROM employees WHERE salary > 150000) e;
 select * from employees;
 SELECT first_name, last_name, salary, (SELECT ROUND(AVG(salary)) FROM employees) AVG_SALARY
 FROM employees;
 
 -- give me a wide of select statement that return all of those employees 
 -- that work in the electronics division
 SELECT first_name, department FROM employees WHERE department IN 
 (SELECT department FROM departments WHERE division = 'Electronics');
 
 -- give me those employees that work in either asia or canada
 -- and that make an over 130000
 SELECT first_name, sal.salary, region_id 
 FROM (SELECT * FROM employees WHERE salary > 130000) sal
 WHERE region_id IN 
 (SELECT region_id FROM regions WHERE country IN ('Asia', 'Canada'));
 
 SELECT first_name, salary, region_id FROM employees WHERE salary > 130000
 AND region_id IN (SELECT region_id FROM regions WHERE country IN ('Asia', 'Canada'));
 
 -- show the first name and the department that an employee work for along with how much less they make than the highes paid
 -- employee in the company
 -- column (first_name, deparmtnt_employee_work_for, how_much_less_than particular employee make than the highest paid employee)
 -- 3 columns
 SELECT first_name, department, (SELECT MAX(salary) FROM employees) - salary SALARY_LEFT FROM employees 
 WHERE region_id in (SELECT region_id FROM regions WHERE country IN ('Asia', 'Canada'));
 
 SELECT * FROM employees
 WHERE region_id > ANY (SELECT region_id FROM regions WHERE country = 'United States');
 
 -- write a query that returns all of those employees that work in the kids division AND
 -- the dates at which those employees were hired is greater than all of the hire_dates of employee
 -- who work in the maintenance department
 -- HINT
	-- a. identify all employees that work int the kids division
    -- b. identify those employees are they hire date was greater than the hire date of all employee that work in the maintenance department
  SELECT first_name, department, hire_date FROM employees
	WHERE department IN (SELECT department FROM departments WHERE division = 'Kids')
	AND hire_date > ALL (SELECT hire_date FROM employees WHERE department = 'Maintenance');

-- give salary that appear the most frequently
-- hint want to see if the employee same exact salary number want to see what number that is
-- and if there are multiple salary that have the same frequency then out of that then get the highst number salary
SELECT salary FROM (
SELECT first_name, salary, COUNT(salary) SAL_COUNT FROM employees 
GROUP BY salary ORDER BY SAL_COUNT DESC, salary DESC LIMIT 1) a;

SELECT salary FROM employees HAVING COUNT(salary) > ALL (SELECT COUNT(*) FROM employees GROUP BY salary)

    