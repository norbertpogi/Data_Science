-- 1. ==========WORKING WITH JOIN TABLE==================================================================================
SELECT first_name, country FROM employees em, regions reg
WHERE em.region_id = reg.region_id;

-- == challeges 1.1
-- create a report that give the frist_name of the employee, email_address, division
-- no null data display
SELECT first_name, email, division, country, em.department FROM employees em, departments dep, regions reg
WHERE dep.department = em.department
AND em.region_id = reg.region_id
AND email IS NOT NULL; 

-- ==challenges 1.2
-- write a query that gives the country as well as the total number employee in that country
SELECT r.country, count(employee_id)
	 -- (SELECT COUNT(*) FROM employees e2 WHERE e2.region_id = r.region_id) total_number_employee
FROM employees e1, regions r WHERE e1.region_id = r.region_id GROUP BY country ORDER BY country;

-- 2. INNER AND OUTHER JOINS======================================================== 
SELECT first_name, country FROM employees e INNER JOIN regions r
ON e.region_id = r.region_id;

SELECT first_name, email, division, country
FROM employees e INNER JOIN departments d
ON e.department IN (d.department) 
INNER JOIN regions r ON e.region_id = r.region_id
WHERE email IS NOT NULL;

-- 2. ===================INNER AND OUTER JOIN===============================================================================================

-- LEFT JOIN AND RIGHT JOIN ===============================
SELECT DISTINCT department FROM employees;
-- 27 record

SELECT DISTINCT department FROM departments;
-- 24 records

-- left join give preferences table from the left means the priority table
-- would be from left record regardless the record from the right table
-- the query below expected output is 27 records
SELECT  DISTINCT e.department e_department, d.department d_department
FROM employees e LEFT JOIN departments d
ON e.department = d.department;

-- right join give preferences table from the right means the priority table
-- would be from left record regardless the record from the right table
-- the query below expected output is 24 records
SELECT  DISTINCT e.department e_department, d.department d_department
FROM employees e RIGHT JOIN departments d
ON e.department = d.department;

-- ==== challenges 1===========================
-- show only those department that exists in the employees table that do not exist in the 
-- departments table
SELECT e.department EMPLOYEES_TABLE, d.department DEPARTMENT_TABLE
FROM employees e LEFT JOIN departments d 
ON e.department = d.department
WHERE d.department IS NULL GROUP BY EMPLOYEES_TABLE ORDER BY 1;

-- ====answer same result with the above query
SELECT DISTINCT e.department EMPLOYEES_TABLE, d.department DEPARTMENT_TABLE
FROM employees e LEFT JOIN departments d
ON e.department = d.department
WHERE d.department IS NULL ORDER BY 1;

-- FULL OUTER JOIN ===========================
-- seems outer join not work in mysql you can use cross join for a different scenario
SELECT DISTINCT employees.department EMPLOYEES_TABLE, departments.department DEPARTMENT_TABLE
FROM employees FULL OUTER JOIN departments
ON employees.department = departments.department;

-- UNION, UNION ALL, EXCEPT============================
-- UNION remove any duplicate when merge table1 into table2 table1 would be on the top
-- UNION ALL could not eliminate dplicate takes the data from the top1 and add the data with in the table 2
-- thinngs to remember column data_type must match 
SELECT department FROM employees UNION SELECT department FROM departments;

-- EXCEPT operator is going to remove the match column in the top1 table
-- except will not work in mysql. replace the except into NOT IN operator or MINUS in oracle
SELECT DISTINCT department FROM employees 
 except
SELECT department FROM departments;

-- CHALLENGES
-- generate a report that show the break down by department
-- column(department, total_number_of the employee work on each department) and there should be a total below 
-- department	count
-- automtive		23
-- clothing		2
-- total			100 this are the total of all employees
SELECT 'Total', COUNT(e1.employee_id) FROM employees e1 UNION ALL
SELECT department, 
COUNT(e2.employee_id) TOTAL_EMPLOYEES FROM employees e2 GROUP BY department ORDER BY 2;

-- ==== ANSWER same result
SELECT department, COUNT(*) FROM employees GROUP BY department
UNION ALL
SELECT 'TOTAL', COUNT(*) FROM employees;

-- 3==========CROSS JOIN==============================================================================================
SELECT * from employees a CROSS JOIN departments d;

-- challenges===
-- write aquery that returns the first name in the department the hiredate first in the country;
-- as well as the last employee hired 
-- first_name, department, hire_date, 	country
-- barby		clothing	2016-12-25	canada
-- norbie		firstaid				canada
SELECT first_name, department, hire_date, r.country
FROM employees e1 INNER JOIN regions r ON e1.region_id = r.region_id
WHERE hire_date = (SELECT MIN(hire_date) FROM employees e2)
UNION ALL
SELECT first_name, department, hire_date, r.country
FROM employees e1 INNER JOIN regions r ON e1.region_id = r.region_id
WHERE hire_date = (SELECT MAX(hire_date) FROM employees e2);

SELECT first_name, department, e.hire_date, r.country
FROM employees e, regions r WHERE e.region_id = r.region_id
AND e.hire_date = (SELECT MIN(hire_date) FROM employees e2) GROUP BY hire_date
UNION
SELECT first_name, department, e2.hire_date, r1.country
FROM employees e2, regions r1 WHERE e2.region_id = r1.region_id
AND e2.hire_date = (SELECT MAX(hire_date) FROM employees e3);
-- ==== CHALLENGES 
-- give report that can show how the spending for salary budget that we pay for our employee
-- computing sum of the salaries every 90 days starting with the hire_date of the first employee
-- all the way down to the last hire_date of the employee that hired
-- HINT;
-- SELECT first_name, hire_date, hire_date - 90 FROM employees
-- WHERE hire_date BETWEEN hire_date AND hire_date - 90;

SELECT hire_date, salary, (SELECT SUM(salary) FROM employees e2
WHERE e2.hire_date BETWEEN e1.hire_date - 90 AND e1.hire_date)
as spending_pattern
FROM employees e1
ORDER BY hire_date;

-- == VIEW VS INLINE VIES ======================
CREATE VIEW v_employees_information as 
SELECT first_name, email, e.department, salary, division, region, country
FROM employees e, departments d, regions r
WHERE e.department = d.department
AND e.region_id = r.region_id;

-- INLINE VIEWS 
-- this is the same with the subquery
SELECT * FROM (SELECT * FROM departments d);

-- ==assignment 1==================================================================================
-- Write a query that shows the student's name, the courses the student is taking and the professors that teach that course.
SELECT student_name, se.course_no, p.last_name
FROM students s
INNER JOIN student_enrollment se ON s.student_no = se.student_no
INNER JOIN teach t ON se.course_no = t.course_no
INNER JOIN proffessors p ON t.last_name = p.last_name ORDER BY student_name;

-- == question 2
-- If you execute the query from the previous answer, 
-- you'll notice the student_name and the course_no is being repeated. Why is this happening?

-- == question 3
-- In question 3 you discovered why there is repeating data. How can we eliminate this redundancy? 
-- Let's say we only care to see a single professor teaching a course and we don't care 
-- for all the other professors that teach the particular course. 
-- Write a query that will accomplish this so that every record is distinct.
-- HINT: Using the DISTINCT keyword will not help. :-)
SELECT student_name, course_no, min(last_name)
FROM (
	SELECT student_name, se.course_no, p.last_name FROM students s
	INNER JOIN student_enrollment se ON s.student_no = se.student_no
	INNER JOIN teach t ON se.course_no = t.course_no
	INNER JOIN proffessors p ON t.last_name = p.last_name
    ) a
GROUP BY student_name, course_no
ORDER BY student_name, course_no;

-- question 4=======
-- In the video lectures, we've been discussing the employees table and the departments table. 
-- Considering those tables, write a query that returns employees
-- whose salary is above average for their given department.
SELECT first_name FROM employees outer_emp
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department = outer_emp.department);

-- question 5 ====================
-- Write a query that returns ALL of the students as well as any courses they may or may not be taking.
SELECT s.student_no, student_name, course_no
FROM students s LEFT JOIN student_enrollment se ON s.student_no = se.student_no