 --  method1 ==========================================================
 -- order is required
DECLARE
    c_id customer.customer_id%type:=0003;
    t_count NUMBER;
BEGIN
    ADD_CUSTOMER (c_id,'ANGELO', 'BAUTISTA', 'L', '18 FISHERIES ST',NULL, 'QC', 'PH', SYSDATE,'NORTH', t_count);
    dbms_output.put_line('customer id: ' || c_id);
    dbms_output.put_line('total count: ' || t_count);
END;

-- METHOD 2 ===================
 -- order is not required
DECLARE
    com_id customer.customer_id%type:=0004;
    record_count NUMBER;
BEGIN
    add_customer (
        c_fname         => 'Norbert',
        c_lname         => 'Bautista',
        c_mname         => 'L',
        c_add1          => 'Luna Isabela',
        c_add2          => 'Vasra QC',
        c_city          => 'QC',
        c_country       => 'PH',
        c_date_added    => SYSDATE,
        c_region        => 'NORTH',
        c_id            => com_id,
        t_count         => record_count
    );
    dbms_output.put_line('customer id: ' || com_id);
    dbms_output.put_line('total count: ' || record_count);
END;