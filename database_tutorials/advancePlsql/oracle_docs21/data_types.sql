/*
||	Author: Raahool Kumeriya
||	
||	Purpose: Data types 
||
||	Change history:
||	Date		Who		Description
||	----------	----------	-----------------------------------
||	27-JUN-2022  	codelocked	Program Created
*/

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 			Data types			  ;
prompt ---------------------------------------------------;

DECLARE
	a 	CHAR(10) := 'nikki ';
	b	VARCHAR(10) := 'dikki ';
	c	VARCHAR2(10) := 'sikki ';
BEGIN
	DBMS_OUTPUT.put_line('*' || a || '*');
	DBMS_OUTPUT.put_line('*' || b || '*');
	DBMS_OUTPUT.put_line('*' || c || '*');
END;
/

