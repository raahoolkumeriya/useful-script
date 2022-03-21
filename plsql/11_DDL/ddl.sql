---------------------------------------------------
--- DDL - CREATING OBJECTS
--------------------------------------------------
--- DATA DEFINITION LANAGUAGE (DDL ) STATEMENTS
-- CANNOT BE RUN DIRECTLY IN PLSQL
-- REQUIRED SPECIAL PROCEDURES
    -- DYNAMIC SQL
    -- DBMS_SQL
    -- EXEC_DDL_STATEMENT
---------------------------------------------------

-- IF ONLY IT WAS THE TIS EASY WAY
-- not possible
BEGIN 
    CREATE TABLE animal (ANIMAL_ID NUMBER, 
        ANIMAL_NAME VARCHAR2(30));
END;
/


CREATE OR REPLACE PACKAGE excptn AS 
    e_already_exist EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_already_exist,-955);
    e_does_not_exist EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_does_not_exist,-942);
END;
/

ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL=3;

-- DYNAMIC SQL
BEGIN 
    EXECUTE IMMEDIATE 'CREATE TABLE animal (ANIMAL_ID NUMBER, 
        ANIMAL_NAME VARCHAR2(30))';
EXCEPTION
    WHEN excptn.e_already_exist THEN
    NULL;
END;
/

-- DBMS_UTILITY PROCEDURE
BEGIN 
    DBMS_UTILITY.EXEC_DDL_STATEMENT('CREATE UNIQUE INDEX animal_ix ON animal(animal_id)');
 EXCEPTION
 WHEN excptn.e_already_exist THEN
    NULL;
END;
/

-- DBMS_SQL
DECLARE
    v_curs NUMBER;
    v_ret_val INTEGER;
BEGIN 
    v_curs := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_curs,'DROP TABLE ANIMAL', DBMS_SQL.NATIVE);
    DBMS_SQL.CLOSE_CURSOR(v_curs);
EXCEPTION
 WHEN excptn.e_does_not_exist THEN
    NULL;
END;
/
