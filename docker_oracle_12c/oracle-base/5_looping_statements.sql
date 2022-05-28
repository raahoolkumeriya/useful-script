/*
|	Program: Looping statements 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt -------- Simple loop ----------------;
DECLARE
	i NUMBER := 1;
BEGIN
	LOOP
		EXIT WHEN i > 5;
		DBMS_OUTPUT.PUT_LINE(i);
		i := i + 1;
	END LOOP;
END;
/

prompt -------- FOR-LOOP ----------------;

BEGIN
	FOR i in 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
/


prompt -------- WHILE-LOOP ----------------;

DECLARE
	i NUMBER := 1;
BEGIN
	WHILE i <= 5 
	LOOP
		DBMS_OUTPUT.PUT_LINE(i);
		i := i + 1;
	END LOOP;
END;
/

prompt ---------- GOTO -------------------;

DECLARE
	i NUMBER := 1;
BEGIN
	LOOP
		IF i > 5 THEN
			GOTO exit_from_loop;
		END IF;
		DBMS_OUTPUT.PUT_LINE(i);
		i := i + 1;
	END LOOP;

	<< exit_from_loop >>
	NULL;
END;
/	
