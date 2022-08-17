/*
||	Author: Raahool Kumeriya
||	
||	Purpose: approve draft invoice 
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
prompt 		testing of assert pacakge		  ;
prompt ---------------------------------------------------;

DECLARE
	l_invoice_id	NUMBER default 100001;
	l_invoiceid	NUMBER;
BEGIN
	/*
		Purpose: approve Draft invoice
	
		Remarks:
		
		Date		WHo		Description
		----------	---------	--------------------------
		26.JUN.2022	codelocked	Created
	*/

	assert_error_pkg.assert(
			p_condition => l_invoice_id is not null, 
			p_error_message => 'Invoice not found!');

	assert_error_pkg.assert(l_invoiceid is not null, 'Invoice id not found!!!!!!');

END;
/	
