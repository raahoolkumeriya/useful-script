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

-- Assert Interface ( specification )
CREATE OR REPLACE PACKAGE assert_error_pkg 
	AUTHID DEFINER
IS
	/*
	||	Purpose: Package handles errors
	||
	||	Remarks:
	||	Date		Who		Description
	||	-----------	----------	----------------------------------
	||	26-JUN-2022	codelocked	Created
	*/
	-- rasie exception if condition is not true	
	PROCEDURE assert ( p_condition IN boolean,
			   p_error_message IN VARCHAR2);

END assert_error_pkg;
/

SHOW ERRORs;

