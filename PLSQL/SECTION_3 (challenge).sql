--Write a program to fetch data from table SALES for a given orderid and display the data.
--(Use %TYPE when declaring variables).
DECLARE    
    given_id number:= 1270;
    t_amount sales.total_amount%type;
    c_id sales.customer_id%type;
BEGIN
    SELECT total_amount, customer_id INTO t_amount, c_id FROM sales WHERE order_id = given_id ORDER BY TOTAL_AMOUNT FETCH FIRST 1 ROWS ONLY;
    dbms_output.put_line('total amount of sales are: ' || t_amount);
END;
select total_amount, customer_id FROM sales WHERE order_id = 1270 ORDER BY TOTAL_AMOUNT FETCH FIRST 1 ROWS ONLY;
select * from sales Where order_id = 1270;

--2. Write a program to insert data into SALES table.
DECLARE
    s_date sales.sales_date%type:=SYSDATE;
    o_id sales.order_id%type:=1991;
    
BEGIN
    INSERT INTO sales 
    VALUES(s_date, o_id, 100, 20, 11, 11, 11, 1100, 12000, 15000);
    dbms_output.put_line('Inserted successfully!!');
    select * from sales;
END;
--
--3) Write a program to update data in SALES table for a given orderid (Change order
--amount to 100).
DECLARE
    t_amount sales.total_amount%type:=1;
    amount sales.tax_amount%type:=4;
BEGIN
    UPDATE sales
    SET TOTAL_AMOUNT = t_amount WHERE tax_amount = amount;
    dbms_output.put_line('Successfully updated record!');
END;
select * from sales;
--4) Write a program to delete data from SALES table for a given orderid.
DECLARE
    o_id sales.order_id%type:=1991;
BEGIN
    DELETE FROM sales WHERE ORDER_ID = o_id;
    dbms_output.put_line('Successfully deleted record id: ' || o_id);
END;
