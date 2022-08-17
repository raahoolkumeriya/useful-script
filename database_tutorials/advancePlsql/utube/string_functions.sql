/*
|	Program: String Functions  
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		String Functions		--;
prompt ---------------------------------------------------;
prompt -- UPPER,LOWER,INITCAP,LENGTH,REVERSE,REPLACE	--;
prompt ---------------------------------------------------;

SELECT UPPER(employee_name), LOWER(employee_name), INITCAP(employee_name), LENGTH(employee_name), REVERSE(employee_name), REPLACE(employee_name,'A','z') 
FROM employees;
