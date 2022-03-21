-----------------------------------------------
-- DYNAMIC SQL
-------------------------------------------------
-- CONTENTS NTO FULLY KNWO AT COMPILE TIME
-- CODE IS COMPILED JUST IN TIME
-- CAN BE SQL (DDL AND DML) OR PLSQL
-------------------------------------------------


SELECT * FROM ANIMAL;

BEGIN
    -- DYNAMIC DML
    EXECUTE IMMEDIATE 'INSERT INTO ANIMAL VALUES(2,''ZEBRA'')';
    -- DYNAMIC DDL
    EXECUTE IMMEDIATE 'ALTER TABLE ANIMAL ADD (ANIMAL_SPECIES VARCHAR2(30))';
    --DYNAMIC PLSQL
    EXECUTE IMMEDIATE 'BEGIN NULL; END;';
END;
/

-- RAISES EXCEPTION 
BEGIN
    EXECUTE IMMEDIATE 'BEGIN RAISE NO_dATA_FOUND;END;';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND WAS RASIED');
END;
/


-- STACK AND ERRRO TRACE
BEGIN
    EXECUTE IMMEDIATE 'BEGIN RAISE NO_dATA_FOUND;END;';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CALL STACK '|| DBMS_UTILITY.FORMAT_cALL_STACK);
        DBMS_OUTPUT.PUT_LINE('ERROR STACK '|| DBMS_UTILITY.FORMAT_ERROR_STACK);
        DBMS_OUTPUT.PUT_LINE('STACK BACK '|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/


-- SET ROWCOUNTS
BEGIN
    EXECUTE IMMEDIATE 'UPDATE ANIMAL SET ANIMAL_SPECIES=''UNKNOWN''';
    DBMS_OUTPUT.PUT_LINE('rECORD UDATED '|| SQL%ROWCOUNT);
END;
/

----------------------------------------------------
-- DYNAMIC SQL PARAMTERES
------------------------------------------------------
-- VALUES PASSED IN AT COMPILE TIME
-- ..WHCIH IS JUST BEFOR EEXECUTION
-- TWO METHODS AVAIBLE
    -- CONCATENATE INTO STATEMENTS
    -- PASS INTO STATEMENT USING SUBSTITUTION VARIABLES
-------------------------------------------------------

SELECT * FROM ANIMAL;

DECLARE 
    v_panda_species VARCHAR2(30) := 'Melanoleuca';
    v_ZEBRA_species VARCHAR2(30) := 'Equids';
BEGIN
    -- PASS PARAMTER TO SQL STEEMT TO ENCOURAGE ORACLE COMPILER TO REUSE
    -- COMPILE VERSION OF CODE
    EXECUTE IMMEDIATE 'UPDATE ANIMAL SET ANIMAL_SPECIES = :1 WHERE ANIMAL_NAME = :2' USING v_ZEBRA_species, 'ZEBRA';
    --PASSIG PARAMTERE AS TEXT WITHING DYANMIC SQL DOES NOT PROMOTE REUSE
    EXECUTE IMMEDIATE 'UPDATE ANIMAL SET ANIMAL_SPECIES = '||''''|| v_panda_species || '''' || 'WHERE ANIMAL_NAME = ''Panda''';
    
END;
/
-----------------------------------------------------------------
-- DYNAAMIC SQL RETURN VALUES
----------------------------------------------------------------
--- VALUES RETURNED BY DYNAMIC CODE
-- SENT ABCK VIA OUT VARIABELS
----------------------------------------------------------------


DROP TABLE ANIMAL;

CREATE TABLE ANIMAL ( ANIMAL_ID NUMBER,
    ANIMAL_NAME VARCHAR(30));
INSERT INTO ANIMAL VALUES(1,'PANDA');
INSERT INTO ANIMAL VALUES(2,'ZEBRA');
COMMIT;

SELECT * FROM ANIMAL;


-- SPECIFY OUT PARMATER FOR DYANAMIC SQL
DECLARE 
    v_animal_id NUMBER := 1;
    v_animal_name VARCHAR2(30) := 'TIGER';
    v_actal_id NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'UPDATE ANIMAL SET ANIMAL_NAME = :1 WHERE ANIMAL_ID  = :2 RETURNING animal_id INTO :3'
        USING v_animal_name, v_animal_id, OUT v_actal_id;
    DBMS_OUTPUT.PUT_LINE('Rows updated :' || SQL%ROWCOUNT);
    DBMS_OUTPUT.PUT_LINE('ID updated :' || v_actal_id);
END;
/

-- SEPECIFY IN AND OUT PARAMETER FOR DYANMIC SQL
DECLARE 
    v_animal_id NUMBER := 1;
    v_animal_name VARCHAR2(30) := 'TIGER';
BEGIN
    EXECUTE IMMEDIATE 'UPDATE ANIMAL SET ANIMAL_NAME = :1 WHERE ANIMAL_ID  = :2 RETURNING animal_id INTO :3'
        USING v_animal_name,IN v_animal_id, OUT v_animal_id;
    DBMS_OUTPUT.PUT_LINE('Rows updated :' || SQL%ROWCOUNT);
    DBMS_OUTPUT.PUT_LINE('ID updated :' || v_animal_id);
END;
/



CREATE OR REPLACE TYPE v_n_t AS TABLE OF NUMBER;
/

-- MISISNG INTO KEYWORD?
DECLARE 
    v v_n_t := v_n_t();
    vv NUMBER;
BEGIN
    v.EXTEND(2);
    v(1) := 2;
    v(2) := 1;
    EXECUTE IMMEDIATE 'DECLARE
                    v2 v_n_t := v_n_t();
                    BEGIN
                        UPDATE animal SET animal_name = ''BOB''
                        WHERE animal_id IN ( SLEECT column_value
                                FROM TABLE(CAST(:1 AS v_n_t))) RETURNING animal_id BULK COLLECT INTO v2;
                            :2 := v2;
                        END;'
    USING v, OUT v;
    FOR counter IN 1..v.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v(counter));
    END LOOP;
END;
/

----------------------------
