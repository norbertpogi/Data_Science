CREATE OR REPLACE FUNCTION find_salescount (
    p_sales_date IN date
)   
RETURN NUMBER AS num_of_sales NUMBER:=0;

BEGIN
    SELECT COUNT(*) INTO num_of_sales FROM sales WHERE sales_date = p_sales_date;
    RETURN num_of_sales;
END find_salescount;