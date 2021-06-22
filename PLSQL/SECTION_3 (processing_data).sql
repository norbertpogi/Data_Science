DECLARE
    num1 number:=20;
BEGIN
    IF num1 < 30 THEN 
        FOR num1 IN 10..20
        LOOP dbms_output.put_line('output: ' || num1);
        END LOOP;
    END IF;
END;

-- READING DATA=============================================
DECLARE
    c_id customer.customer_id%type;
    f_name customer.first_name%type;
    reg customer.region%type:= 'SOUTH';
BEGIN
    SELECT customer_id, first_name INTO c_id, f_name FROM customer WHERE region IN (reg);
    dbms_output.put_line('customer id is: ' || c_id);
    dbms_output.put_line('first name is: ' || f_name);
END;

-- INSERT DATA=====================
DECLARE
    prime_num number:=7;
    f_name customer.first_name%type:= 'Norbert5';
    l_name customer.last_name%type:= 'Bautista5';
    m_name customer.middle_name%type:='L';
--    add1 customer.address_line1%type:="18 fisheries st";
--    add2 customer.address_line2%type:=NULL;
--    city customer.city%type:="QC";
--    country customer.country%type:="PH";
--    c_date customer.date_added%type:=SYSDATE;
--    region customer.region%type:="North";
    
BEGIN
    -- INSERT INTO customer(customer_id, first_name,last_name,middle_name,address_line1,address_line2, city,country,date_added,region)
    INSERT INTO customer
    VALUES(prime_num, f_name, l_name, m_name, 'filjka', NULL, 'QC', 'PH', SYSDATE, 'NORTH');
    COMMIT;
    dbms_output.put_line('data has been successfully inserted');
END;
/

SELECT * FROM customer