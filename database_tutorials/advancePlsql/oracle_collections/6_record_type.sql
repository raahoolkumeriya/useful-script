/*
|	Program: RECORD type 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------;
prompt --  	RECORD Type	--;
prompt ---------------------------;
prompt It can be define in PLSQL block as a local type. and it will be available only in block.;
prompt It can be defien in Package specification as a Public item. Can be called in different programs with pacakge name. It is stored in database until you drop the package.;
prompt You CANNOT create RECORD Type at Schema level.;

prompt ------------------------------------------------;
prompt RECORD is similar to C structures;
prompt ------------------------------------------------;

DECLARE
	TYPE emp_rec_type IS RECORD ( employee_name VARCHAR2(100),	-- Similar to Struture declaration
					emp_salary	NUMBER);
	emp_rec emp_rec_type;						-- variable declaration
BEGIN
	emp_rec.employee_name := 'Raahool';
	emp_rec.emp_salary := 1000000;
	
	dbms_output.put_line('emp_rec.employee_name: '||emp_rec.employee_name);
	dbms_output.put_line('emp_rec.emp_salary: '||emp_rec.emp_salary);
END;
/

prompt -------------------------------------------;
prompt Different ways to assign values : Constructor ;
prompt -------------------------------------------;

prompt DECLARE
prompt		TYPE emp_rec_type IS RECORD ( employee_name 	VARCHAR2(100),
prompt						salary		NUMBER);
prompt 		emp_rec emp_rec_type := emp_rec_type('Raahool', 100000);  		-- Constuctor is a method name 
prompt BEGIN
prompt		dbms_output.put_line('emp_rec.employee_name: '||emp_rec.employee_name);
prompt 		dbms_output.put_line('emp_rec.salary: '||emp_rec.salary);
prompt	END;

prompt -------------------------------------------;
prompt Assigning value from SELECT statement;
prompt -------------------------------------------;

DECLARE
	TYPE emp_rec_type IS RECORD ( employee_name 	VARCHAR2(100),
					salary		NUMBER);
	emp_rec	emp_rec_type;
BEGIN
	SELECT employee_name, salary
	INTO emp_rec
	FROM employees
	WHERE employee_id = 7788;
	
	dbms_output.put_line('emp_rec.employee_name: '||emp_rec.employee_name);
	dbms_output.put_line('emp_rec.salary: '||emp_rec.salary);
END;
/


prompt -------------------------------------------;
prompt NOT NULL constraint on the record fields;
prompt -------------------------------------------;

DECLARE
	TYPE emp_rec_type IS RECORD ( employee_name VARCHAR2(100) NOT NULL := 'Raahool',
					salary NUMBER);
	emp_rec emp_rec_type;
BEGIN
	emp_rec.employee_name := ' '; -- '' assign NULL value will raise numeric or value error
	emp_rec.salary := 1000000;
	
	dbms_output.put_line('emp_rec.employee_name: '||emp_rec.employee_name);
	dbms_output.put_line('emp_rec.salary: '||emp_rec.salary);
END;
/

prompt --------------------------------------;
prompt Difference between TYPE and %TYPE; 
prompt --------------------------------------;

DECLARE
	TYPE emp_rec_type IS RECORD ( employee_name employees.employee_name%TYPE,
					empsal	employees.salary%TYPE);
	emp_rec emp_rec_type;
	lv_ename employees.employee_name%TYPE;
BEGIN
	SELECT employee_name,salary 
	INTO emp_rec
	FROM employees
	WHERE employee_id = 7788;
	
	select employee_name INTO lv_ename FROM employees WHERE employee_id = 7788;

	dbms_output.put_line('emp_rec.employee_name: '||emp_rec.employee_name);
	dbms_output.put_line('lv_enmae: '||lv_ename);
	dbms_output.put_line('emp_rec.empsal: '||emp_rec.empsal);
END;
/

prompt ------------------------------------------------------------;
prompt -- TYPE     : To define our Custom Record defination  	 --;
prompt -- %TYPE    : To define datatype of a field or variable	 --;
prompt -- %ROWTYPE : to defien a record of table row type	 --;
prompt ------------------------------------------------------------;
