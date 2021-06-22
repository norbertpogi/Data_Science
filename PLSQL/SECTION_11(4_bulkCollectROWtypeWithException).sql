create or replace PROCEDURE INSERT_SALES_CUR(S_DATE DATE)
AS
    CURSOR SALES_CURSOR
    IS
    SELECT SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID, SALESPERSON_ID,QUANTITY, UNIT_PRICE, SALES_AMOUNT, TAX_AMOUNT, TOTAL_AMOUNT
        FROM SALES WHERE SALES_DATE = S_DATE;
    TYPE L_SALES_TABLE IS TABLE OF SALES%ROWTYPE;
    L_SALES L_SALES_TABLE;

BEGIN
    OPEN SALES_CURSOR;
        LOOP FETCH SALES_CURSOR BULK COLLECT INTO L_SALES LIMIT 100;

            FORALL INDX IN 1..L_SALES.COUNT SAVE EXCEPTIONS --saving to execption
                INSERT INTO SALES_2 VALUES(L_SALES(INDX));
                EXIT WHEN SALES_CURSOR%NOTFOUND;
        END LOOP;
    CLOSE SALES_CURSOR;
    EXCEPTION
    WHEN OTHERS THEN 
        IF SQLCODE= -24381 THEN 
            FOR INDX IN 1..SQL%BULD_EXCEPTIONS.COUNT
            LOOP dbms_output.put_line(SQL%BULD_EXCEPTIONS(INDX).ERROR_INDEX);
                 dbms_output.put_line(SQLERRM(-SQL%BULD_EXCEPTIONS(INDX).ERROR_CDOE));
END;
SELECT * FROM SALES_2;
ALTER TABLE SALES_2 ADD CONSTRAINT SALES_2_PK PRIMARY KEY(PRODUCT_ID);
TRUNCATE TABLE SALES_2;
select * from sales;
-- EXEC INSERT_SALES_CUR(TO_DATE('09-FEB-2015', 'DD-MON-YYYY')); 
EXEC INSERT_SALES_CUR(100);