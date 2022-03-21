----------------------------------------------------------
-- CODE COMPILATION
-- IT IS ACT OF TAKING TEXT REPSENTATION AND CONVERITNG IT TO M/C READIBEL FORMAAT 
-----------------------------------------------------------
-- CODE IS COMPILED INTO TEH DATABASE FOR EXECUTION
-- CODE MUST BE RECOMPILED IF DEPENDENT OBJECTS IS MODIFIED
-------------------------------------------------------------


CREATE TABLE a_table ( COL1 NUMBER(10));

CREATE OR REPLACE PROCEDURE a_proc AS
BEGIN
    UPDATE a_table 
    SET coL1 = coL1;
END;
/

SELECT NAME, TYPE, REFERENCED_NAME, REFERENCED_TYPE
    FROM USER_DEPENDENCIES
    WHERE REFERENCED_OWNER = USER;
    
SELECT OBJECT_NAME, OBJECT_TYPE , STATUS
FROM USER_OBJECTS;


BEGIN
    a_proc;
END;
/

ALTER TABLE a_table MODIFY( col1 NUMBER(20));

DROP PROCEDURE a_proc;




CREATE OR REPLACE PACKAGE a_pkg AS 
    PROCEDURE pkg_proc;
END;
/

CREATE OR REPLACE PACKAGE BODY a_pkg AS 
    PROCEDURE pkg_proc IS 
    BEGIN
        UPDATE a_table
        SET coL1 = col1;
        NULL;
    END;
END;
/

SELECT NAME, TYPE, REFERENCED_NAME, REFERENCED_TYPE
    FROM USER_DEPENDENCIES
    WHERE REFERENCED_OWNER = USER
    AND NAME LIKE 'A_%';
    
SELECT OBJECT_NAME, OBJECT_TYPE , STATUS
FROM USER_OBJECTS WHERE OBJECT_NAME LIKE 'A_%';


BEGIN
    a_pkg.pkg_proc;
END;
/

ALTER TABLE a_table
MODIFY (col1 NUMBER(20));

--------------------------------------------------------------
-- INQUIRY DIRECTIVIES
-------------------------------------------------------------
-- FLAGS IS CODE THAT DIRECT COMPLITAION BEHAVIOUS
-- FLAGS ENABLES OR DISABLED AT COMPILE TIME
-- AKA "CC" FLAGS
--------------------------------------------------------------

CREATE OR REPLACE PROCEDURE a_proc ( p_id NUMBER) IS
    v_local NUMBER;
BEGIN
    v_local := p_id;
    $IF $$DOUBLE_EVERYTHING $THEN
        v_local := v_local * 2;
    $END
    DBMS_OUTPUT.PUT_LINE(v_local);
END;
/


-- CEHCK THE CC FLAG SETTING
SELECT NAME, plsql_ccflags FROM
    USER_PLSQL_OBJECT_SETTINGS
    WHERE NAME = 'DOUBLE_EVERYTHING';
    
-- EXECUT EHT CODE
BEGIN
    a_proc(99);
END;
/

ALTER PROCEDURE a_proc COMPILE plsql_ccflags='DOUBLE_EVERYTHING:TRUE';


ALTER SESSION SET plsql_ccflags='DOUBLE_EVERYTHING:TRUE';

-- RESUE TEH SETTIGN FORM LAST CONVOLUTION
ALTER PROCEDURE a_proc COMPILE REUSE SETTINGS;
/


-- PREOCDURE WITH DEBUG VALUES
CREATE OR REPLACE PROCEDURE a_proc (p_id NUMBER) IS
    v_var NUMBER(1) := 1;
BEGIN
    $IF $$DEBUG $THEN
        DBMS_OUTPUT.PUT_LINE('Passed IN ' || p_id);
    $END
    v_var := v_var * 10;
EXCEPTION
    WHEN OTHERS THEN
        $IF $$DEBUG $THEN
            DBMS_OUTPUT.PUT_LINE('V_VAR was ' || v_var);
        $END
        RAISE;
END;
/

BEGIN
    a_proc(8);
END;
/

ALTER PROCEDURE a_proc  COMPILE plsql_ccflags='DEBUG:TRUE';



CREATE OR REPLACE PROCEDURE a_proc (p_id NUMBER) IS
    v_var NUMBER(1) := 1;
BEGIN
    $IF $$DEBUG $THEN
        DBMS_OUTPUT.PUT_LINE($$PLSQL_LINE || ' OF '|| $$PLSQL_UNIT);
    $END
    v_var := v_var * 10;
    $IF $$DEBUG $THEN
        DBMS_OUTPUT.PUT_LINE($$PLSQL_LINE || ' OF '|| $$PLSQL_UNIT);        
    $END

EXCEPTION
    WHEN OTHERS THEN
        $IF $$DEBUG $THEN
            DBMS_OUTPUT.PUT_LINE($$PLSQL_LINE || ' OF '|| $$PLSQL_UNIT);
        $END
        RAISE;
END;
/



BEGIN
    DBMS_PREPROCESSOR.PRINT_POST_PROCESSED_SOURCE(
        'PROCEDURE',USER,'A_PROC');
END;
/

ALTER PROCEDURE a_proc  COMPILE plsql_ccflags='DEBUG:FALSE';


----------------------------------------------------------------
-- CONDITIONAL COMPILATION
---------------------------------------------------------------
-- FLAGS IN CODE THAT DIRECT COMPLIATION BEHAVIOURS
-- FLAGS ENABLED OR DISABLED IN PLSQL PACAKGES
----------------------------------------------------------------

--VERSION SPECIFC CODE THAT COMPILE AGAINST ALL VERSION
CREATE OR REPLACE PROCEDURE version_sensitive_code AS
BEGIN
    IF DBMS_DB_VERSION.VER_LE_10 THEN
        DBMS_OUTPUT.PUT_LINE('VERSION 10 CODE HERE');
    ELSIF DBMS_DB_VERSION.VER_LE_11 THEN
        DBMS_OUTPUT.PUT_LINE('VERSION 11 CODE HERE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('CODE ONLY WORKS ON 10 AND 11');
    END IF;
END;
/

BEGIN
   version_sensitive_code;
END;
/


-- VERSION SPECIFIC CODE THAT DOES NOT COMPILE AGAINST ALL VERSION
CREATE OR REPLACE PROCEDURE version_sensitive_code AS
BEGIN
    $IF DBMS_DB_VERSION.VER_LE_10
    $THEN
        DBMS_OUTPUT.PUT_LINE('VERSION 10 CODE HERE');
    $ELSIF DBMS_DB_VERSION.VER_LE_11
    $THEN
        DBMS_OUTPUT.PUT_LINE('VERSION 11 CODE HERE');
    $ELSE
        DBMS_OUTPUT.PUT_LINE('CODE ONLY WORKS ON 10 AND 11');
    $END
END;
/


-- PACAKGE TO HOLD DEBUG SETTINGS
CREATE OR REPLACE PACKAGE debug_flags AS 
    v_debug_level NUMBER := 2;
END;
/

-- PROCEDURE THAT REFEREENCES DEBUG 
CREATE OR REPLACE PROCEDURE debuggable (p_id NUMBER) AS
    v_local NUMBER := 1;
BEGIN
    IF debug_flags.v_debug_level > 0 THEN
        DBMS_OUTPUT.PUT_LINE('p_id '|| p_id);
    END IF;
    FOR counter IN 1..p_id LOOP
        v_local := v_local * p_id;
        IF debug_flags.v_debug_level > 1 THEN
            DBMS_OUTPUT.PUT_LINE(counter || ' v_local '|| v_local);
        END IF;
    END LOOP;
END;
/


-- CODE WILL GET RECOMPLILED WHEN PACAKGE SETTING CHANGE
BEGIN
    debuggable(11);
END;
/



CREATE OR REPLACE PROCEDURE debuggable (p_id NUMBER) AS
    v_local NUMBER := 1;
BEGIN
    $IF debug_flags.v_debug_level > 0  $THEN
 --   $IF debug_flags.v_show_params $THEN 
        DBMS_OUTPUT.PUT_LINE('p_id '|| p_id);
    $END
    FOR counter IN 1..p_id LOOP
        v_local := v_local * p_id;
        $IF debug_flags.v_debug_level > 1 $THEN
        --   $IF debug_flags.v_show_loop $THEN 
            DBMS_OUTPUT.PUT_LINE(counter || ' v_local '|| v_local);
        $END
    END LOOP;
END;
/


-- DEBUG PACAKGE WITH BOOLEN CONSTANT
CREATE OR REPLACE PACKAGE debug_flags AS
    v_show_params CONSTANT BOOLEAN := TRUE;
    v_show_loop CONSTANT BOOLEAN := TRUE;
END;
/


CREATE OR REPLACE PROCEDURE debuggable (p_id NUMBER) AS
    v_local NUMBER := 1;
BEGIN
    $IF debug_flags.v_show_params $THEN 
        DBMS_OUTPUT.PUT_LINE('p_id '|| p_id);
    $END
    FOR counter IN 1..p_id LOOP
        v_local := v_local * p_id;
        $IF debug_flags.v_show_loop $THEN 
            DBMS_OUTPUT.PUT_LINE(counter || ' v_local '|| v_local);
        $END
    END LOOP;
END;
/


BEGIN
    debuggable(11);
END;
/


----------------


-- DEBUG PACAKGE WITH BOOLEN CONSTANT
CREATE OR REPLACE PACKAGE debug_flags AS
    v_show_params CONSTANT BOOLEAN := TRUE;
    v_show_loop CONSTANT BOOLEAN := TRUE;
    v_show_detail CONSTANT BOOLEAN := TRUE;

END;
/


CREATE OR REPLACE PROCEDURE debuggable (p_id NUMBER) AS
    v_local NUMBER := 1;
BEGIN
    $IF debug_flags.v_show_detail $THEN
        DBMS_OUTPUT.PUT_LINE($$PLSQL_CODE_TYPE);
        $IF DBMS_DB_VERSION.VER_LE_9 $THEN
            NULL;
        $ELSE
            DBMS_OUTPUT.PUT_LINE($$PLSQL_OPTIMIZE_LEVEL);
        $END
    $END
    $IF debug_flags.v_show_params $THEN 
        DBMS_OUTPUT.PUT_LINE('p_id '|| p_id);
    $END
    FOR counter IN 1..p_id LOOP
        v_local := v_local * p_id;
        $IF debug_flags.v_show_loop $THEN 
            DBMS_OUTPUT.PUT_LINE(counter || ' v_local '|| v_local);
        $END
    END LOOP;
END;
/


BEGIN
    debuggable(11);
END;
/


-- $ERROR DIRECTIVE TO ENSURE CODE DOES NOT COMPILE AND GET USED
CREATE OR REPLACE PROCEDURE for_version_11_only AS
BEGIN
    $IF DBMS_DB_VERSION.VERSION <> 11 THEN
    $ERROR
    'DONT RUN THIS ON ANYTHING EXCEPT 11'
    $END
    $END
END;
/


---------------------------------------------------------
-- PLSQL OPTIMIZED LEVEL
---------------------------------------------------------
--SET LEVEL FOR CODE OPTIMIZATION DURING COMPLIALTION
-- THE HIGHER THE SETTING THE MORE OPTIMATION DONE
---------------------------------------------------------
-- SET OPTIMIZE LEVEL
ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 3;

-- ENABLE COMPLIER MESSAGE TO EXPLAIN OPTIMIZATION
ALTER SESSION SET PLSQL_WARNINGS="ENABLE:INFORMATIONAL";

--  CREATE PROCEDURE WITH UNCALLED CODE
CREATE OR REPLACE PROCEDURE optimize_me AS
    FUNCTION will_never_get_called
        RETURN NUMBER AS
        BEGIN
            RETURN (11);
        END;
        BEGIN
            DBMS_OUTPUT.PUT_LINE('HELLO');
        END;
/

--CREATE PROCEUDE WITH OPPRTUNITY FOR INLINING
CREATE OR REPLACE PROCEDURE optimize_me AS
    v_number NUMBER;
    FUNCTION  call_me RETURN NUMBER AS
    BEGIN
        RETURN (11);
    END;
    BEGIN
        v_number := call_me;
    END;
/


ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 3;



CREATE OR REPLACE PROCEDURE optimize_me AS
    v_dummy VARCHAR2(1);
BEGIN
    SELECT NULL INTO v_dummy
    FROM DUAL;
END;
/