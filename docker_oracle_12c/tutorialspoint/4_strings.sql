/*
|	Program: Strings
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE
	name 	VARCHAr2(20);
	company	VARCHAR2(30);
	introduction 	CLOB;
	choice	CHAR(1);
BEGIN
	name 	:= 'Raahool Kumeriya';
	company	:= 'Codelocked';
	introduction := 'Hello! I''m ' || INITCAP(name) ||' from ' || upper(company);
	choice	:= 'y';
	IF choice = 'y'
	THEN
		DBMS_OUTPUT.put_line(name);
		DBMS_OUTPUT.put_line(company);
		DBMS_OUTPUT.put_line(introduction);
	END IF;
END;
/

DECLARE
	greetings VARCHAR2(20) := 'Hello Codelocked';
BEGIN
	DBMS_OUTPUT.put_line('CONCAT 	: '||CONCAT(greetings, ' . '));
	DBMS_OUTPUT.put_line('INSTR 	: '||INSTR(greetings, 'llo'));
	DBMS_OUTPUT.put_line('INITCAP	: '||INITCAP(greetings));
	DBMS_OUTPUT.put_line('LENGTH	: '||LENGTH(greetings));
	DBMS_OUTPUT.put_line('LOWER	: '||LOWER(greetings));
	DBMS_OUTPUT.put_line('UPPER	: '||UPPER(greetings));
	DBMS_OUTPUT.put_line('LTRIM	: '||LTRIM(greetings, 'Hello'));	
	DBMS_OUTPUT.put_line('REPLACE	: '||REPLACE(greetings, 'Hello', 'BOLLO'));	
	DBMS_OUTPUT.put_line('RTRIM	: '||RTRIM(greetings, 'ed'));	
	DBMS_OUTPUT.put_line('SUBSTR	: '||SUBSTR(greetings, 7, 4));	
END;	
/	
