-- nested array
DECLARE
    --table type and variable
    TYPE v_table_t IS TABLE OF VARCHAR2(30);
    v_table v_table_t := v_table_t();
    
BEGIN
    -- ADD 3 ENTRIES
    v_table.EXTEND(3);
    v_table(1) := 'A';
    v_table(2) := 'B';
    v_table(3) := 'C';
    
    DBMS_OUTPUT.PUT_LINE('........WHEN 3 ENTRIES ADDED.....');
    DBMS_OUTPUT.PUT_LINE('TABLE COUNT '||v_table.COUNT);
    DBMS_OUTPUT.PUT_LINE('TABLE first '||v_table.FIRST);
    DBMS_OUTPUT.PUT_LINE('TABLE LAST '||v_table.LAST);
    
    DBMS_OUTPUT.PUT_LINE('........SIMPLE LOOP.....');
    FOR COUNTER IN 1..v_table.LAST
    LOOP
        DBMS_OUTPUT.PUT_LINE(COUNTER ||' '||v_table(COUNTER));    
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('......FIRST AND NEXT.....');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_TABLE.FIRST;
        LOOP 
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER ||' '|| v_TABLE(V_COUNTER));
            V_COUNTER := V_TABLE.NEXT(V_COUNTER);
        END LOOP;
    END;
    

    DBMS_OUTPUT.PUT_LINE('......last AND PRIOR.....');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_TABLE.LAST;
        LOOP 
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER ||' '|| v_TABLE(V_COUNTER));
            V_COUNTER := V_TABLE.PRIOR(V_COUNTER);
        END LOOP;
    END;
    
    
END;
/

--- nested tables can be sparsed

-- nested array
DECLARE
    --table type and variable
    TYPE v_table_t IS TABLE OF VARCHAR2(30);
    v_table v_table_t := v_table_t();
    
BEGIN
    -- ADD 3 ENTRIES
    v_table.EXTEND(3);
    v_table(1) := 'A';
    v_table(2) := 'B';
    v_table(3) := 'C';
    
    DBMS_OUTPUT.PUT_LINE('........WHEN 3 ENTRIES ADDED.....');
    DBMS_OUTPUT.PUT_LINE('TABLE COUNT '||v_table.COUNT);
    DBMS_OUTPUT.PUT_LINE('TABLE first '||v_table.FIRST);
    DBMS_OUTPUT.PUT_LINE('TABLE LAST '||v_table.LAST);
 
    V_TABLE.DELETE(2);
    
    -- DBMS_OUTPUT.PUT_LINE('........SIMPLE LOOP.....');
    -- FOR COUNTER IN 1..v_table.LAST
    -- LOOP
    --     DBMS_OUTPUT.PUT_LINE(COUNTER ||' '||v_table(COUNTER));    
    -- END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('......FIRST AND NEXT.....');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_TABLE.FIRST;
        LOOP 
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER ||' '|| v_TABLE(V_COUNTER));
            V_COUNTER := V_TABLE.NEXT(V_COUNTER);
        END LOOP;
    END;
    

    DBMS_OUTPUT.PUT_LINE('......last AND PRIOR.....');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_TABLE.LAST;
        LOOP 
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER ||' '|| v_TABLE(V_COUNTER));
            V_COUNTER := V_TABLE.PRIOR(V_COUNTER);
        END LOOP;
    END;
    
    
END;
/