-----------------------------------
-- PACKAGES SPECIFICATION

-- AKA PACKAGE HEADER
-- EXPOSES PROCEDURE AND FUNCTIONS
    -- SUBSET OF THOSE IN PACKAGE BODY
-- EXPOSES SOME VARIABLES
    -- MAINTIAN VALUES FOR CURRENT SESSIONS
    -- OR RECOMILATION
--DO NOT CONTAIN ACTUAL CODE
-----------------------------------

--create a package or replace an exusting
CREATE OR REPLACE PACKAGE a_pkg AS 
    v_variable NUMBER := 11;
    
    PROCEDURE a_proc (p_id NUMBER);
    FUNCTION a_func (p_id NUMBER) RETURN NUMBER;
END;
/


SELECT OBJECT_NAME,
        OBJECT_TYPE,
        STATUS
    FROM USER_OBJECTS
    WHERE OBJECT_NAME = 'A_PKG';
    

-- AS IT IS VALID OBJECT WE CAN MAKE A CALL 
-- BUT IT FAIL AS NO DIECT EXECUTE CODE FAIL AS TEHR IS NO ASSOCIATE CODE 

BEGIN
    a_pkg.a_proc(1);
END;
/

-- OUTPUT A PACAKGE VARIABLE
BEGIN
    DBMS_OUTPUT.PUT_LINE(a_pkg.v_variable);
END;
/


-- MODIFY AND OUTUT A PACAKGE VARIABLE
BEGIN
    DBMS_OUTPUT.PUT_LINE(a_pkg.v_variable);
    a_pkg.v_variable := a_pkg.v_variable * 2;
    DBMS_OUTPUT.PUT_LINE(a_pkg.v_variable);
END;
/


-- COMPILE (AND RESET ) A PACAKGE
ALTER PACKAGE a_pkg COMPILE;


-- CREATE A PROCEDURE THAT CALL THE PACKAGE
CREATE OR REPLACE PROCEDURE A_PROC AS
BEGIN
    a_pkg.a_proc(2);
END;
/


BEGIN
    a_proc;
END;
/


-- QUERY DEPENCEY FORM THE DATABASE
SELECT NAME, TYPE, REFERENCED_NAME,REFERENCED_TYPE
FROM USER_DEPENDENCIES
WHERE NAME IN ('A_PKG','A_PROC')
AND REFERENCED_NAME IN ('A_PKG','A_PROC');

-- CHECK STATUS OF PROCEUDRE THAT CALLS
--PACAKGE
SELECT OBJECT_NAME,
        OBJECT_TYPE,
        STATUS
    FROM USER_OBJECTS
    WHERE OBJECT_NAME = 'A_PROC';


----------------------------------------------------------
-- PACAKGE BODIES
----------------------------------------------------------
-- CONTAINS PROCEUDRE AND FUNCTIONS
    -- THOSE IN PACKAGE SPECIFACTION
    -- PLUS PRIVATE ONES
    -- INCLUED CODES
-- PRIVATE VARIABELS
    -- MAINTIAN VALUES FOR CURRENT SESSION
    -- OR RECOMPILATION
----------------------------------------------------------

-- CREATE A PACAKGE OR REPALCE AN EXISTING ONE
-- THIS IS ONE MISSING A FUNCTION DECLARION IN HEADER

CREATE OR REPLACE PACKAGE BODY a_pkg AS
    PROCEDURE a_proc (p_id NUMBER) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(p_id);
    END;
END;
/

-- CREATE PACAKGE BODY TO MATCH HEADER AND 
-- INCLUDE A FUNCTION THAT IS PROVATE TO THE PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY a_pkg AS
    v_another_variable NUMBER := 11;
    
    PROCEDURE a_proc (p_id NUMBER) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(p_id);
    END;
    
    FUNCTION a_func (p_id NUMBER ) RETURN NUMBER AS
    BEGIN
        RETURN(p_id);
    END;
    
    FUNCTION only_in_body RETURN NUMBER AS
    BEGIN
        NULL;
    END;
END;
/
--CHECK FOR OBJECTS IN DB
SELECT OBJECT_NAME,
        OBJECT_TYPE,
        STATUS
    FROM USER_OBJECTS
    WHERE OBJECT_NAME = 'A_PKG';

--TRY TO EXECUTE PROCEDURE IN PAKCAGE
BEGIN
    a_pkg.a_proc(99);
end;
/

CREATE OR REPLACE PROCEDURE a_proc AS 
BEGIN
    a_pkg.a_proc(66);
END;
/

-- CREATE PROCEIURE TO CALL PACKAGE
BEGIN
    a_proc;
END;
/

-- QUERY DEPENCEY FORM THE DATABASE
SELECT NAME, TYPE, REFERENCED_NAME,REFERENCED_TYPE
FROM USER_DEPENDENCIES
WHERE NAME IN ('A_PKG','A_PROC')
AND REFERENCED_NAME IN ('A_PKG','A_PROC');


--------------------------------------------------------------
-- PACAKGE PRIVATE AND PUBLIC 
------------------------------------------------------------
--  PUBLIC = ACCESSIBEL FROM CODE OUTSIDE THE PACAKGE
--  PRIVATE = ACCESSIBLE FROM WITHIN PACAKGE BODY ONLY
-- GET AND SET ROUTINES
        -- MALE PRIVATE VARIABLES PUBLICLY ACCESSIBLE
--------------------------------------------------------------

-- CREATE PACKGE OR REPLACE AND EXITING ONE
CREATE OR REPLACE PACKAGE a_pkg AS 
    v_public_variable VARCHAR2(100) := 'PUBLIC';
    
    FUNCTION get_private RETURN VARCHAR2;
    
    PROCEDURE set_private (p_value VARCHAR2);
    
END;
/

CREATE OR REPLACE PACKAGE BODY a_pkg AS
    v_private_variable VARCHAR2(100) := 'PRIVATE';
END;
/


-- OUTPUT AND SET A PUBLIC VARAIBLE
BEGIN
    DBMS_OUTPUT.PUT_LINE(a_pkg.v_public_variable);
    a_pkg.v_public_variable := a_pkg.v_public_variable ||'1';
    DBMS_OUTPUT.PUT_LINE(a_pkg.v_public_variable);
END;
/

-- TRY TO OUTPUT A PACAKGE BODY VARIBALE DIRECTLY 
BEGIN
    DBMS_OUTPUT.PUT_LINE(a_pkg.v_private_variable);
END;
/

-- WAY TO ARROUND THAT WE HAVE GET_ROUTINES

CREATE OR REPLACE PACKAGE BODY a_pkg AS
    
    v_private_variable VARCHAR2(100) := 'PRIVATE';
    
    -- DEFINE A FUNCTION TO RETURN THE PRVATE VARIABLE
    FUNCTION get_private RETURN VARCHAR2 IS
    BEGIN
        RETURN(v_private_variable);
    END;

    -- DEFINE A PROCEDURE TO SET THE LOCAL VARAIBLE
    PROCEDURE set_private (p_value VARCHAR2) AS
    BEGIN
        v_private_variable := p_value;
    END; 
END;
/

-- ATTEMPT TO ACCESS PACAKGE BODY FUNITON WITH CALL
-- NOT WORK UNTIL DECALRE IN HEADER
BEGIN
    DBMS_OUTPUT.PUT_LINE(a_pkg.get_private);
END;
/


-- ATTEMPT TO ACCESS PACKAGE BODY FUCNTION WHICH WILL 
-- NOT WORK UNTIL DEECLARE IN HEADER
BEGIN
    a_pkg.set_private('ABC');
     DBMS_OUTPUT.PUT_LINE(a_pkg.get_private);
END;
/

-----------------------------------------------
-- CALLING DATABASE PACAKGE
----------------------------------------------
-- PROCEDURES 
    -- IN PARAMTER
    -- OUT PARAAMETER
    -- IN OUT PARAMETER
-- FUNCTIONS
-- PUBLIC VARIABLES
-- PUBLIC CURSORS
----------------------------------------------

--PACAKGE WITH PROCEDURE WITH IN OUT PARAMETERS
CREATE OR REPLACE PACKAGE in_and_out AS
    
    PROCEDURE in_and_out ( p_in IN  NUMBER,
                           p_out OUT NUMBER,
                           p_in_and_out IN OUT NUMBER);
END;
/

CREATE OR REPLACE PACKAGE BODY in_and_out AS
    PROCEDURE in_and_out  (p_in IN  NUMBER,
                        p_out OUT NUMBER,
                        p_in_and_out IN OUT NUMBER) AS
    BEGIN
        p_out := p_in * 10;
        p_in_and_out := p_in_and_out * p_out;
    END;
END;
/


--CALL PROCEDURE IN PACKAGE WITH THE OUT PARAMERTER
 DECLARE
    v_in    NUMBER := 1;
    v_out   NUMBER;
    v_in_and_out NUMBER := 3;
BEGIN
    in_and_out.in_and_out(v_in,v_out,v_in_and_out);
    DBMS_OUTPUT.PUT_LINE(v_in||' '||v_out||' '||v_in_and_out);
END;
/
 
 
 
 -- PACAKGE WITH FUNCTION
CREATE OR REPLACE PACKAGE functional AS
    FUNCTION func_one (p_id NUMBER) RETURN NUMBER;
END;
/

CREATE OR REPLACE PACKAGE BODY functional AS
    FUNCTION func_one (p_id NUMBER) RETURN NUMBER AS
    BEGIN
        RETURN(p_id*10);   
    END;
END;
/

--CALLING FUNCTION IN A PAKCAGE
BEGIN
    DBMS_OUTPUT.PUT_LINE(functional.func_one(9));
END;
/



-- PACAKGE WIT PUBLIC VARIABELS
CREATE OR REPLACE PACKAGE public_var AS 
    v_public_var NUMBER := 1;
END;
/

BEGIN
    FOR counter IN 1..5 LOOP
       public_var.v_public_var := public_var.v_public_var + counter;
        dbms_output.PUT_LINE(public_var.v_public_var);
    END LOOP;
END;
/




--- PACAKGE WITH CURSOR
CREATE OR REPLACE PACKAGE cursors AS 
    CURSOR cur_get_animal (p_id NUMBER) IS
        SELECT * FROM ANIMAL
        WHERE animal_id = p_id;
END;
/


-- PROCEDURE TO USE THE PACAKG ECURSOR
DECLARE
    v_local_animal cursors.cur_get_animal%ROWTYPE;
BEGIN
    OPEN cursors.cur_get_animal(2);
    FETCH cursors.cur_get_animal INTO v_local_animal;
    DBMS_OUTPUT.PUT_LINE(v_local_animal.ANIMAL_NAME);
    CLOSE cursors.cur_get_animal;
END;
/