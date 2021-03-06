create or replace PROCEDURE UPDATE_TAX (TAX_RATE IN NUMBER)
AS 
    L_ELIGIBLE BOOLEAN;
    TYPE ORDERID_TYPE IS TABLE OF SALES.ORDER_ID%TYPE INDEX BY PLS_INTEGER; -- ASSOCIATE ARRAY
    L_ORDER_IDS ORDERID_TYPE;
    L_ELIGIBLE_ORDERS ORDERID_TYPE;
    CURSOR SALES_CURSOR IS SELECT DISTINCT ORDER_ID FROM SALES;
BEGIN
    OPEN SALES_CURSOR;
    
        LOOP FETCH SALES_CURSOR 
            BULK COLLECT INTO L_ORDER_IDS LIMIT 100;
    
            FOR indx IN 1..L_ORDER_IDS.COUNT
                LOOP CHECK_ELIGIBLE(L_ORDER_IDS(indx), L_ELIGIBLE);
                    IF L_ELIGIBLE 
                        THEN L_ELIGIBLE_ORDERS(L_ELIGIBLE_ORDERS.COUNT + 1):= L_ORDER_IDS(indx);
                    END IF;
                END LOOP;
        EXIT WHEN L_ORDER_IDS.COUNT = 0;
        END LOOP;
    
    FORALL INDX IN 1..L_ORDER_IDS.COUNT
        UPDATE SALES S
            SET S.TAX_AMOUNT = S.TOTAL_AMOUNT * TAX_RATE
        WHERE S.ORDER_ID = L_ORDER_IDS(INDX);
        COMMIT;
    
    CLOSE SALES_CURSOR;
END;