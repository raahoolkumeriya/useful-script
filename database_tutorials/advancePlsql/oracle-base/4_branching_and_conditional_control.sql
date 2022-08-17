/*
|	Program: Branching and COnditonal control 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE
	l_day 	VARCHAr2(10);
BEGIN
	l_day := TRIM(TO_CHAR(SYSDATE,'DAY'));
	
	IF l_day = 'SATURDAY' THEN
		DBMS_OUTPUT.PUT_LINE('The weekend just started!');
	ELSIF l_day =  'SUNDAY' THEN
		DBMS_OUTPUT.PUT_LINE('The weekend is nearly over!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('It''s not the weekend yet!');
	END IF;
END;
/

prompt -----------------------------------;
prompt case statements;
prompt -----------------------------------;

DECLARE
	l_day VARCHAR2(10);
BEGIN
	l_day := TRIM(TO_CHAR(SYSDATE,'DAY'));
	CASE l_day 
		WHEN 'SATURDAY' THEN
			DBMS_OUTPUT.PUT_LINE('The weekend has just started!');
		WHEN 'SUNDAY' THEN
			DBMS_OUTPUT.PUT_LINE('The weekend nearly over!');
		ELSE
			DBMS_OUTPUT.PUT_LINE('It''s not the weekend!');
	END CASE;
END;
/
	
	
