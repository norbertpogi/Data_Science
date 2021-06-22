create or replace TRIGGER CUSTOMER_AFTER_UPDATE
AFTER UPDATE ON CUSTOMER FOR EACH ROW
DECLARE
    V_USERNAME VARCHAR(10);
BEGIN
    SELECT USER INTO V_USERNAME FROM DUAL;

    INSERT INTO AUDIT_TABLE VALUES('CUSTOMER', V_USERNAME, SYSDATE, 'insert operation row level');
END;