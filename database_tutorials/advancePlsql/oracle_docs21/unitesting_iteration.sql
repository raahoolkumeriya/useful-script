/* - - - +
|
|	Author: Raahool Kumeriya
|	
|	Purpose: About iterations 
|
|	Change history:
|	Date		Who		Description
|	----------	----------	-----------------------------------
|	28-JUN-22  	codelocked	Program Created
|
+ - - - */

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 			ALL About Iterations		  ;
prompt ---------------------------------------------------;

--- Package implmnetaion / body
create or replace package iteration
IS
	--- Using Multiple iterations control
	procedure multiple_iteration_control
	is
		i PLS_INTEGER;
	BEGIN
		FOR i IN 1..3, 5..7, REVERSE i+1 .. i+4, 100 .. 104 LOOP
			DBMS_OUTPUT.put_line(i);
		END LOOP;
	END multiple_iteration_control;


end iteration;
/


