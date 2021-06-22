create or replace PROCEDURE FETCH_SALES_DYNAMIC(S_ORDERID IN NUMBER, S_CUST_ID IN NUMBER)
AS
    SALE_REC SALES%ROWTYPE;
    SQL_SMT VARCHAR2(500):= 'SELECT * FROM SALES WHERE 1 = 1';
BEGIN
    IF S_ORDERID IS NOT NULL THEN SQL_SMT:= SQL_SMT || ' AND ORDER_ID = ' || S_ORDERID; END IF;
    IF S_CUST_ID IS NOT NULL THEN SQL_SMT:= SQL_SMT || ' AND CUSTOMER_ID = ' || S_CUST_ID; END IF;

    dbms_output.put_line(SQL_SMT);

    EXECUTE IMMEDIATE SQL_SMT INTO SALE_REC;
        dbms_output.put_line(SALE_REC.SALES_DATE);
        dbms_output.put_line(SALE_REC.ORDER_ID);
        dbms_output.put_line(SALE_REC.PRODUCT_ID);
        dbms_output.put_line(SALE_REC.CUSTOMER_ID);
        dbms_output.put_line(SALE_REC.TOTAL_AMOUNT);
EXCEPTION
    WHEN NO_DATA_FOUND THEN dbms_output.put_line('No such record!');
    WHEN TOO_MANY_ROWS THEN dbms_output.put_line('You got more than 1 row!');
    WHEN OTHERS THEN dbms_output.put_line('An Error Occured!');
END;
SELECT * FROM SALES;
EXEC FETCH_SALES_DYNAMIC(23, 12);