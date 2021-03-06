create or replace FUNCTION FETCH_SALES_TABLE (S_ORDERID NUMBER)
RETURN SALES_TABLE
PIPELINED -- SAVING MEMORY AND ALLOWING SUBSEQUENT PROCESSING TO START BEFORE ALL THE ROWS GEENRATED
    IS
    L_TAB SALES_TABLE:= SALES_TABLE();
BEGIN
    FOR C IN (SELECT * FROM SALES WHERE ORDER_ID = S_ORDERID)

    LOOP
        PIPE ROW(SALES_ROW(C.SALES_DATE, C.ORDER_ID,C.PRODUCT_ID,C.CUSTOMER_ID,C.TOTAL_AMOUNT));
--        L_TAB.EXTEND;
--        L_TAB(L_TAB.LAST):= SALES_ROW(C.SALES_DATE, C.ORDER_ID,C.PRODUCT_ID,C.CUSTOMER_ID,C.TOTAL_AMOUNT);
    END LOOP;
END;
SELECT * FROM SALES;
SELECT * FROM TABLE (FETCH_SALES_TABLE(1269));