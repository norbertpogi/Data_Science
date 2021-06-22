--1) Create an Associative array of character datatype and index it by number and perform
        --the below operations.
        --? Insert 10 values into this array
        --? Delete 3rd element from the array
        --? Delete 7th element from the array
        --? Display the data from the array
        DECLARE
            TYPE record_type IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
            record_table record_type;
            rec_val_indx NUMBER;
        BEGIN
            record_table(1):= 'Norbert';
            record_table(2):= 'Angelo';
            record_table(3):= '3 Bert';
            record_table(4):= 'leo';
            record_table(5):= 'aaaaa';
            record_table(6):= 'bbbb';
            record_table(7):= '7 ccccc';
            record_table(8):= 'ddddd';
            record_table(9):= 'eeeee';
            record_table(10):= 'ffff';
            
            record_table.delete(3);
            record_table.delete(7);
            rec_val_indx:= record_table.FIRST;
            dbms_output.put_line('first index name ' || record_table(rec_val_indx));
            
            WHILE rec_val_indx IS NOT NULL
            LOOP dbms_output.put_line('name is: ' || record_table(rec_val_indx));
            rec_val_indx:= record_table.NEXT(rec_val_indx);
            END LOOP display_loop;
        END;
        
        
--2) Create a Nested Table array of character datatype and perform the below operations.
        --? Insert 10 values into this array
        --? Delete 3rd element from the array
        --? Delete 7th element from the array
        --? Display the data from the array
        DECLARE
            TYPE record_type IS TABLE OF VARCHAR2(100);
            record_table record_type:= record_type();
            rec_val_inx NUMBER;
        BEGIN
            record_table.EXTEND(10);
            record_table(1):= 'Norbert';
            record_table(2):= 'Angelo';
            record_table(3):= '3 Bert';
            record_table(4):= 'leo';
            record_table(5):= 'aaaaa';
            record_table(6):= 'bbbb';
            record_table(7):= '7 ccccc';
            record_table(8):= 'ddddd';
            record_table(9):= 'eeeee';
            record_table(10):= 'ffff';
            
            rec_val_inx:= record_table.FIRST;
            record_table.delete(3);
            record_table.delete(7);
            
            WHILE rec_val_inx IS NOT NULL
                LOOP dbms_output.put_line('name is: ' || record_table(rec_val_inx));
                rec_val_inx:= record_table.NEXT(rec_val_inx);
                END LOOP;
        END;
        
        
--3) Create a VARRAY array of character datatype which holds 10 values and perform the
        --below operations.
        --? Insert 10 values into this array
        --? Display the data from the array
        DECLARE
            TYPE record_type IS VARRAY(10) OF VARCHAR2(100);
            record_table record_type:= record_type();
            rec_val_inx NUMBER;
            index_array NUMBER;
        BEGIN
            record_table.EXTEND(10);
            record_table(1):= 'Norbert';
            record_table(2):= 'Angelo';
            record_table(3):= '3 Bert';
            record_table(4):= 'leo';
            record_table(5):= 'aaaaa';
            record_table(6):= 'bbbb';
            record_table(7):= '7 ccccc';
            record_table(8):= 'ddddd';
            record_table(9):= 'eeeee';
            record_table(10):= 'ffff';
            
            rec_val_inx:= record_table.FIRST;
            FOR rec_t IN record_table.FIRST..record_table.LAST
                LOOP dbms_output.put_line('name is: ' || record_table(rec_val_inx));
                rec_val_inx:= record_table.NEXT(rec_val_inx);
            END LOOP;
--           WHILE rec_val_inx IS NOT NULL
--            LOOP dbms_output.put_line('name is: ' || record_table(rec_val_inx));
--                rec_val_inx:= record_table.NEXT(rec_val_inx);
--            END LOOP;
        END;
        