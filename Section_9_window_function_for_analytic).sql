-- 1.
SELECT first_name, department, 
COUNT(*) OVER(PARTITION BY department) dept_count,
 -- (SELECT COUNT(*) FROM employees e1 WHERE e1.department = e2.department) as COUNT
region_id,
COUNT(*) OVER(PARTITION BY department) name_count
 FROM employees e;
 
 -- 1. == ORDERING DATA IN WINDOW FRAMES ============================================
 SELECT first_name, hire_date, salary,
  SUM(salary) OVER(ORDER BY hire_date)
	AS running_total_salaries
 FROM employees;
 -- =============
  SELECT first_name, hire_date, department, salary,
  SUM(salary) OVER(PARTITION BY department ORDER BY hire_date)
	AS running_total_salaries
 FROM employees;
-- =============
  SELECT first_name, hire_date, department, salary,
  SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
	AS running_total_salaries
 FROM employees;

-- 3. RANK, FIRST VALUE AND NTILE FUNCTIONS ======================================================
SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees;

-- ==== RANK==========
-- rank from 1 to the last number
SELECT * FROM (
	SELECT first_name, email, department, salary,
	RANK() OVER(PARTITION BY department ORDER BY salary DESC) ranking
	FROM employees) a 
WHERE ranking = 8;

-- ====== NTILE ===
-- this will rank by it depends
SELECT first_name, email, department, salary,
NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC) ranking
FROM employees;

-- == FIRST_VALUE
-- let see example below indicates first_value means select salary by each department
-- also this similar with the MAX function
SELECT first_name, email, department, salary,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) 'first_value'
FROM employees;

-- == NTH_VALUE by 5
SELECT first_name, email, department, salary,
NTH_VALUE (salary, 5) OVER(PARTITION BY department ORDER BY first_name DESC) 'nth_value'
FROM employees;

-- ---- LEAD and LAG========================================================================================
-- lead will get the next salary from the salary column
-- LAG is the opposite means this function will get the previous record
SELECT first_name, last_name, salary,
LEAD(salary) OVER() next_salary,
LAG(salary) OVER() previous_salary
FROM employees;
-- =================================
SELECT first_name, last_name, salary,
LEAD(salary) OVER(ORDER BY salary DESC) next_highest_salary,
LAG(salary) OVER(ORDER BY salary DESC) next_previous_salary
FROM employees;

-- ===== ROLLUPs and CUBES=========================================================================
-- this will help to flexiblity analyzing data and they work with GROUP BY CLOSE
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS (continent, country, city); -- group sets is not work with mysql use union all instead
-- ==========
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY GROUPING SETS (continent, country, city, ()); -- () this function will group by all 
-- =======================
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY ROLLUP(continent, country, city); -- ROLLUP this is a similary with GROUPING SETS

-- =============================
SELECT continent, country, city, SUM(units_sold)
FROM sales
GROUP BY CUBE(continent, country, city); -- CUBE it can group by in one column