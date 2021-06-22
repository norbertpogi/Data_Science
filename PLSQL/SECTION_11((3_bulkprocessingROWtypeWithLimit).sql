create or replace PROCEDURE FETCH_SALES_CUR(S_DATE DATE)
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

            FOR INDX IN 1..L_SALES.COUNT
                LOOP
                    dbms_output.put_line(L_SALES(INDX).SALES_DATE);
                    dbms_output.put_line(L_SALES(INDX).ORDER_ID);
                    dbms_output.put_line(L_SALES(INDX).PRODUCT_ID);
                    dbms_output.put_line(L_SALES(INDX).SALESPERSON_ID);
                    dbms_output.put_line(L_SALES(INDX).QUANTITY);
                    dbms_output.put_line(L_SALES(INDX).SALES_AMOUNT);
                    dbms_output.put_line(L_SALES(INDX).TAX_AMOUNT);
                    dbms_output.put_line(L_SALES(INDX).TOTAL_AMOUNT);
                    dbms_output.put_line(L_SALES(INDX).CUSTOMER_ID);
                    dbms_output.put_line(L_SALES(INDX).UNIT_PRICE);
                END LOOP;
                EXIT WHEN SALES_CURSOR%NOTFOUND;
        END LOOP;
    CLOSE SALES_CURSOR;
END;
SELECT * FROM SALES;
EXEC FETCH_SALES_CUR(TO_DATE('09-FEB-2015', 'DD-MON-YYYY')); 