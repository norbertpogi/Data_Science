CREATE OR REPLACE TRIGGER CUSTOMER_AFTER_ACTION
AFTER INSERT OR UPDATE OR DELETE ON CUSTOMER
DECLARE
    V_USERNAME VARCHAR2(10);
BEGIN
    SELECT USER INTO V_USERNAME FROM DUAL;
    
    IF INSERTING THEN
        INSERT INTO AUDIT_TABLE(TABLE_NAME, USERID, OPERATION_DATE, OPERATION)
        VALUES('CUSTOMER', V_USERNAME, SYSDATE, 'INSERT OPERATION');
    ELSIF UPDATING THEN
        INSERT INTO AUDIT_TABLE(TABLE_NAME, USERID, OPERATION_DATE, OPERATION)
        VALUES('CUSTOMER', V_USERNAME, SYSDATE, 'UPDATE OPERATION');
    ELSIF DELETING THEN
        INSERT INTO AUDIT_TABLE(TABLE_NAME, USERID, OPERATION_DATE, OPERATION)
        VALUES('CUSTOMER', V_USERNAME, SYSDATE, 'DELETE OPERATION');
    END IF;
END;