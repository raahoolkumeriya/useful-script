/*
|	Program: Subprogram inlining in PL/SQL 
|	Author: Raahool Kumeriya
|	Change history:
|		01-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    Subprogram inlining in PL/SQL	        --;
prompt ---------------------------------------------------;

CREATE OR REPLACE PROCEDURE p_sum_series(p_count NUMBER)	-- create a procedure
	AUTHID DEFINER
IS
	l_series	NUMBER := 0;
	l_time		NUMBER;

	-- Declare a local subprogram which returns the double of a number
	FUNCTION f_cross ( p_num NUMBER, p_multiplier NUMBER ) RETURN NUMBER IS
		l_result 	NUMBER;
	BEGIN
		l_result := p_num * p_multiplier;
		RETURN (l_result);
	END f_cross;

BEGIN
	-- capture the start time
	l_time	:= DBMS_UTILITY.get_time();
	
	-- Begin the loop for series calculation
	FOR j IN 1 .. p_count
	LOOP
		-- set inlining for the local subprogram 
		PRAGMA INLINE ( f_cross, 'YES');
		l_series := l_series + f_cross(j,2);
	END LOOP;

	-- time csonsumed to calculate the result
	DBMS_OUTPUT.put_line('Execution time : '||TO_CHAR(DBMS_UTILITY.get_time() - l_time));
END;
/

show errors;

prompt ---------------------------------------;
prompt  CASE 1: When PLSQL_OPTIMIZE_LEVEL = 0 ;
prompt ---------------------------------------;

ALTER SESSION SET plsql_warnings = 'enable:all'
/

ALTER PROCEDURE p_sum_series COMPILE PLSQL_OPTIMIZE_LEVEL=0
/

show errors;

BEGIN
	p_sum_series (10000000);
END;
/

prompt ---------------------------------------;
prompt  CASE 2: When PLSQL_OPTIMIZE_LEVEL = 1 ;
prompt ---------------------------------------;

ALTER PROCEDURE p_sum_series COMPILE PLSQL_OPTIMIZE_LEVEL=1
/

show errors;

BEGIN
	p_sum_series (10000000);
END;
/

prompt ---------------------------------------;
prompt  CASE 3: When PLSQL_OPTIMIZE_LEVEL = 2 ;
prompt ---------------------------------------;

ALTER PROCEDURE p_sum_series COMPILE PLSQL_OPTIMIZE_LEVEL=2
/

show errors;

BEGIN
	p_sum_series (10000000);
END;
/

