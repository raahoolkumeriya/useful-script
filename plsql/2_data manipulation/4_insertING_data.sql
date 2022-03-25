SELECT * FROM ANIMAL
    ORDER BY ANIMAL_ID;
    
-- BASIC INSERT OF HARCIDED VALUES
-- SQL IN PLSQL
BEGIN
    INSERT INTO ANIMAL
    VALUES(5,'Crocodile');
END;
/

-- BASIC INSERT WITH ERRO HANDLING
BEGIN
    INSERT INTO ANIMAL
    VALUES(5,'Crocodile');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ID 5 ALREADY EXISTS');
END;
/

-- BASIC INSERT WITH ERROR HANDLING AND 
-- SHOWING SUCCESS
BEGIN
    INSERT INTO ANIMAL
    VALUES(6,'Deer');
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' RECORD CREATED');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ID 6 ALREADY EXISTS');
END;
/

-- INSERT ROWTYPE
DECLARE
    v_animal animal%ROWTYPE;
BEGIN
    v_animal.animal_id := 7;
    v_animal.animal_name := 'Bear';
    INSERT INTO ANIMAL
    VALUES v_animal;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' RECORD CREATED');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ID 7 ALREADY EXISTS');
END;
/

----------------------------------------------------------
--          BULK INSERTS
----------------------------------------------------------

DELETE FROM ANIMAL;
SELECT * FROM ANIMAL;

DECLARE 
    -- MEMEORY TABLES
    -- ROW TYPE VARIABEL FOR ANIMAL TABLE
    TYPE v_animal_t IS TABLE OF ANIMAL%ROWTYPE;
    v_animal v_animal_t := v_animal_t();
    
    --COLUMN TYPE VARIABELS FOR ANIMAL TABLE
    TYPE v_n_t IS TABLE OF NUMBER;
    v_id v_n_t := v_n_t();
    TYPE v_vc230_t IS TABLE OF VARCHAR2(30);
    v_name v_vc230_t := v_vc230_t();
    
    -- SEQUENTIAL ID
    v_next_id NUMBER := 0;
    
BEGIN
    -- ASSEMBLE 3 ANIMAL RECORDS IN MEMORY 
    v_animal.EXTEND(3);
    FOR COUNTER IN 1..3 LOOP
        v_next_id := v_next_id + 1;
        v_animal(COUNTER).animal_id := v_next_id;
        v_animal(COUNTER).animal_name := 'Animal '|| v_next_id;
    END LOOP;

    -- BULK INSERT 3 ROWS INTO TABLE
    FORALL counter IN 1..v_animal.COUNT
        INSERT INTO animal
            VALUES v_animal(COUNTER);
    
    -- assemble 3 ANIMAL RECORDS COLUMNS IN MEMORY
    v_id.EXTEND(3);
    v_name.EXTEND(3);
    FOR counter IN 1..3 LOOP
        v_next_id := v_next_id + 1;
        v_id(counter) := v_next_id;
        v_name(counter) := 'Animal '|| v_next_id;
    END LOOP;
    
    -- BULK INSERT 4 ROWS INTO TABLE
    FORALL counter IN 1..v_id.COUNT
        INSERT INTO ANIMAL
        VALUES (v_id(counter), v_name(counter));
END;
/

ROLLBACK;


SELECT * FROM ANIMAL;
DELETE FROM ANIMAL;


-- BULK INSERT WITH ROW COUNT
DECLARE
    -- ROWTYPE VARIABLE FOR ANIMAL TABLE
    TYPE v_animal_t IS TABLE OF ANIMAL%ROWTYPE;
    V_ANIMAL v_animal_t := v_animal_t();
    -- SEQUENTIAL ID
    v_next_id NUMBER := 0;
    
BEGIN
    -- ASSEMBLE 3 ANIMAL RECORDS IN MEMORY
    V_ANIMAL.EXTEND(3);
    FOR COUNTER IN 1..3 LOOP
        v_next_id := v_next_id + 1;
        V_ANIMAL(COUNTER).ANIMAL_ID := v_next_id;
        V_ANIMAL(COUNTER).ANIMAL_NAME := 'ANIMAL '|| v_next_id;
    END LOOP;
    
    FORALL counter IN 1..V_ANIMAL.COUNT
        INSERT INTO ANIMAL
        VALUES V_ANIMAL(counter);
    
    -- SEE HWO MANY ROWS WEERE ACTUALLY CREATED
    FOR counter IN 1..V_ANIMAL.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('ELEMENT '||COUNTER||' '|| SQL%BULK_ROWCOUNT(counter));
    END LOOP;
END;

/

--- ------------------------------------------
-- insert RETURNING
----------------------------------------------

SELECT * FROM ANIMAL;

-- INSERT RETUTNING VALUES
DECLARE 
    v_animal_id    NUMBER;
    v_animal_name   VARCHAR2(30);
BEGIN
    FOR counter IN 1..10 LOOP
        BEGIN
            INSERT INTO ANIMAL
            VALUES(COUNTER, 'ANIMAL '|| COUNTER)
            RETURNING ANIMAL_ID, ANIMAL_NAME
                INTO v_animal_id, v_animal_name;
            DBMS_OUTPUT.PUT_LINE('cREATED '||
                                v_animal_id ||' '||
                                v_animal_name);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;
        END;
    END LOOP;
END;
/

ROLLBACK;


-- INSERT BUK VALUES
DECLARE
    TYPE v_animal_t IS TABLE OF ANIMAL%ROWTYPE;
    v_animal v_animal_t := v_animal_t();
    TYPE v_n_t IS TABLE OF NUMBER;
    v_id v_n_t := v_n_t();
BEGIN
    v_animal.extend(2);
    v_animal(1).ANIMAL_ID := 6;
    v_animal(1).ANIMAL_NAME := 'aNIMAL 6';
    v_animal(1).ANIMAL_ID := 7;
    v_animal(1).ANIMAL_NAME := 'aNIMAL 7';
    FORALL counter IN 1..2
        INSERT INTO ANIMAL
        VALUES v_animal(counter)
        RETURNING animal_id
        BULK COLLECT INTO v_id;
    DBMS_OUTPUT.PUT_LINE(v_id.COUNT ||' reocrd created');
END;
/
        
---------------------------------------------------------        
--INSERT SAVE EXCEPTION
---------------------------------------------------------
DECLARE
    -- ROWTYPE VARIABLE FOR ANIMAL TABLE
    TYPE v_animal_t IS TABLE OF ANIMAL%ROWTYPE;
    v_animal v_animal_t := v_animal_t();
    
    -- SEQUENTIAL ID
    v_next_id NUMBER := 0;
    
    e_dml_error EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_dml_error, -24381);
BEGIN
    --ASEMBLE 3 ANIAMLS RECORD IN MEMORY
    v_animal.EXTEND(3);
    FOR counter IN 1..3 LOOP
        v_next_id := v_next_id + 1;
        v_animal(counter).ANIMAL_ID := v_next_id;
        v_animal(counter).ANIMAL_NAME := 'animal '|| v_next_id;
    END LOOP;
    
    -- BULK INTER 3 ROWS IN TABLE
    BEGIN
        FORALL counter IN 1..v_animal.COUNT SAVE EXCEPTIONS
            INSERT INTO ANIMAL
        VALUES v_animal(counter);
    EXCEPTION
        WHEN e_dml_error THEN
    --        NULL;
           FOR counter IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE('eRROR '|| SQL%BULK_EXCEPTIONS(counter).ERROR_CODE||
                             ' At Element '||SQL%BULK_EXCEPTIONS(counter).ERROR_INDEX);
                DBMS_OUTPUT.PUT_LINE('Animal id WAS '|| V_animal(SQL%BULK_EXCEPTIONS(counter).ERROR_INDEX).animal_id);
         END LOOP;
    END;
END;
/


ROLLBACK;

----------------------------------------------------------
-- UPDATE DATA
----------------------------------------------------------

SELECT * FROM ANIMAL ORDER BY ANIMAL_ID;

-- BASIC UDPATE WITH HARDCODE VALUES
BEGIN
    UPDATE ANIMAL SET ANIMAL_NAME='hIPPO'
    WHERE ANIMAL_ID = 4;
END;
/
-- UPDATE WITH ROW COUNT DISPLAY
BEGIN
    UPDATE ANIMAL
    SET ANIMAL_NAME = 'Hippo' 
    WHERE animal_id = 4;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' RECORDS UPDATED');
END;
/


-- UPDATE WITH ERROR HANDLER
DECLARE
    e_too_long EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_too_long, -12899);
BEGIN
    UPDATE ANIMAL
    SET ANIMAL_NAME = 'HippoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO' 
    WHERE animal_id = 4;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' RECORDS UPDATED');
    EXCEPTION
        WHEN e_too_long THEN
            DBMS_OUTPUT.PUT_LINE('NAME TOO LONG'); 
END;
/


-- UDPATE ROWTYPE
DECLARE 
    v_animal ANIMAL%ROWTYPE;
BEGIN
    v_animal.animaL_id := 4;
    v_animal.animal_name := 'Hippo';
    UPDATE ANIMAL 
    SET ANIMAL_NAME = v_animal.animal_name
    WHERE ANIMAL_ID = v_animal.animal_id;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' RECORD UDPATED'); 
END;
/

------------------------------------------------------------
-- BULK UPDATE 
------------------------------------------------------------
DELETE FROM ANIMAL;

INSERT INTO ANIMAL VALUES (1,'Zebra');
INSERT INTO ANIMAL VALUES (2,'Panda');
COMMIT;

SELECT * FROM ANIMAL;

-- BULK UPDATE OF SINGLE ROWS AND MULTIPLE ROWS
DECLARE
    -- COLUMN TYPE VARAIBLE FOR ANIMAL TABLE
    TYPE v_animal_t IS TABLE OF NUMBER;
    v_id v_animal_t := v_animal_t();
    TYPE v_animal_NAME_t IS TABLE OF VARCHAR2(30);
    v_name v_animal_NAME_t := v_animal_NAME_t();
BEGIN
    v_id.EXTEND(3);
    v_name.EXTEND(3);
    FOR counter in 1..3 LOOP
        v_id(counter) := counter;
        v_name(counter) := 'Animal '|| counter;
    END LOOP;
    
    -- BULK UPDATE 3 ROW TABLE
    FORALL counter IN 1..v_id.COUNT 
        UPDATE ANIMAL
        SET animal_name = v_name(counter)
        WHERE animal_id = v_id(counter);
        
    FOR counter IN 1 .. v_id.COUNT LOOP
        dbms_output.put_line('eLEMENT '||counter|| ' UPDATED '||
            SQL%BULK_ROWCOUNT(counter) || 'row(s)');
    END LOOP;
END;
    
/

--------------------------------------------
--- update RETRUNING
---------------------------------------------
ROLLBACK;
SELECT * FROM ANIMAL;

-- UDPATE RETURNING VALUES FOM SINGL ROW
DECLARE 
    v_animal_id number;
    v_animal_name VARCHAR2(30);
BEGIN
    FOR counter IN 1..3 LOOP
        UPDATE ANIMAL 
        SET animal_name = 'Animal '||counter
        WHERE animal_id = counter
            RETURNING animal_id, animal_name
            INTO v_animal_id,v_animal_name;
        dbms_output.put_line('Updated '|| v_animal_id ||' '|| v_animal_name);
    END LOOP;
END;
/

-- UPDATE RETUUNIGN FROM MULTIPLE ROW UPDATE
DECLARE
    TYPE v_id_t IS TABLE OF NUMBER;
    v_id v_id_t := v_id_t();
    type v_name_t is table of varchar2(30);
    v_name v_name_t := v_name_t();
begin
    for counter in 1..3 loop
    update animal 
    set animal_name = 'Animal '||counter
     RETURNING animal_id, animal_name
      BULK COLLECT INTO v_id, v_name;
        dbms_output.put_line(v_id.COUNT ||' records updated');
    ENd LOOP;
end;
/

rollback;

select * from animal;

-- update bulk values
DECLARE
    TYPE v_animal_t IS TABLE OF animal%rowtype;
    v_animal v_animal_t := v_animal_t();
    TYPE v_n_t IS TABLE OF NUMBER;
    v_id v_n_t :=  v_n_t();
begin
    v_animal.extend(2);
    v_animal(1).animal_id := 1;
    v_animal(1).animal_name := 'Zebra';
    v_animal(1).animal_id := 2;
    v_animal(1).animal_name := 'Panda';
  
    FORALL counter in 1..2  
    update animal 
    set animal_name = v_animal(counter).animal_name
    where animal_id = v_animal(counter).animal_id
     RETURNING animal_id
      BULK COLLECT INTO v_id;
        dbms_output.put_line(v_id.COUNT ||' records updated');
end;
/


----------------------------
-- Update SAVE EXCptiONS -- only work for bulk update
------------------------------------------

DECLARE
    -- type and variale for updates
    TYPE v_animal_t IS TABLE OF NUMBER;
    v_animal_id v_animal_t := v_animal_t();
    TYPE v_animal_name_t IS TABLE OF VARCHAR2(30);
    V_ANIMAL_NAME v_animal_name_t := v_animal_name_t();
     
    e_dml_error EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_dml_error, -24381);
BEGIN
    --ASEMBLE 3 ANIAMLS RECORD IN MEMORY
    v_animal_id.EXTEND(3);
    v_animal_name.EXTEND(3);
    FOR counter IN 1..3 LOOP
        v_animal_ID(counter) := COUNTER;
        v_animal_NAME(counter) := RPAD(counter,100,counter);
    END LOOP;
    
    -- BULK update 3 ROWS IN TABLE
    BEGIN
        FORALL counter IN 1..v_animal_id.COUNT SAVE EXCEPTIONS
            UPDATE ANIMAL
        SET animal_name = v_animal_name(counter)
        WHERE animal_id = v_animal_id(counter);
    EXCEPTION
        WHEN e_dml_error THEN
          FOR counter IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
             DBMS_OUTPUT.PUT_LINE('eRROR '|| SQL%BULK_EXCEPTIONS(counter).ERROR_CODE||
                         ' At Element '||SQL%BULK_EXCEPTIONS(counter).ERROR_INDEX);
           DBMS_OUTPUT.PUT_LINE('Animal id WAS '|| V_animal_id(SQL%BULK_EXCEPTIONS(counter).ERROR_INDEX));
     END LOOP;
    END;
END;
/


---------------------------------------------------
--- DELETING DATA
---------------------------------------------------

select * from animal;

-- basic sql delete
delete from animal where animal_id=2;

rollback;

-- basic delete with hardoced values
begin
    delete from animal where animal_id=2;
end;
/

rollback;

-- delete ith rowcount display 
begin
    delete from animal where animal_id=2;
    dbms_output.put_line(SQL%ROWCOUNT ||' row(s) deleted');
end;
/

rollback;

-- deelte with erro handler
DECLARE
    e_not_numeric EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_not_numeric, -1722);
BEGIN
    DELETE ANIMAL
    WHERE animal_id = 'ABC';
EXCEPTION
     WHEN e_not_numeric THEN
     DBMS_OUTPUT.PUT_LINE('ID IS NUMERIC');
END;
/

-- DELETE WITH ROWYTPE
DECLARE
    v_animal animal%ROWTYPE;
BEGIN
    V_ANIMAL.animal_id := 2;
    v_Animal.animal_name := 'Panda';
    DELETE ANIMAL
    WHERE ANIMAL_ID = v_animal.animal_ID;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' rECORD DELETE');
END;
/

ROLLBACK;

ROLLBACK;
-----------------------------------------------------
----  BULK DELETE
------------------------------------------------------

-- bulk delete of single rows and mulitple rows
DECLARE
    -- COLUMN TYPE VARAIBLE FOR ANIMAL TABLE
    TYPE v_animal_t IS TABLE OF NUMBER;
    v_id v_animal_t := v_animal_t();
    TYPE v_animal_NAME_t IS TABLE OF VARCHAR2(30);
    v_name v_animal_NAME_t := v_animal_NAME_t();
BEGIN
    -- assemble 3 animal records.columns in memory
    v_id.EXTEND(3);
    v_name.EXTEND(3);
    FOR counter in 1..3 LOOP
        v_id(counter) := counter;
        v_name(counter) := 'Animal '|| counter;
    END LOOP;
    
    -- BULK UPDATE 3 ROW TABLE
    FORALL counter IN 1..v_id.COUNT 
        DELETE ANIMAL
        --WHERE animal_id = v_id(counter);
        WHERE animal_id >= v_id(counter);
        
    FOR counter IN 1 .. v_id.COUNT LOOP
        dbms_output.put_line('eLEMENT '||counter|| ' DELETED '||
            SQL%BULK_ROWCOUNT(counter) || 'row(s)');
    END LOOP;
    
END;
    
/


----------------------------------------
--- DELETE SAVE EXCEPTIONS
---------------------------------------
ROLLBACK;
SELECT * FROM ANIMAL;

DECLARE
    -- type and variale for updates
    TYPE v_animal_t IS TABLE OF NUMBER;
    v_animal_id v_animal_t := v_animal_t();
     
    e_dml_error EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_dml_error, -24381);
BEGIN
    --ASEMBLE 3 ANIAMLS RECORD IN MEMORY
    v_animal_id.EXTEND(3);
 
    FOR counter IN 1..3 LOOP
        v_animal_ID(counter) := COUNTER;
    END LOOP;
 
    -- SET ALPHA NUMERIC ID TO CORCE ERROR
    v_animaL_id(3) := 'A';
    
    -- BULK DETETE 3 ROWS IN TABLE
   BEGIN
        FORALL counter IN 1..v_animal_id.COUNT SAVE EXCEPTIONS
            DELETE ANIMAL
        WHERE animal_id = v_animal_id(counter);
    EXCEPTION
        WHEN e_dml_error THEN
          FOR counter IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
             DBMS_OUTPUT.PUT_LINE('eRROR '|| SQL%BULK_EXCEPTIONS(counter).ERROR_CODE||
                         ' At Element '||SQL%BULK_EXCEPTIONS(counter).ERROR_INDEX);
           DBMS_OUTPUT.PUT_LINE('Animal id WAS '|| V_animal_id(SQL%BULK_EXCEPTIONS(counter).ERROR_INDEX));
     END LOOP;
 END;
END;
/

