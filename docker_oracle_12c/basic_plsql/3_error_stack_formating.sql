prompt Error Stack Formatting
prompt -----------------------------------------------------

SET SERVEROUTPUT ON;

prompt "DBMS_UTILITY package" 

CREATE OR REPLACE PROCEDURE error_level3 IS
	one_charater	VARCHAR2(1);
	two_charater	VARCHAR2(2) := 'AB';
	local_object	VARCHAR2(30) := 'ERROR_LEVEL3';
	local_module	VARCHAr2(30) := 'MAIN';
	local_table	VARCHAR2(30) := NULL;
	local_user_message	VARCHAr2(80) := NULL;
BEGIN
	one_charater := two_charater;
EXCEPTION
	WHEN others THEN
		handle_errors(object_name => local_object
			      ,module_name => local_module
			      ,sql_error_code => SQLCODE
			      ,sql_error_message => SQLERRM
                              ,user_error_message => DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
	RAISE;
END error_level3;
/

/*
BEGIN
	error_level3();
END;
/
*/



COL line FORMAT 999
COL text FORMAT A60

SELECT   line
,        text
FROM     user_source
WHERE    name = 'ERROR_LEVEL3'
AND      line = 9;

