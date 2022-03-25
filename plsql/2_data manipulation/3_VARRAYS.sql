-- VARRAY

DECLARE
    TYPE v_array_t IS VARRAY(3) OF VARCHAR2(20);
    V_VARRAY v_array_t := v_array_t();
BEGIN
    -- ADD 3 ENTRIES
    V_VARRAY.EXTEND(3);
    V_VARRAY(1) := 'A';
    V_VARRAY(2) := 'B';
    V_VARRAY(3) := 'C';
    
    DBMS_OUTPUT.PUT_LINE('........WHEN Entries added ......');
    DBMS_OUTPUT.PUT_LINE('vARRAY by Count '|| V_VARRAY.COUNT);
    DBMS_OUTPUT.PUT_LINE('vARRAY by first '|| V_VARRAY.FIRST);
    DBMS_OUTPUT.PUT_LINE('vARRAY by last '|| V_VARRAY.LAST);
    
    DBMS_OUTPUT.PUT_LINE('........SIMPLE LOOP ......');
    FOR COUNTER IN 1..V_VARRAY.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(COUNTER ||'  '|| V_VARRAY(COUNTER));
    END LOOP; 
    
    
    DBMS_OUTPUT.PUT_LINE('........FIRST AND NEXT......');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_VARRAY.FIRST;
        LOOP
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER || '  ' || V_VARRAY(V_COUNTER));
            V_COUNTER := V_VARRAY.NEXT(V_COUNTER);
        END LOOP;
    END;
    
    
    DBMS_OUTPUT.PUT_LINE('........LAST AND PRIOR ......');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_VARRAY.LAST;
        LOOP
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER || '  ' || V_VARRAY(V_COUNTER));
            V_COUNTER := V_VARRAY.PRIOR(V_COUNTER);
        END LOOP;
    END;
    
    
    
END;
/

-- CAN NOT BE SPARSE 

-- VARRAY

DECLARE
    TYPE v_array_t IS VARRAY(3) OF VARCHAR2(20);
    V_VARRAY v_array_t := v_array_t();
BEGIN
    -- ADD 3 ENTRIES
    V_VARRAY.EXTEND(3);
    V_VARRAY(1) := 'A';
    V_VARRAY(2) := 'B';
    V_VARRAY(3) := 'C';
    
    DBMS_OUTPUT.PUT_LINE('........WHEN Entries added ......');
    DBMS_OUTPUT.PUT_LINE('vARRAY by Count '|| V_VARRAY.COUNT);
    DBMS_OUTPUT.PUT_LINE('vARRAY by first '|| V_VARRAY.FIRST);
    DBMS_OUTPUT.PUT_LINE('vARRAY by last '|| V_VARRAY.LAST);
 
    -- CAN'T DELETE ELEMENT 
    -- V_VARRAY.DELETE(2);
    -- WE CAN DELETE ALL ELEMENTA AT ONCE
    v_varray.DELETE;
    
    DBMS_OUTPUT.PUT_LINE('........SIMPLE LOOP ......');
    FOR COUNTER IN 1..V_VARRAY.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(COUNTER ||'  '|| V_VARRAY(COUNTER));
    END LOOP; 
    
    
    DBMS_OUTPUT.PUT_LINE('........FIRST AND NEXT......');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_VARRAY.FIRST;
        LOOP
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER || '  ' || V_VARRAY(V_COUNTER));
            V_COUNTER := V_VARRAY.NEXT(V_COUNTER);
        END LOOP;
    END;
    
    
    DBMS_OUTPUT.PUT_LINE('........LAST AND PRIOR ......');
    DECLARE
        V_COUNTER BINARY_INTEGER;
    BEGIN
        V_COUNTER := V_VARRAY.LAST;
        LOOP
            EXIT WHEN V_COUNTER IS NULL;
            DBMS_OUTPUT.PUT_LINE(V_COUNTER || '  ' || V_VARRAY(V_COUNTER));
            V_COUNTER := V_VARRAY.PRIOR(V_COUNTER);
        END LOOP;
    END;
    
    
    
END;
/