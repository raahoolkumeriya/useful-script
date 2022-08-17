/*
|	Program: Create test procedure 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

CREATE OR REPLaCE PROCEDURE proc_c AS
	lv_avg_sal 	NUMBER;
BEGIN
	FOR i in 1..50 LOOP
		SELECT AVG(salary)
		INTO lv_avg_sal
		FROM employees;
	END LOOP;
END;
/

show errors;

REM ---------------------------------
REM proc_b calling from proc_c
REM --------------------------------- 

CREATE OR REPLACE PROCEDURE proc_b AS
	lv_date DATE;
BEGIN
	FOR i in 1..50 LOOP
		proc_c;
		SELECT SYSDATE 
		INTO lv_date
		FROM DUAL;
	END LOOP;
END;
/

show errors;

REM ---------------------------------
REM proc_b calling from proc_a
REM --------------------------------- 


CREATE OR REPLACE PROCEDURE proc_a AS
	lv_count NUMBER;
BEGIN
	SELECT COUNT(*) 
	INTO lv_count
	FROM user_tables,all_objects;

	FOR i IN 1..50 LOOP
		proc_b;
	END LOOP;
END;
/

show errors;
