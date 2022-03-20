--- WORLD Simplest block
BEGIN
    -- sinmple block on sql
    NULL;
END;
/

-- ----- SIMPLE blOCK
SET SERVEROUTPUT ON;
DECLARE
    v_variable NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_variable);
END;
/


-- EMBEDED block
BEGIN
    DBMS_OUTPUT.PUT_LINE('OUTER BLOCK');
    BEGIN
        DBMS_OUTPUT.PUT_LINE('EMBEDED BLOCK');
    END;
END;
/


-- embabded block with variable
DECLARE
    v_variable NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Outer varibale '|| v_variable);
    DECLARE 
        v_variable_inner NUMBER := 10;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Inner block variable '|| v_variable_inner);
    END;
END;
/
