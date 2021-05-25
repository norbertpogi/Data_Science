-- sample 1
SELECT first_name, salary FROM employees e1
	WHERE salary > (SELECT ROUND(AVG(salary)) FROM employees e2
					WHERE e1.department = e2.department);
-- sample 2
SELECT first_name, department, salary,
	((SELECT ROUND(AVG(salary)) FROM employees e2
					WHERE e1.department = e2.department)) AVG_SALARY
FROM employees e1;
                    
-- =====================challenges 1===============================================
-- write a query to obtain the names of those department that have more than 38 employee working
SELECT first_name, (SELECT department FROM departments e2 WHERE e2.department IN (e1.department)) department
FROM employees e1 WHERE 38 <
	(SELECT COUNT(department) FROM employees e3 WHERE e1.department IN (e3.department) GROUP BY e3.department)
    ORDER BY department;
    
    -- answer
    SELECT department FROM departments d WHERE 38 < (SELECT COUNT(*) FROM employees e WHERE e.department = d.department);
-- =====================CHALLENGES 2==================================================
-- in the above query result. add another column with the highes paid employee salary for ech one of the result department
-- HINT column(department, sum number in the next column that would be the highes paying number of the employee)
SELECT department, (SELECT MAX(salary) FROM employees empTb WHERE empTb.department IN (d.department)) highest_pad
	FROM departments d WHERE 38 < (SELECT COUNT(*) FROM employees e WHERE e.department = d.department)
ORDER BY department DESC;

-- =======================CHALLEGES 3====================================
-- build a report that looks like in the image
-- column(department, first_name, salary, salary_in_department(HIGHEST_SALARY,LOWEST_SALARY))
-- HINT on each department find the employee that has a highest salary and lowest salary
SELECT department, first_name, salary,
	CASE WHEN salary =  (SELECT MAX(salary) FROM employees e3 WHERE department 
						IN (SELECT department FROM employees a1 WHERE a1.department IN (e1.department))) 
		THEN 'HIGHTES_SALARY'
		WHEN salary = (SELECT MIN(salary) FROM employees e4 WHERE department 
						IN (SELECT department FROM employees a2 WHERE a2.department IN (e1.department))) 
        THEN 'LOWEST_SALARY' END salary_in_department
FROM employees e1 WHERE salary = (SELECT MAX(salary) FROM employees e4 WHERE department 
						IN (SELECT department FROM departments d1 WHERE d1.department = e1.department))
		 OR salary = (SELECT MIN(salary) FROM employees e3 WHERE department 
						IN (SELECT department FROM departments d2 WHERE d2.department = e1.department))
ORDER BY department;

 -- solution
 SELECT department, first_name, salary,
	CASE WHEN salary = MAX_SALARY THEN 'HIGHES_SALARY'
		 WHEN salary = MIN_SALARY THEN 'LOWEST_SALARY' END CATEGORY_IN_SALARY
		FROM (
			 SELECT department, first_name, salary,
				(SELECT MAX(salary) FROM employees e2 WHERE e2.department = e1.department) MAX_SALARY,
				(SELECT MIN(salary) FROM employees e3 WHERE e3.department = e1.department) MIN_SALARY
			 FROM employees e1) 
	e0 WHERE salary IN (MAX_SALARY, MIN_SALARY) ORDER BY department;
    
    -- == OTHER SOLUTION 1=========
SELECT department, first_name, salary,
	(CASE WHEN salary =(SELECT MAX(salary) FROM employees e2 WHERE e1.department =e2.department)
		THEN 'HIGHEST SALARY' ELSE 'LOWEST SALARY' END) salary_in_department FROM employees e1
WHERE  salary =(SELECT MAX(salary) FROM employees e2 WHERE e1.department =e2.department)
		OR    salary =(SELECT MIN(salary) FROM employees e2 WHERE e1.department =e2.department)
GROUP BY  department, salary_in_department, salary, first_name ORDER BY department;

-- OTHER BEST SOLUTION
SELECT department, first_name, salary,
		CASE WHEN salary = (SELECT MAX(salary) FROM employees WHERE department = e1.department) 
        THEN 'HIGEST SALARY' ELSE 'LOWEST SALARY' END salary_in_department
FROM employees e1 WHERE salary 
		IN ((SELECT MAX(salary) FROM employees WHERE department = e1.department),
		(SELECT MIN(salary) FROM employees WHERE department = e1.department))
ORDER BY department;