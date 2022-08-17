prompt >>>> Conditional statements <<<

SET SERVEROUTPUT ON;

prompt ----- Comparison AND
BEGIN
	IF 1 = 1 AND 2 = 2 THEN
		dbms_output.put_line('Conditional AND : True.');
	END IF;
END;
/

prompt ----- Comparison BETWEEN
BEGIN
	IF 1 BETWEEN 1 AND 3 THEN
		dbms_output.put_line('Conditional BETWEEN : In the range.');
	END IF;
END;
/

prompt ------ Comparison IN
BEGIN
	IF 1 IN (1,2,3) THEN
		dbms_output.put_line('Conditional IN : in the set.');
	END iF;
END;
/

prompt ------ Comparison IS EMPTY
DECLARE
	TYPE list IS TABLE OF INTEGER;
		a LIST := list();
BEGIN
	IF a IS EMPTY THEN
		dbms_output.put_line('Comparison IN EMPTY : "a" is empty.');
	END IF;
END;
/

prompt ------ Comparison IS NULL
DECLARE
	var BOOLEAN;
BEGIN
	IF var IS NULL THEN
		dbms_output.put_line('Comaprision IS NULL : It is null.');
	END IF;
END;
/

prompt ------ Comparison IS A SET
DECLARE
	TYPE list IS TABLE OF INTEGER;
	a LIST := list();
BEGIN
	IF a IS A SET THEN
		dbms_output.put_line('Comparison IS A SET : "a" is a set.');
	END IF;
END;
/

prompt ------ Comparison LIKE
BEGIN
	IF 'Str%' LIKE 'String' THEN
		dbms_output.put_line('Comparison LIKE : match.');
	END IF;
END;
/

prompt ------ Comparison MEMBER OF
DECLARE
	TYPE list IS TABLE OF VARCHAR2(100);
	n VARCHAR2(10) := 'One';
	a LIST := list('One', 'Two', 'Three');
BEGIN
	IF n MEMBER OF a THEN
		dbms_output.put_line('Comparison MEMBER OF : "n" is member.');
	END IF;
END;
/

prompt ------- Comaprison NOT
BEGIN
	IF NOT FALSE THEN
		dbms_output.put_line('Comparison NOT : true.');
	END IF;
END;
/

prompt ------ COmparison OR 
BEGIN
	IF 1 = 1 OR 1 = 2 THEN
		dbms_output.put_line('Comparison OR : True.');
	END IF;
END;
/

prompt ------- Comparison SUBMULTISET
DECLARE
	TYPE list IS TABLE OF INTEGER;
	a LIST := list(1,2,3);
	b LIST := list(1,2,3,4);
BEGIN
	IF a SUBMULTISET b THEN
		dbms_output.put_line('Comparison SUBMULTISET : a is Subset.');
	END IF;
END;
/


prompt ----------------------------------------------

prompt IF-ELSIF-IF

DECLARE 
	equal BOOLEAN NOT NULL := TRUE;
BEGIN
	IF 1 = 1 THEN
		dbms_output.put_line('Condition one met!');
	ELSIF equal THEN
		dbms_output.put_line('Conditon two met!');
	ELSIF 1 = 2 THEN
		dbms_output.put_line('Condition three met!');
	END IF;
END;
/


prompt >>>> SIMPLE CASE 

DECLARE
	selector NUMBER := 0;
BEGIN
	CASE selector 
		WHEN 0 THEN
			dbms_output.put_line('case 0!');
		WHEN 1 THEN
			dbms_output.put_line('case 1!');
		ELSE
			dbms_output.put_line('No Match!');
	END CASE;
END;
/

prompt >>> SEARCHED CASE

BEGIN
	CASE 
		WHEN 1 = 2 THEN
			dbms_output.put_line('Case [1 = 2]');
		WHEN 2 = 2 THEN
			dbms_output.put_line('Case [2 = 2]');
		ELSE
			dbms_output.put_line('No match');
	END CASE;
END;
/

prompt >>>  Conditional Compilation Statements

ALTER SESSION SET PLSQL_CCFLAGS = 'debug:1';

BEGIN
	$IF $$DEBUG = 1 $THEN
		dbms_output.put_line('Debug level 1 Enabled.');
	$END
END;
/

