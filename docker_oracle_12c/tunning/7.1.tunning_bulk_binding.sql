/*
|	Program: BULK Binding 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt -----------------------------------;
prompt --          Binding              --;
prompt -----------------------------------;

prompt ---- how BULK Binding imporove PLSQL performance ? ;
prompt > how PLSQL code is getting executed?;
prompt > PLSQL Engine ( execute all the procedureal code ) and SQL Engine (execute all the sql statements );
prompt ---------------------------------------------------;
prompt > PLSQL and SQL communicate as follows: To run a SELECT INTO or DML statement, the PLSQL engine sends the query or DML statement to the SQL Engine.;
prompt >> The SQL engine runs the query or DML statement and returns the result to the PLSQL engine.;
prompt > Asssigning values to PLSQL variable that appers in SQL statements is called binding.;


DECLARE
	lv_name		employees.EMPLOYEE_NAME%TYPE;
	lv_empno	NUMBER := 7788;
BEGIN
	IF lv_empno IS NOT NULL THEN			-- Sent to PLSQL Engine 
					-- Sent to SQL engine for processing
		SELECT EMPLOYEE_NAME
		INTO lv_name				   
		FROM employees				    
		WHERE employee_id = lv_empno;		
					--- SQL Engine statements
	END IF;
END;
/


DECLARE 
	lv_name		employees.EMPLOYEE_NAME%TYPE;
BEGIN
	FOR i IN 7000..10000 LOOP
		SELECT EMPLOYEE_NAME
		INTO lv_name
		FROM employees
		WHERE employee_id = i;
	END LOOP;
EXCEPTION
	WHEN NO_DATA_FOUND
	THEN
		null;
END;
/

prompt ----------------------------------------;
prompt --       Context Switching            --;
prompt ----------------------------------------;
prompt -- Switch between PLSQL Engine and SQL Engine is called Context Switching.;
prompt -- Context switching has huge imapct in term of performance;

prompt ----------------------------------------;
prompt --	  BULK Binding		     --;
prompt ----------------------------------------;
prompt > Bulk bindind is a process in which instead of doing binding one by one because of context switching, the;
prompt >> entire information from the SQL statement will be binded back to the PLSQL variable either in a single switch ;
prompt >>> or fewer numebr of switches. This is called BULK Binding.;

 
prompt ----------------------------------------;
prompt -- Types of Binding availables	     --;
prompt ----------------------------------------;
prompt >> In-Bind : The value form the PLSQL engine assignt the SQL engine, it happend wherever we INSERT, UPDATE or MERGE statements executes.
prompt >> Out-bind : From the SQL statement information returning back to PLSQL variable. When and RETURNNGN INTO clause of an INSERT, UPDATE or DELETE statements;
prompt >> DEFINE : When a SELECT or FETCH statements assign a databse value to the PLSQL or host variable;

prompt ----- TO implement Bulk binding ----;
prompt >>>>> FORALL;
prompt >>>>> BULK COLLECT clause; 
prompt ------------------------------------;

