/*
|	Program: Blocks
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt -------------------------------------;
prompt Simplest valid PLSQL block;
prompt -------------------------------------;

BEGIN
	NULL;
END;
/

prompt -------------------------------------;
prompt Variable scope
prompt -------------------------------------;

DECLARE
	l_number NUMBER;
BEGIN
	l_number := 1;
	DBMS_OUTPUT.PUT_LINE('Outer block --> '||l_number);
	BEGIN
		l_number := 2;
		DBMS_OUTPUT.PUT_LINE('Inner block --> '||l_number);
	END;
	DBMS_OUTPUT.PUT_LINE('Outer block --> '||l_number);
END;
/


prompt -------------------------------------;
prompt Importance of Exception for trapping errors;
prompt -------------------------------------;

DECLARE
	l_date DATE;
BEGIN
	SELECT SYSDATE INTO l_date FROM
	DUAL WHERE 1=2; --for zero rows
	/*
	|	With exception block it will throw error 
	| 	ORA-01403: no data found
	*/
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No records retruns form query!');
	
END;
/
 
	
prompt -------------------------------------;
prompt Variables and COnstatnts;
prompt -------------------------------------;

DECLARE
	l_string 	VARCHAR2(20);
	l_number	NUMBER(10);
	l_con_string	CONSTANT VARCHAR2(20) := 'This is a constant';
BEGIN
	l_string := 'Varaible';
	l_number := 1;
	l_con_string := 'This will fail';
END;
/
