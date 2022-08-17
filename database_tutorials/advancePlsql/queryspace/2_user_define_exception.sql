prompt ------------------------------------------------------------------------------

prompt Exception management Built-in Functions
prompt User-Define Execptions :  2 Types - 1) Declare in EXCEPTION variable in Declaration block
prompt      2) Build dynamic exception in exception block by calling RAISE_APPLICATION_ERROR function
prompt ------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

prompt -- TWO - STEP declaration process let you declare and map it to a number

DECLARE 
	e EXCEPTION;
BEGIN
	RAISE e;
	dbms_output.put_line('Can''t get here.');
	EXCEPTION
		WHEN OTHERS THEN
			IF SQLCODE = 1 THEN		
				dbms_output.put_line('This is a ['||SQLERRM||']');
			END IF;
END;
/


prompt -- THE SECOND step declares a PRAGMA. It a COmpiler directive. EXCEPTION_INIT diectove to map to an error code

DECLARE
	a VARCHAR2(20);
	invalid_userenv_parameter EXCEPTION;
	PRAGMA EXCEPTION_INIT(invalid_userenv_parameter, -2003);
BEGIN
	a := SYS_CONTEXT('USERENV','PROXY_PUSHER');
EXCEPTION
	WHEN invalid_userenv_parameter THEN
		dbms_output.put_line(SQLERRM);
END;
/


prompt -- DYNAMIC user-define Exceptions

prompt -- Raising Dynamic exception without previously declaring a user defined EXCEPTION variable
BEGIN
	RAISE_APPLICATION_ERROR(-20001, 'A not too original message.');
EXCEPTION
	WHEN others THEN
		dbms_output.put_line(SQLERRM);
END;
/

 
prompt -- Declaring, mapping a user-defined error code to an EXCEPTION variable, and settign message dynamically

DECLARE
	e EXCEPTION;
	PRAGMA EXCEPTION_INIT(e,-20001);
BEGIN
	RAISE_APPLICATION_ERROR(-20001,'A less than original message.');
EXCEPTION
	WHEN e THEN
		dbms_output.put_line(SQLERRM);
END;
/


prompt --- Exception Stack Functions

prompt ----- Exception stack management
--ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 1;
--ALTER SESSION SET PLSQL_WARNINGS='ENABLE:ALL';


CREATE OR REPLACE PROCEDURE handle_errors
	( object_name 	IN	VARCHAR2
	, module_name	IN	VARCHAR2 := NULL
	, table_name	IN	VARCHAR2 := NULL
	, sql_error_code	IN	NUMBER := NULL
	, sql_error_message	IN	VARCHAR2 := NULL
	, user_error_message	IN	VARCHAR2 :=  NULL) IS
	
	-- Define local exception
	raised_error EXCEPTION;
	-- Define a collection type and initialize it
	TYPE error_stack IS TABLE OF VARCHAR2(80);
	errors ERROR_STACK := error_stack();
	-- Define a local function to verify object type
	FUNCTION object_type
		( object_name_in 	IN 	VARCHAR2)
	RETURN VARCHAR2 IS
		return_type VARCHAR2(12) := 'Unidentified';
	BEGIN
		FOR I IN (SELECT object_type
				FROM user_objects
				WHERE object_name = object_name_in ) LOOP
		return_type := i.object_type;
		END LOOP;
		RETURN return_type;
	END object_type;
	
	BEGIN
		-- allocate space and assign a value to collection.
		errors.EXTEND;
		errors(errors.COUNT) := object_type(object_name)||' ['||object_name||']';

		-- substitute actual parameters for default values
		IF module_name IS NOT NULL THEN
			errors.EXTEND;
                	errors(errors.COUNT) := 'Modeule Name: ['||module_name||']';
		END IF;
	 	IF table_name IS NOT NULL THEN
                        errors.EXTEND;
                        errors(errors.COUNT) := 'Table Name: ['||table_name||']';
                END IF;
		IF sql_error_code IS NOT NULL THEN
                        errors.EXTEND;
                        errors(errors.COUNT) := 'SQLCODE Value: ['||sql_error_code||']';
                END IF;
		IF sql_error_message IS NOT NULL THEN
                        errors.EXTEND;
                        errors(errors.COUNT) := 'SQLERRM Value: ['||sql_error_message||']';
                END IF;
		IF user_error_message IS NOT NULL THEN
                        errors.EXTEND;
                        errors(errors.COUNT) := user_error_message;
                END IF;

		errors.EXTEND;
		errors(errors.COUNT) := '----------------------------------------';
  		RAISE raised_error;
	EXCEPTION
		WHEN raised_error THEN
			FOR i IN 1..errors.COUNT LOOP
				dbms_output.put_line(errors(i));
			END LOOP;
		RETURN;
	END;
/

CREATE OR REPLACE PROCEDURE error_level3 IS
 	one_character	VARCHAR2(1);
	two_character	VARCHAR2(2)  := 'AB';
	local_object	VARCHAR2(30) := 'ERROR_LEVEL3';
	local_module	VARCHAR2(30) := 'MAIN';
	local_table		VARCHAR2(30) :=  NULL;
	local_user_message	VARCHAR2(80) :=  NULL;
BEGIN
  	one_character := two_character;
EXCEPTION
  	WHEN others THEN
   	 	handle_errors( object_name => local_object
                	 , module_name => local_module
                 	 , sql_error_code => SQLCODE
                 	 , sql_error_message => SQLERRM );
    	RAISE;
END error_level3;
/


CREATE OR REPLACE PROCEDURE error_level2 IS
  local_object	VARCHAR2(30) := 'ERROR_LEVEL2';
  local_module	VARCHAR2(30) := 'MAIN';
  local_table	VARCHAR2(30) :=  NULL;
  local_user_message	VARCHAR2(80) :=  NULL;
BEGIN
  error_level3();
EXCEPTION
  WHEN others THEN
    handle_errors( object_name => local_object
                 , module_name => local_module
                 , sql_error_code => SQLCODE
                 , sql_error_message => SQLERRM );
    RAISE;
END error_level2;
/

CREATE OR REPLACE PROCEDURE error_level1 IS
  local_object VARCHAR2(30) := 'ERROR_LEVEL1';
  local_module VARCHAR2(30) := 'MAIN';
  local_table  VARCHAR2(30) :=  NULL;
  local_user_message VARCHAR2(80) :=  NULL;
BEGIN
  error_level2();
EXCEPTION
  WHEN others THEN
    handle_errors( object_name => local_object
                 , module_name => local_module
                 , sql_error_code => SQLCODE
                 , sql_error_message => SQLERRM );
    RAISE;
END error_level1;
/


BEGIN
  error_level1;
END;
/




