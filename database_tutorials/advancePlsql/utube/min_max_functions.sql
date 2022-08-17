/*
|	Program: MIN MAX Functions 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		MIN MAX Functions		--;
prompt ---------------------------------------------------;

SELECT MIN(SALARY), MAX(SALARY) from employees;


SELECT department_id,MAX(SALARY) 
FROM employees
GROUP BY department_id;


