--- IN MEMEORY TABLE OPTIONS
DECLARE
    
        -- index-by type and variable / Associative array
        TYPE v_index_by_t IS TABLE OF VARCHAR2(30)
            INDEX BY BINARY_INTEGER;
        v_ib v_index_by_t;
        
        -- table type and variable
        TYPE v_table_t IS TABLE OF VARCHAR2(30);
        v_table v_table_t := v_table_t();
        
        -- varray type and variable
        TYPE v_varry_t IS VARRAY(4) OF VARCHAR2(20);
        v_array v_varry_t := v_varry_t();
        
BEGIN
    DBMS_OUTPUT.PUT_LINE('........WHEN EMPTY ......');
    DBMS_OUTPUT.PUT_LINE('Index by Count '|| v_ib.COUNT);
    DBMS_OUTPUT.PUT_LINE('Table Count '|| v_table.COUNT);
    DBMS_OUTPUT.PUT_LINE('VARRY Count '|| v_array.COUNT);
    
    DBMS_OUTPUT.PUT_LINE('Index by first '|| v_ib.FIRST);
    DBMS_OUTPUT.PUT_LINE('Table first '|| v_table.FIRST);
    DBMS_OUTPUT.PUT_LINE('VARRY first '|| v_array.FIRST);
    
    DBMS_OUTPUT.PUT_LINE('Index by last '|| v_ib.LAST);
    DBMS_OUTPUT.PUT_LINE('Table last '|| v_table.LAST);
    DBMS_OUTPUT.PUT_LINE('VARRY last '|| v_array.LAST);
    
END;
/

-- INDEX BY 
DECLARE 

    TYPE v_index_by_t IS TABLE OF VARCHAR2(30)
        INDEX BY BINARY_INTEGER;
    v_ib v_index_by_t;
BEGIN
    -- add 3 entries
    v_ib(1) := 'A';
    v_ib(2) := 'B';
    v_ib(3) := 'C';
 
    DBMS_OUTPUT.PUT_LINE('........WHEN Entries added ......');
    DBMS_OUTPUT.PUT_LINE('Index by Count '|| v_ib.COUNT);
    DBMS_OUTPUT.PUT_LINE('Index by first '|| v_ib.FIRST);
    DBMS_OUTPUT.PUT_LINE('Index by last '|| v_ib.LAST);
 
    DBMS_OUTPUT.PUT_LINE('.......Simple For loop ......');
    FOR counter IN 1..v_ib.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(counter ||' '|| v_ib(counter));
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('... frst adn next...');
    DECLARE
        v_counter BINARY_INTEGER;
    BEGIN
        v_counter := v_ib.FIRST;
        LOOP
            EXIT WHEN v_counter IS NULL;
            DBMS_OUTPUT.PUT_LINE(v_counter ||' '|| v_ib(v_counter));
            v_counter := v_ib.NEXT(v_counter);
        END LOOP;
    END;
 
    DBMS_OUTPUT.PUT_LINE('... last and prior...');
    DECLARE
        v_counter BINARY_INTEGER;
    BEGIN
        v_counter := v_ib.LAST;
        LOOP
            EXIT WHEN v_counter IS NULL;
            DBMS_OUTPUT.PUT_LINE(v_counter ||' '|| v_ib(v_counter));
            v_counter := v_ib.PRIOR(v_counter);
        END LOOP;
    END;
 
 END;
/


-- When delete one entry case error in simple loop


-- INDEX BY 
DECLARE 

    TYPE v_index_by_t IS TABLE OF VARCHAR2(30)
        INDEX BY BINARY_INTEGER;
    v_ib v_index_by_t;
BEGIN
    -- add 3 entries
    v_ib(1) := 'A';
    v_ib(2) := 'B';
    v_ib(3) := 'C';
 
    DBMS_OUTPUT.PUT_LINE('........WHEN Entries added ......');
    DBMS_OUTPUT.PUT_LINE('Index by Count '|| v_ib.COUNT);
    DBMS_OUTPUT.PUT_LINE('Index by first '|| v_ib.FIRST);
    DBMS_OUTPUT.PUT_LINE('Index by last '|| v_ib.LAST);
 
    v_ib.DELETE(2);
        
    DBMS_OUTPUT.PUT_LINE('... frst and next...');
    DECLARE
        v_counter BINARY_INTEGER;
    BEGIN
        v_counter := v_ib.FIRST;
        LOOP
            EXIT WHEN v_counter IS NULL;
            DBMS_OUTPUT.PUT_LINE(v_counter ||' '|| v_ib(v_counter));
            v_counter := v_ib.NEXT(v_counter);
        END LOOP;
    END;
 
    DBMS_OUTPUT.PUT_LINE('... last and prior...');
    DECLARE
        v_counter BINARY_INTEGER;
    BEGIN
        v_counter := v_ib.LAST;
        LOOP
            EXIT WHEN v_counter IS NULL;
            DBMS_OUTPUT.PUT_LINE(v_counter ||' '|| v_ib(v_counter));
            v_counter := v_ib.PRIOR(v_counter);
        END LOOP;
    END;
 
 END;
/
