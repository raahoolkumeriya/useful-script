SET SERVEROUTPUT ON;

-- for loop with an implicit cursor
BEGIN
    FOR V_ANIMAL IN ( SELECT * FROM ANIMAL) LOOP
        DBMS_OUTPUT.PUT_LINE(V_ANIMAL.ANIMAL_NAME);
        DBMS_OUTPUT.PUT_LINE('ROW COUNT : '||SQL%ROWCOUNT);
    END LOOP;
END;
/
-- Wwe dont get SQL%ROWCOUNT value in implicit cursor 
-- for loop wit explicit curso
DECLARE
    CURSOR cur_animal IS 
        SELECT * FROM ANIMAL;
BEGIN
    FOR V_ANIMAL IN cur_animal LOOP
        DBMS_OUTPUT.PUT_LINE(V_ANIMAL.ANIMAL_NAME);
        DBMS_OUTPUT.PUT_LINE('ROW COUNT : '||cur_animal%ROWCOUNT);
    END LOOP;
END;
/

-- exit loop with explicit cursor
DECLARE
    CURSOR cur_animal IS 
        SELECT * FROM ANIMAL;
    v_row ANIMAL%ROWTYPE;
BEGIN
    OPEN cur_animal;
    LOOP
        FETCH cur_animal INTO v_row;
        EXIT WHEN cur_animal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ROW COUNT : '||cur_animal%ROWCOUNT);
    END LOOP;
    CLOSE cur_animal;
END;
/

