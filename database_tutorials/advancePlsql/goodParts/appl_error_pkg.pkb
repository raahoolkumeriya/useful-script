/*
||	Author: Raahool Kumeriya
||	
||	Purpose: Package handles invoices
||
||	Change history:
||	Date		Who		Description
||	----------	----------	-----------------------------------
||	26-JUN-2022  	codelocked	Program Created
*/

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 		Assertion package	;
prompt ---------------------------------------------------;


-- Assert Implmentation 
CREATE OR REPLACE PACKAGE body assert_error_pkg
IS
        PROCEDURE assert ( p_condition IN boolean, 
			   p_error_message IN VARCHAR2)
	IS
	BEGIN
		/*
		||	Purpose: raise exception if condition is not true
		||
		||	Remarks:
		||	Date		Who		Description
		||	-----------	----------	----------------------------------
		||	26-JUN-2022	codelocked	Created
		*/
	
		IF NOT NVL(p_condition, false) THEN
			RAISE_APPLICATION_ERROR (-20000, p_error_message);
		END IF;	
	
	END assert;

END assert_error_pkg;
/

SHOW ERRORs;


