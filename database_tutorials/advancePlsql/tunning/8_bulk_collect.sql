/*
|	Program: Bulk Collect 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET timing on;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --         BULK COLLECT                          --;
prompt ---------------------------------------------------;

DECLARE
	TYPE emp_name_list IS TABLE OF VARCHAR2(100);
	lv_emp_name_list emp_name_list := emp_name_list();
	lv_start_time NUMBER;
	lv_end_time NUMBER;
BEGIN
	lv_start_time := dbms_utility.get_time;
	FOR i IN ( SELECT * FROM employees)
	LOOP
		lv_emp_name_list.EXTEND();
		lv_emp_name_list(lv_emp_name_list.LAST) := i.employee_name;
	END LOOP;
	lv_end_time := dbms_utility.get_time;
	dbms_output.put_line('Time taken by FOR loop = '||(lv_end_time-lv_start_time));

	FOR i IN lv_emp_name_list.FIRST .. lv_emp_name_list.LAST 
	LOOP
		dbms_output.put_line(lv_emp_name_list(i));
	END LOOP;
END;
/

prompt -------------------------------------------------;
prompt Above code execution is doing more numebr of context switching;
prompt -------------------------------------------------;

DECLARE
	TYPE emp_name_list IS TABLE OF VARCHAR2(100);
	lv_emp_name_list emp_name_list := emp_name_list();
	lv_start_time NUMBER;
	lv_end_time NUMBER;
BEGIN
	lv_start_time := dbms_utility.get_time;
	SELECT employee_name 
	BULK COLLECT 	
	INTO lv_emp_name_list
	FROM employees;
	lv_end_time := dbms_utility.get_time;
	dbms_output.put_line('Time taken by BULK COLLECT  = '||(lv_end_time-lv_start_time));

	FOR i IN lv_emp_name_list.FIRST .. lv_emp_name_list.LAST 
	LOOP
		dbms_output.put_line(lv_emp_name_list(i));
	END LOOP;
END;
/ 
