create or replace PROCEDURE UPDATE_TAX (TAX_RATE IN NUMBER)
AS 
    L_ELIGIBLE BOOLEAN;
    TYPE ORDERID_TYPE IS TABLE OF SALES.ORDER_ID%TYPE INDEX BY PLS_INTEGER; -- ASSOCIATE ARRAY
    L_ORDER_IDS ORDERID_TYPE;
BEGIN
    SELECT DISTINCT ORDER_ID BULK COLLECT INTO L_ORDER_IDS FROM SALES;

    FORALL INDX IN 1..L_ORDER_IDS.COUNT
        UPDATE SALES S
            SET S.TAX_AMOUNT = S.TOTAL_AMOUNT * TAX_RATE
        WHERE S.ORDER_ID = L_ORDER_IDS(INDX);
END;
EXECUTE UPDATE_TAX(2000);
select * from sales;

-- == MORE ADVANCE=========
CREATE PROCEDURE CHECK_ELIGIBLE(P_ORDERID NUMBER, L_ELIGIBLE OUT BOOLEAN)
AS
    L_TOTAL NUMBER;
BEGIN
    SELECT SUM(TOTAL_AMOUNT) INTO L_TOTAL FROM SALES WHERE ORDER_ID IN (P_ORDERID);
    
    IF L_TOTAL >= 1000 THEN L_ELIGIBLE:= TRUE; END IF;
END;

-- ===== CALLILNG CHECK_ELIGIBLE PROCEDURE== 
CREATE PROCEDURE CHECK_ELIGIBLE(P_ORDERID NUMBER, L_ELIGIBLE OUT BOOLEAN)
AS
    L_TOTAL NUMBER;
BEGIN
    SELECT SUM(TOTAL_AMOUNT) INTO L_TOTAL FROM SALES WHERE ORDER_ID IN (P_ORDERID);
    
    IF L_TOTAL >= 1000 THEN L_ELIGIBLE:= TRUE; END IF;
END;

create or replace PROCEDURE UPDATE_TAX (TAX_RATE IN NUMBER)
AS 
    L_ELIGIBLE BOOLEAN;
    TYPE ORDERID_TYPE IS TABLE OF SALES.ORDER_ID%TYPE INDEX BY PLS_INTEGER; -- ASSOCIATE ARRAY
    L_ORDER_IDS ORDERID_TYPE;
    L_ELIGIBLE_ORDERS ORDERID_TYPE;
BEGIN
    SELECT DISTINCT ORDER_ID BULK COLLECT INTO L_ORDER_IDS FROM SALES;
    DBMS_OUTPUT.PUT_LINE('COUNT ID IS: ' || L_ORDER_IDS.COUNT);

    FOR indx IN 1..L_ORDER_IDS.COUNT
        LOOP CHECK_ELIGIBLE(L_ORDER_IDS(indx), L_ELIGIBLE);
            IF L_ELIGIBLE
                THEN L_ELIGIBLE_ORDERS(L_ELIGIBLE_ORDERS.COUNT + 1):= L_ORDER_IDS(indx);
            END IF;
        END LOOP;
    
    FORALL INDX IN 1..L_ORDER_IDS.COUNT
        UPDATE SALES S
            SET S.TAX_AMOUNT = S.TOTAL_AMOUNT * TAX_RATE
        WHERE S.ORDER_ID = L_ORDER_IDS(INDX);
END;