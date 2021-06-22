CREATE OR REPLACE PACKAGE BODY CUSTOMER_PACKAGE
AS
    PROCEDURE ADD_CUSTOMER
(
    c_id            IN OUT NUMBER,
    c_fname         IN VARCHAR2,
    c_lname         IN VARCHAR2,
    c_mname         IN VARCHAR2,
    c_add1          IN VARCHAR2,
    c_add2          IN VARCHAR2,
    c_city          IN VARCHAR2,
    c_country       IN VARCHAR2,
    c_date_added    IN DATE,
    c_region        IN VARCHAR2,
    t_count         OUT NUMBER
) AS 
BEGIN
    INSERT INTO customer(customer_id, first_name, last_name, middle_name, address_line1, address_line2, city, country, date_added, region)
        VALUES (c_id, c_fname, c_lname, c_mname, c_add1, c_add2, c_city, c_country, c_date_added, c_region);
        COMMIT;
        dbms_output.put_line('Data Successfully inserted');
        
        -- SELECT COUNT(1), customer_id INTO total_count, c_id FROM customer;
        SELECT COUNT(customer_id), customer_id INTO c_id, t_count FROM customer GROUP BY customer_id FETCH FIRST 1 ROWS ONLY;

END ADD_CUSTOMER;
PROCEDURE FETCH_SALES (
    S_ORDERID IN NUMBER, 
    L_TOTALROWS OUT NUMBER
)
AS
    L_DATE SALES.SALES_DATE%TYPE;
    L_ORDERID SALES.ORDER_ID%TYPE;
    L_PRODUCTID SALES.PRODUCT_ID%TYPE;
    L_CUSTOMERID SALES.CUSTOMER_ID%TYPE;
    L_SALESPERSONID SALES.SALESPERSON_ID%TYPE;
    L_QUANTITY SALES.QUANTITY%TYPE;
    L_UNITPRICE SALES.UNIT_PRICE%TYPE;
    L_SALESAMOUNT SALES.SALES_AMOUNT%TYPE;
    L_TAXAMOUNT SALES.TAX_AMOUNT%TYPE;
    L_TOTALAMOUNT SALES.TOTAL_AMOUNT%TYPE;
BEGIN
    SELECT SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID, SALESPERSON_ID, QUANTITY,
    UNIT_PRICE, SALES_AMOUNT, TAX_AMOUNT, TOTAL_AMOUNT
    INTO
    L_DATE, L_ORDERID, L_PRODUCTID, L_CUSTOMERID, L_SALESPERSONID, L_QUANTITY, L_UNITPRICE,
    L_SALESAMOUNT, L_TAXAMOUNT, L_TOTALAMOUNT
    FROM SALES
    WHERE ORDER_ID = S_ORDERID;
     DBMS_OUTPUT.PUT_LINE (L_DATE);
     DBMS_OUTPUT.PUT_LINE (L_ORDERID);
     DBMS_OUTPUT.PUT_LINE (L_PRODUCTID);
     DBMS_OUTPUT.PUT_LINE (L_CUSTOMERID);
     DBMS_OUTPUT.PUT_LINE (L_SALESPERSONID);
     DBMS_OUTPUT.PUT_LINE (L_QUANTITY);
     DBMS_OUTPUT.PUT_LINE (L_UNITPRICE);
     DBMS_OUTPUT.PUT_LINE (L_SALESAMOUNT);
     DBMS_OUTPUT.PUT_LINE (L_TAXAMOUNT);
     DBMS_OUTPUT.PUT_LINE (L_TOTALAMOUNT);

    SELECT COUNT(1) INTO L_TOTALROWS FROM SALES
    WHERE SALES_DATE = L_DATE;
END FETCH_SALES;
PROCEDURE GET_CUSTOMER (
    c_id IN OUT NUMBER
)AS 
    c_name customer.first_name%type;
    c_cntry customer.country%type;
    c_cstomer_id_exeption EXCEPTION;
BEGIN
    IF c_id <= 0 THEN RAISE c_cstomer_id_exeption;
    END IF;

    SELECT first_name, country INTO c_name, c_cntry FROM customer WHERE customer_id = c_id;
    dbms_output.put_line('Name: ' || c_name);
    dbms_output.put_line('country ' || c_cntry);
EXCEPTION
    WHEN NO_DATA_FOUND THEN dbms_output.put_line('No Data Found');
    WHEN c_cstomer_id_exeption THEN dbms_output.put_line('Id must be greater than zero!');
    WHEN TOO_MANY_ROWS THEN dbms_output.put_line('Too many rows');
    WHEN VALUE_ERROR THEN dbms_output.put_line('invalid parameter');
    WHEN OTHERS THEN dbms_output.put_line('an error has been thrown');
END GET_CUSTOMER;
PROCEDURE GET_SALES(
    o_id IN OUT NUMBER,
    t_rows_num IN OUT NUMBER
) AS
    s_date sales.sales_date%type;
    s_o_id sales.order_id%type;
    p_id sales.product_id%type;
    c_id sales.customer_id%type;
    t_amount sales.total_amount%type;
    n1 NUMBER:= 0;
    n2 NUMBER:= 3;
    my_power NUMBER:= 0;
BEGIN
    SELECT sales_date, order_id, product_id, customer_id, total_amount INTO 
        s_date, s_o_id, p_id, c_id, t_amount FROM sales WHERE
            order_id IN (o_id) FETCH FIRST 1 ROWS ONLY;
            
 n1:= t_amount;
    
    SELECT COUNT(*) INTO t_rows_num FROM sales WHERE sales_date IN (s_date);
    
    my_power:= THE_POWER(n1, n2);
    dbms_output.put_line('the power of ' || n1 || ' is: ' || my_power);
    
END GET_SALES;
FUNCTION find_salescount (
    p_sales_date IN date
)   
RETURN NUMBER AS num_of_sales NUMBER:=0;

BEGIN
    SELECT COUNT(*) INTO num_of_sales FROM sales WHERE sales_date = p_sales_date;
    RETURN num_of_sales;
END find_salescount;
FUNCTION get_account(
    n1 IN NUMBER,
    n2 IN NUMBER

) RETURN NUMBER AS get_total NUMBER:= 1;
BEGIN
    FOR lctnrl IN get_total..n2
        LOOP get_total:=get_total * n1;
    END LOOP;
    RETURN get_total;
END get_account;
FUNCTION MY_POWER(
    n1 IN NUMBER,
    n2 IN NUMBER
) RETURN NUMBER AS 
    get_power NUMBER:= 1;
    power_test_exception EXCEPTION;
BEGIN
   -- IF n1 IS NULL OR n2 IS NULL THEN RAISE power_exception;
    IF n1 = 10 THEN RAISE power_test_exception;
    END IF;
    
    FOR lctnrl IN get_power..n2
    LOOP get_power:= get_power * n1;
    END LOOP;

RETURN get_power;
EXCEPTION
    WHEN power_test_exception THEN dbms_output.put_line('number cannot be null');
END MY_POWER;
END CUSTOMER_PACKAGE;