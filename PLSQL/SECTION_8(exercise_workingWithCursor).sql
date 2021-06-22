--Write a procedure to fetch data from table SALES for a given parameter sales date and
        --display all the data(Hint: use Explicit cursors and ROWTYPE)
  --  CREATE PROCEDURE EX7_FETCH_SALES(s_date DATE);
CREATE OR REPLACE PROCEDURE FETCH_SALES_CUR (S_DATE DATE)
AS
 CURSOR SALE_CURSOR
 IS
    SELECT SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID, SALESPERSON_ID, QUANTITY,UNIT_PRICE, SALES_AMOUNT, TAX_AMOUNT, TOTAL_AMOUNT
        FROM SALES WHERE SALES_DATE = S_DATE;
SALE_REC SALES%ROWTYPE;

BEGIN
 OPEN SALE_CURSOR;

 LOOP
 FETCH SALE_CURSOR INTO SALE_REC;
 EXIT WHEN SALE_CURSOR%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE (SALE_REC.SALES_DATE);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.ORDER_ID);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.PRODUCT_ID);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.CUSTOMER_ID);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.SALESPERSON_ID);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.QUANTITY);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.UNIT_PRICE);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.SALES_AMOUNT);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.TAX_AMOUNT);
     DBMS_OUTPUT.PUT_LINE (SALE_REC.TOTAL_AMOUNT);
 END LOOP;
 CLOSE SALE_CURSOR;
END;
EXEC FETCH_SALES_CUR (TO_DATE('01-JAN-2015','DD-MON-YYYY'));

--2) Write a procedure to fetch data from table SALES for a given parameter sales date and
        --display all the data(Hint: use Cursor FOR loop)
    CREATE OR REPLACE PROCEDURE FETCH_SALES_CURLOOP (S_DATE DATE)
        AS
        BEGIN
            FOR SALE_REC IN (SELECT SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID, SALESPERSON_ID, QUANTITY,
                UNIT_PRICE, SALES_AMOUNT, TAX_AMOUNT, TOTAL_AMOUNT FROM SALES WHERE SALES_DATE = S_DATE)
            LOOP
             DBMS_OUTPUT.PUT_LINE (SALE_REC.SALES_DATE);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.ORDER_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.PRODUCT_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.CUSTOMER_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.SALESPERSON_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.QUANTITY);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.UNIT_PRICE);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.SALES_AMOUNT);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.TAX_AMOUNT);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.TOTAL_AMOUNT);
            END LOOP;
        END;
EXEC FETCH_SALES_CURLOOP (TO_DATE('01-JAN-2015','DD-MON-YYYY'));
        
        
--3) Write a procedure to fetch data from table SALES for a given parameter sales date and
        --pass that cursor to another program.
        --Write another procedure which calls the above procedure and displays the data.
    CREATE OR REPLACE PROCEDURE SEND_SALES_REF (S_DATE DATE, SALES_CUR OUT SYS_REFCURSOR)
        AS
        BEGIN
            OPEN SALES_CUR 
                FOR SELECT SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID, SALESPERSON_ID, QUANTITY, UNIT_PRICE, SALES_AMOUNT, TAX_AMOUNT, TOTAL_AMOUNT
                    FROM SALES WHERE SALES_DATE = S_DATE;
        END;
        
    CREATE OR REPLACE PROCEDURE GET_SALES_REF (S_DATE DATE)
    AS
    S_REC_CURSER SYS_REFCURSOR;
    SALE_REC SALES%ROWTYPE;
    BEGIN
        SEND_SALES_REF (S_DATE, S_REC_CURSER);
         LOOP
             FETCH S_REC_CURSER INTO SALE_REC;
             EXIT WHEN S_REC_CURSER%NOTFOUND;
             DBMS_OUTPUT.PUT_LINE (SALE_REC.SALES_DATE);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.ORDER_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.PRODUCT_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.CUSTOMER_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.SALESPERSON_ID);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.QUANTITY);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.UNIT_PRICE);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.SALES_AMOUNT);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.TAX_AMOUNT);
             DBMS_OUTPUT.PUT_LINE (SALE_REC.TOTAL_AMOUNT);
         END LOOP;

 CLOSE S_REC_CURSER;

END;
    EXEC GET_SALES_REF (TO_DATE('01-JAN-2015','DD-MON-YYYY'));