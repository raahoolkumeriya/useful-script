-----------------------
--      CURSORS      --
-------------------------
--        A cursor is a provate memory area, temporily allocated in UGA that use for processing SQL statements. 
--        A cursor is a reference to a row of data in a table.

-- EXPLICITS 
--IMPLICITS 
--VARIABLE 
--ATTRIBUTS

SELECT * FROM ANIMAL;

-- Explicit Cursor OPEN CLOSE and FETCH With variable types
DECLARE
    CURSOR cur_get_animal IS
        SELECT * FROM ANIMAL;
    -- varibale that takes on column and datatypes from
    -- the underlying animal table
    v_table_row ANIMAL%ROWTYPE;

    -- variable that takes on column and datatypes from 
    -- teh cursor itself
    v_cursor_row cur_get_animal%ROWTYPE;

    -- variable that takes on datatpe from column in the table
    v_anchored_id animal.animal_id%TYPE;
    v_anchored_name animal.animal_name%TYPE;
    
    -- explicitly defien variabels
    v_animal        NUMBER;
    v_animal_name   VARCHAR2(30);

BEGIN
    -- explicit cursor open 
    OPEN cur_get_animal;
    -- fetch to table
    FETCH cur_get_animal INTO v_table_row;
    -- fetch to cursor row
    FETCH cur_get_animal INTO v_cursor_row;
    -- fetch to anchored variabels
    FETCH cur_get_animal INTO v_anchored_id,v_anchored_name;
    -- fetch to explicits variabels
    FETCH cur_get_animal INTO v_animal, v_animal_name;
    
    -- explict cursor close
    CLOSE cur_get_animal;
    
    DBMS_OUTPUT.PUT_LINE(v_table_row.animal_id || ' '|| v_table_row.animal_name);
    DBMS_OUTPUT.PUT_LINE(v_cursor_row.animal_id || ' '|| v_cursor_row.animal_name);
    DBMS_OUTPUT.PUT_LINE(v_anchored_id|| ' '|| v_anchored_name);
    DBMS_OUTPUT.PUT_LINE(v_animal || ' '|| v_animal_name);
    
END;
/


-- CRSOR attributes
DECLARE 
    CURSOR cur_get_animal IS
    SELECT * FROM animal;
    v_row ANIMAL%ROWTYPE;
BEGIN
    IF NOT cur_get_animal%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Before: CUR IS NOT OPEN');
    END IF;
    
    OPEN cur_get_animal;
    
    IF NOT cur_get_animal%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('After: CUR IS OPEN');
    END IF;
    -- hardcoded lop iteration between i know table has 4 records
    FOR INDX IN 1..5 LOOP
        FETCH cur_get_animal INTO v_row;
        DBMS_OUTPUT.PUT_LINE('Fetched Record '|| cur_get_animal%ROWCOUNT );
        IF cur_get_animal%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Fetched ONE');
        END IF;
        IF cur_get_animal%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE('DID NOT FOUND ONE');
        END IF;
    END LOOP;

    CLOSE cur_get_animal;
    
    IF NOT cur_get_animal%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('CLOSE: CUR IS not OPEN');
    END IF;
        
END;
/


-- implicits cursor ATTRIBUTE IN for LOOP
BEGIN
    FOR v_animal IN ( SELECT * FROM ANIMAL ) LOOP
        DBMS_OUTPUT.PUT_LINE('Found record' || SQL%ROWCOUNT);
    END LOOP;
END;
/

-- for loop with EXplicits CUrsor
DECLARE 
    CURSOR cur_get_animal IS 
        SELECT * FROM ANIMAL;
BEGIN
    FOR V IN cur_get_animal LOOP
        DBMS_OUTPUT.PUT_LINE('Found record' || SQL%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('Found record get_cur_animal ' || cur_get_animal%ROWCOUNT );
    END LOOP;
END;
/


--- implicit curosr attributes ( non looping)
DECLARE 
    V_aNIMAL_REC animal%ROWTYPE;
BEGIN
    SELECT * INTO V_ANIMAL_REC
    FROM ANIMAL WHERE ANIMAL_ID = 1;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT );
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Found ONE');
    END IF;
    SELECT * INTO V_ANIMAL_REC
    FROM ANIMAL WHERE ANIMAL_ID = 99;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT );
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('DID NOT Found ONE');
    END IF;
END;
/
    

-- cant open cursor that is already open
DECLARE 
    CURSOR cur_get_animal IS
    SELECT * FROM animal;
BEGIN    
    OPEN cur_get_animal;
    OPEN cur_get_animal;
EXCEPTION
    WHEN CURSOR_ALREADY_OPEN THEN
        CLOSE cur_get_animal;
END;
/
    

-- cant fetch from the clowse cursor in not open
DECLARE 
    CURSOR cur_get_animal IS
    SELECT * FROM animal;
    V_ANIMAL ANIMAL%ROWTYPE;
BEGIN    
    FETCH cur_get_animal INTO V_aNIMAL;
EXCEPTION
    WHEN INVALID_CURSOR THEN
      NULL;
END;
/
    
