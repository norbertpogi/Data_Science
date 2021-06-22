--I. Write the exceptions block for all the below procedures/functions which you have
    --written in the Exercise #3.
    --1) Write a procedure to fetch data from table SALES for a given parameter orderid and
         --display the data.
        create or replace PROCEDURE EX_SALES (
            param_o_id IN NUMBER
         ) AS
            s_date sales.sales_date%type;
            o_id sales.order_id%type;
            p_id sales.product_id%type;
            c_id sales.customer_id%type;
            t_rows_num NUMBER:= 0;
            sales_id_exception EXCEPTION;
            sales_row_num NUMBER:= 0;

        BEGIN
         IF param_o_id <= 0 THEN RAISE sales_id_exception;
         END IF;
            SELECT sales_date, order_id, product_id, customer_id INTO s_date, o_id, p_id, c_id FROM sales WHERE order_id IN (param_o_id);
            dbms_output.put_line('sales date: ' || s_date);
            dbms_output.put_line('order id: ' || o_id);
            dbms_output.put_line('product id: ' || p_id);
            dbms_output.put_line('customer id: ' || c_id);
            
            SELECT COUNT(*) INTO t_rows_num FROM sales WHERE sales_date IN (s_date);
            dbms_output.put_line('rows number: ' || t_rows_num);
            
            sales_row_num:= GET_SALES_ROW(s_date);
            dbms_output.put_line('rows number in date: ' || sales_row_num);
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN dbms_output.put_line('No data found');
            WHEN TOO_MANY_ROWS  THEN dbms_output.put_line('too many rows data');
            WHEN sales_id_exception THEN dbms_output.put_line('order id should not be greater than 0');
            WHEN OTHERS THEN dbms_output.put_line('exception has been thrown');
            
    END EX_SALES;
    --2) Write a procedure which does the following operations
         --? Fetch data from table SALES for a given parameter orderid and display the
         --data.
         --? Return the number of rows(using OUT parameter) in the SALES table for that
         --sales date (get sales date from the about operation)
        -- see answer in the excercise 1
         
    --3) Write a function which accepts 2 numbers N1 and N2 and returns the power of
         --N1 to N2. (Example: If I pass values 10 and 3, the output should be 1000)
        CREATE OR REPLACE FUNCTION MY_POWER(
            n1 IN OUT NUMBER,
            n2 IN OUT NUMBER
        ) RETURN NUMBER AS get_power NUMBER:= 1;
        BEGIN
            FOR lctnrl IN get_power..n2
            LOOP get_power:= get_power * n1;
            END LOOP;
        RETURN get_power;
        
        END MY_POWER;
                 
         
         
    --4) Write a function to display the number of rows in the SALES table for a given sales
         --date.
         CREATE OR REPLACE FUNCTION GET_SALES_ROW (
            s_date DATE
         ) RETURN NUMBER AS get_rows NUMBER:= 0;
            
         BEGIN
            SELECT COUNT(*) INTO get_rows FROM sales WHERE sales_date IN (s_date);
         RETURN get_rows;
         END GET_SALES_ROW;
         
--         call this function 
--         see answer in exercise 1
         EXECUTE EX_SALES(1269);
         
--II. Write a user defined exception for function 3 which displays an exception saying “Invalid
--Number” or “Number must be less than 100”, if it meets the below conditions
--? If N1 or N2 is null or zero
--? If N1 or N2 is greater than 100.
        CREATE OR REPLACE FUNCTION MY_POWER_V1 (
            N1 IN NUMBER, 
            N2 IN NUMBER
        )
        RETURN NUMBER AS
            POWER_VALUE NUMBER:= 1;
            EXCEP_ZERO EXCEPTION;
            EXCEP_GREAT_100 EXCEPTION;
            
            BEGIN
                IF (N1 IS NULL OR N1 = 0 OR N2 IS NULL OR N2 = 0) THEN
                 RAISE EXCEP_ZERO;
                END IF;
                IF N1 > 100 OR N2 > 100 THEN
                 RAISE EXCEP_GREAT_100;
                END IF;
            
                FOR LCNTR IN 1..N2
                LOOP
                 POWER_VALUE := POWER_VALUE * N1;
                END LOOP;
                
            RETURN POWER_VALUE;
            
            EXCEPTION
             WHEN EXCEP_ZERO THEN
             dbms_output.put_line('N1 or N2 is null or zero!');
             RETURN 0;
             WHEN EXCEP_GREAT_100 THEN
             dbms_output.put_line('N1 OR N2 is greater than 100!');
             RETURN 0;
             WHEN others THEN
             dbms_output.put_line('Error!');
        END;

