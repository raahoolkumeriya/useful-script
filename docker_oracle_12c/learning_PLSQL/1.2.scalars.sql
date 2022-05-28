/*
|	Program: Scalars
|	Author: Raahool Kumeriya
|	Change history:
|		11-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

---------------------------------------------------------------
-- Scalars Variables: That can hold one and only one value
---------------------------------------------------------------

prompt ------------------------------------;
prompt Basic scalar variables;
prompt ------------------------------------;


DECLARE
	l_vc2	VARCHAR2(1000) 	:= 'ABC';
	l_n	NUMBER		:= 1.23;
	l_i	INTEGER		:= 1.3;
	l_p	PLS_INTEGER	:= 1.4;
BEGIN
	DBMS_OUTPUT.PUT_LINE(l_vc2);
	DBMS_OUTPUT.PUT_LINE(l_n);
	DBMS_OUTPUT.PUT_LINE(l_i);
	DBMS_OUTPUT.PUT_LINE(l_p);
END;
/

prompt ------------------------------------;
prompt Stuff too many characters in;
prompt ------------------------------------;

DECLARE
	l_vc2_1	VARCHAR2(1);
BEGIN
	l_vc2_1 := 'A';
	l_vc2_1 := l_vc2_1 ||'B';
EXCEPTION 
	WHEN VALUE_ERROR THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM||' '||'ERROR: Stuff too many characters in');
END;
/

prompt ------------------------------------;
prompt Cannot put characters into numeric variables
prompt ------------------------------------;

DECLARE
	l_n_t	NUMBER;
BEGIN
	l_n_t := 'ABC';
EXCEPTION 
	WHEN VALUE_ERROR THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM||' '||'Cannot put characters into numeric variables');
END;
/


prompt ------------------------------------;
prompt Simple Demo table
prompt ------------------------------------;
/*
DROP TABLE animal;

CREATE TABLE animal
	( animal_id NUMBER
	, animal_name VARCHAR2(30));


prompt ------------------------------------;
prompt Insert some data
prompt ------------------------------------;

INSERT INTO animal VALUES (1,'Zebra');

COMMIT;
*/

prompt ------------------------------------;
prompt Anchored datatype for query 
prompt Reading data from table 
prompt ------------------------------------;

DECLARE
	l_animal_name	animal.animal_name%TYPE;
BEGIN
	SELECT animal_name INTO l_animal_name FROM animal;
	DBMS_OUTPUT.PUT_LINE(l_animal_name);
END;
/
