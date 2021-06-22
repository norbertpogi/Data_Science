DECLARE
    TYPE customer_type IS VARRAY(4) OF VARCHAR(100);
        --TABLE OF VARCHAR(100);
        --INDEX BY BINARY_INTEGER;
    CUSTOMER_TABLE CUSTOMER_TYPE:= customer_type();
    V_IDX NUMBER;
BEGIN

    CUSTOMER_TABLE.EXTEND (4); --initialize how many index in array
    -- using nexted should be sequencial order ONLY use this in index array not in nested table
    CUSTOMER_TABLE(1):= 'Norbert';
    CUSTOMER_TABLE(2):= 'Angelo';
    CUSTOMER_TABLE(3):= 'Neo';
  -- CUSTOMER_TABLE(6):= 'Yue'; -- throw error
   CUSTOMER_tABLE(4):= 'Kenji';
    
    --CUSTOMER_TABLE.DELETE(3); -- you cannot delete index in varray
    V_IDX:= customer_table.FIRST;
    -- dbms_output.put_line('name is: ' || V_IDX);
    dbms_output.put_line('FIRST FETCH name is: ' || CUSTOMER_TABLE(V_IDX));
    
    while V_IDX IS NOT NULL
        LOOP dbms_output.put_line('name is: ' || CUSTOMER_TABLE(V_IDX));
        v_idx:= CUSTOMER_TABLE.NEXT(V_IDX);
        END LOOP display_loop;
END;