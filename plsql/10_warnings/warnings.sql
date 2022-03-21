-------------------------------------------------
-------- plsql WARNINGS
--------------------------------------------------
-- WARNING GEENRATED WHEN CODE IS COMPILEE
-- THREE CATEGORIES
    -- PERFORMANCE
    -- INFORMATIONAL
    -- SEVERE
-- THREE SETTINGS
    -- ENABLE 
    -- DISABLE
    -- ERROR
----------------------------------------------------

CREATE OR REPLACE PROCEDURE abc AS 
    v_var NUMBER := 99;
    FUNCTION not_used RETURN NUMBER IS
    BEGIN
        RETURN (11);
    END;
    BEGIN
    IF v_var <> 99 THEN
        DBMS_OUTPUT.PUT_LINE('ABC');
    ELSE
           DBMS_OUTPUT.PUT_LINE('NOT ABC');
    END IF;
END;
/
    
SELECT NAME, ATTRIBUTE, TEXT, MESSAGE_NUMBER, LINE, POSITION
FROM USER_ERRORS ORDER BY NAME, SEQUENCE;

-- JUST WANT TO SEE WHAT THESE RETURN 
ALTER SESSION SET PLSQL_WARNINGS="ENABLE:INFORMATIONAL","ENABLE:SEVERE";


-- WANT ANY OF THESE TO STOP COMPLIATION
ALTER SESSION SET PLSQL_WARNINGS="ERROR:INFORMATIONAL","ERROR:SEVERE";


-- WANT TO SEE THE SEVERS ONES OUT WANT INFORMATIONAL ONES TO STOP COMPLIATION
ALTER SESSION SET PLSQL_WARNINGS="ERROR:INFORMATIONAL","ENABLE:SEVERE";


-- WANT TO ABOTUT AUTHID MESSAGE (5018) BUT ANY OTHER SERVER ONES OR
-- INFOMAIONAL ONES WILL STOP COMPLIATION
ALTER SESSION SET PLSQL_WARNINGS='ERROR:INFORMATIONAL','ERROR:SEVERE','ENABLE:05018';


-- WANT TO IGNORE AUTHID MESSAGE (5018) BUT ANY OTHER SERVER ONES OR
-- INFOMAIONAL ONES WILL STOP COMPLIATION
ALTER SESSION SET PLSQL_WARNINGS='ERROR:INFORMATIONAL','ERROR:SEVERE','DISABLE:05018';


-- WANT TO IGNORE AUTHID MESSAGE (5018) BUT INFO ON UNCALLED CODE (06006) BUT
-- FAIL ON UNREACHEDBELE CODE
ALTER SESSION SET PLSQL_WARNINGS='ERROR:INFORMATIONAL','ERROR:SEVERE','DISABLE:05018','ENABLE:06006';


-- DONT WANT TO SEE ANYTHING
ALTER SESSION SET PLSQL_WARNINGS='DISABLE:INFORMATIONAL','DISABLE:SEVERE';


------------------------
-- DBMS_WARNING PACKAGE
------------------------

BEGIN
    DBMS_OUTPUT.PUT_LINE(dbms_warning.get_warning_setting_string);
END;
/

BEGIN
    dbms_warning.add_warning_setting_cat('SEVERE','ERROR','SESSION');
    DBMS_OUTPUT.PUT_LINE(dbms_warning.get_warning_setting_string);
END;
/


BEGIN
    --CHECK CATEGORY OF AUTHID MESSAGE
    DBMS_OUTPUT.PUT_LINE(DBMS_WARNING.GET_CATEGORY(5018));
END;
/


ALTER PROCEDURE abc COMPILE PLSQL_WARNINGS='DISABLE:ALL';



SELECT PLSQL_WARNINGS
    FROM USER_PLSQL_OBJECT_SETTINGS
    WHERE NAME = 'ABC';
    
---------------------------------------------------------
-- PLSQL PROFILER
--------------------------------------------------------

-- RECORD EXECUTION DEURATION OF RUNNING CODE
-- DBMS_PROFILER
    -- DATABASE PACAKGE
-- HIERARCHICAL PROFILER 
    -- EXXTERNAL FILE
    -- HTML OUTPUT
---------------------------------------------------------

ALTER SESSION SET PLSQL_WARNINGS='DISABLE:ALL';


CREATE OR REPLACE PROCEDURE ABC AS 
BEGIN
    FOR counter IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(counter);
    END LOOP;
END;
/

DECLARE
    v_runid NUMBER;
BEGIN
    v_runid := DBMS_PROFILER.START_PROFILER;
    DBMS_OUTPUT.PUT_LINE('Run id '||v_runid);
END;
/

BEGIN
    ABC;
END;
/
 
 
 BEGIN 
    dbms_profiler.stop_profiler;
END;
/


SELECT runid 
    FROM PLSQL_PROFILER_RUNS
    WHERE runid = 1;
    

-----------------------------------------------------
-- PLSQL TRACE
----------------------------------------------------
-- TRACE LINES OF CODE EXECUTED
-- DBMS_TRACE PACAKGE
-----------------------------------------------------

CREATE OR REPLACE PROCEDURE ABC AS 
    v NUMBER;
    FUNCTION def RETURN NUMBER IS
    BEGIN 
        RETURN (10);
    END;
    BEGIN
    v := def;
    FOR counter IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(counter);
    END LOOP;
    v := def;
END;
/


BEGIN 
    DBMS_TRACE.SET_PLSQL_TRACE(DBMS_TRACE.TRACE_aLL_CALLS);
    abc;
    DBMS_TRACE.CLEAR_PLSQL_TRACE;
END;
/


SELECT runid
    FROM plsql_tarce_runs;
    
--------------------------------------------------------
------  PLSQL SCOPE
-------------------------------------------------------
-- TRACKS IDNETIFIER IN CODE
    -- VARIABLE
    -- PROCEDURES
    -- AND MORE
-- TRACKS ACCESS BY TYPE
    -- DECLARATION
    -- ASSIGNMENT
    -- AND MORE
-----------------------------------------------------------

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';

CREATE OR REPLACE PROCEDURE abc AS 
    v_variable NUMBER;
BEGIN
    v_variable := 11;
END;
/


-- SEE WHAT IDNENTIIFEISHAV BEEN LAODED
SELECT * FROM USER_IDENTIFIERS;

-- QUERY HIERARACH IDNEINTIFIERS
SELECT LEVEL,
    OBJECT_NAME,
    OBJECT_TYPE,
    NAME,
    TYPE,
    USAGE,
    LINE
FROM USER_IDENTIFIERS
START WITH USAGE_CONTEXT_ID = 0 
CONNECT BY PRIOR USAGE_ID = USAGE_CONTEXT_ID
ORDER SIBLINGS BY LINE, COL;



CREATE OR REPLACE PACKAGE pkg AS
    v_variable NUMBER := 22;
    PROCEDURE pkg_abc;
END;
/

CREATE OR REPLACE PACKAGE BODY pkg AS 
    PROCEDURE pkg_abc IS
    BEGIN
       ABC;   
    END;
END;
/



SELECT LPAD('=',LEVEL,'=') ||' ' ||
        LEVEL       || ' '||
        OWNER       || ' '||
        OBJECT_NAME || ' '||
        OBJECT_TYPE || ' '||
        NAME        || ' '||
        TYPE        || ' '||
        USAGE       || ' '||
        LINE        || ' '||
        (SELECT TEXT
          FROM USER_SOURCE
            WHERE NAME = OBJECT_NAME
                AND TYPE = OBJECT_TYPE
                AND LINE = ai.LINE) FULL_OUTPUT
        FROM ALL_IDENTIFIERS ai
        WHERE OWNER <> 'SYS'
            AND OWNER <> 'PUBLIC'
            AND USAGE <> 'REFERENCE'
        START WITH USAGE_CONTEXT_ID = 0
        CONNECT BY PRIOR USAGE_ID = USAGE_CONTEXT_ID
        ORDER SIBLINGS BY LINE, COL;
        
-- WHICH VARIABELS?
SELECT OBJECT_TYPE,
    SIGNATURE
FROM USER_IDENTIFIERS
WHERE NAME = 'V_VARIABLE';


ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

ALTER PACKAGE pkg COMPILE PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';
ALTER PROCEDURE abc COMPILE;