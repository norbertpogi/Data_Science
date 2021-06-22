CREATE OR REPLACE FUNCTION find_salescount (
    p_sales_date IN date
)   
RETURN NUMBER AS num_of_sales NUMBER:=0;

BEGIN
    SELECT COUNT(*) INTO num_of_sales FROM sales WHERE sales_date = p_sales_date;
    RETURN num_of_sales;
END find_salescount;

-- METHOD 1 ======================================
SELECT find_salescount(to_date('01-jan-2015', 'dd-mon-yyyy'))FROM DUAL;

-- METHOD 2 ========================================
DECLARE
    s_count NUMBER:=0;
BEGIN
    s_count:= find_salescount(to_date('01-jan-2015', 'dd-mon-yyyy'));
    dbms_output.put_line('sales date number record found: ' || s_count);
END;

--4) Write a function to display the number of rows in the SALES table for a given sales date.
CREATE OR REPLACE FUNCTION COUNT_SALES (
    p_sales_date IN OUT date
    )
RETURN NUMBER AS num_of_sales NUMBER:=0;
BEGIN
    SELECT  COUNT(*) INTO num_of_sales FROM sales WHERE date = p_sales_date;
    RETURN num_of_sales;
END COUNT_SALES;