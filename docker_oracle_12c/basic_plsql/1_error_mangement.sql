prompt >>> PLSQL has two types of Errors: COMPILATION and RUN-TIME errors
prompt --- COMPILATION ERROR occurs when you make an error typing the program or defining the program
prompt -- RUN-TIME ERROR occurs when actual data fails to meet the rules defined by your program unit
SET SERVEROUTPUT ON;

prompt "------Exception handling"

DECLARE
	a VARCHAR2(1);
	b VARCHAR2(2) := 'AB';
BEGIN
	a := b;
EXCEPTION
	WHEN value_error THEN
		dbms_output.put_line('You can''t put ['||b||'] in one character string.');
END;
/ 

prompt ------Local Error handling 

DECLARE
	a NUMBER;
BEGIN
	DECLARE
		b VARCHAR2(2);
	BEGIN
		SELECT 1 INTO b FROM DUAL WHERE 1 = 2;
		a := b;
	EXCEPTION
		WHEN value_error THEN
			dbms_output.put_line('You can''t put ['||b||'] in one character string');
	END;
EXCEPTION
	WHEN others THEN
		dbms_output.put_line('Caught in outer block ['||SQLERRM||'].');
END;
/

prompt -------Manually raise a User-define exception 

DECLARE
	a NUMBER;
	e EXCEPTION;
BEGIN
	DECLARE
		b VARCHAR2(2) := 'AB';
	BEGIN
		RAISE e;
	EXCEPTION
		WHEN others THEN
			a := b;
			dbms_output.put_line('Does not reach this line.');
	END;
EXCEPTION
	WHEN others THEN
		dbms_output.put_line('Caught in outer block ['||SQLCODE||'].');
END;
/


prompt ---- Dynamic assignment problem in stored programming unit

prompt ------------------------------------------------------------------------------

prompt Good PL/SQL coding practices avoid dynamic assignments in declaration blocks.
prompt ------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION runtime_error ( variable_in VARCHAR2)
RETURN VARCHAR2 IS
	a VARCHAR2(1) := variable_in;
BEGIN
	RETURN NULL;
EXCEPTION
	WHEN others THEN
		dbms_output.put_line('Function error');
END;
/


SELECT runtime_error ('AB') FROM DUAL;



