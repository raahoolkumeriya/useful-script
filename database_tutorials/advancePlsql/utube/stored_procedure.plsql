/*
|	Program: SP 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		Stored Procedure		--;
prompt ---------------------------------------------------;
prompt -- Resusible plsql program that may or may not return a value;
prompt -- SP always have a name;
prompt -- compile code stored in database that code is called a P-code or M-code;
prompt ---------------- Parameters to SP -----------------;
prompt -- IN --> default type of paramter, that takes value form user. IT is READ only; 
prompt -- OUT --> Carry the value form SP to the calling program, It can be modifed, multiple OUT parameters allowed; 
prompt -- IN OUT --> has the same datatype ;
prompt -- Resusible plsql program that may or may not return a value;
prompt ---------------------------------------------------;

CREATE OR REPLACE PROCEDURE sp_get_employee_details 
( 
	p_enum IN NUMBER,
	p_name OUT VARCHAR,
	p_sal	OUT NUMBER,
	p_job	OUT VARCHAR
)
IS
BEGIN
	SELECT employee_name, salary, job INTO
	p_name,p_sal,p_job 
	FROM employees
	WHERE employee_id = p_enum;
END sp_get_employee_details;
/

prompt ------------------------------------------------------;
prompt Unit testing program;
prompt ------------------------------------------------------;
DECLARE
	v1 	VARCHAR(20);
	v2	NUMBER;
	v3	VARCHAR2(30);
BEGIN
	sp_get_employee_details(7788, v1,v2,v3);
	DBMS_OUTPUT.PUT_LINE(v1||' has salary '||v2||' with job details : '||v3);
END;
/
