--2) Write a procedure which does the following operations
--? Fetch data from table SALES for a given parameter orderid and display the data.
--? Return the number of rows(using OUT parameter) in the SALES table for that
--sales date (get sales date from the above operation)
DECLARE
    o_id NUMBER:= 1270;
    t_rows_num NUMBER:= 0;
BEGIN
    GET_SALES(o_id, t_rows_num);
    dbms_output.put_line('oder id: ' || o_id);
    dbms_output.put_line('rows num: ' || t_rows_num);
END;

-- ===========
ALTER DATABASE OPEN;