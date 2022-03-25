BEGIN
    DBMS_OUTPUT.PUT_LINE('SIMPLE FOR LOOP');
    FOR COUNTER IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(COUNTER);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('SIMPLE reverse FOR LOOP');
    FOR COUNTER IN REVERSE 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(COUNTER);
    END LOOP;


    DBMS_OUTPUT.PUT_LINE('SIMPLE FOR LOOP WITH CONDITION EXIT');
    FOR COUNTER IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(COUNTER);
        EXIT;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('SIMPLE FOR LOOP WITH CONDITION EXIT');
    FOR COUNTER IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(COUNTER);
        EXIT WHEN COUNTER = 2;
    END LOOP;


    DBMS_OUTPUT.PUT_LINE('SIMPLE FOR LOOP WITH CONTINUE');
    FOR COUNTER IN 1..3 LOOP
        CONTINUE;
        DBMS_OUTPUT.PUT_LINE(COUNTER);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('SIMPLE FOR LOOP WITH CONDITIONAL CONTINUE');
    FOR COUNTER IN 1..3 LOOP
        CONTINUE WHEN COUNTER = 2;
        DBMS_OUTPUT.PUT_LINE(COUNTER);
    END LOOP;

END;
/


DECLARE
    v_stop_now BOOLEAN;
BEGIN
    v_stop_now := FALSE;
    LOOP
        DBMS_OUTPUT.PUT_LINE('SIMPLE LOOP 1');
        v_stop_now := TRUE;
        EXIT WHEN v_stop_now; 
        DBMS_OUTPUT.PUT_LINE('SIMPLE LOOP 2');
    END LOOP;
    
    
    v_stop_now := FALSE;
    WHILE NOT v_stop_now LOOP
        DBMS_OUTPUT.PUT_LINE('SIMPLE WHILE LOOP 1');
        v_stop_now := TRUE;
        DBMS_OUTPUT.PUT_LINE('SIMPLE LOOP 2');
    END LOOP;
    
END;
/