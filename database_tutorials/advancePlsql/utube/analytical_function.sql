/*
|	Program: ANALYTICAL Function 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		ANALYTICAL Function		--;
prompt ---------------------------------------------------;
prompt -- Analytical function are similar to Aggregate function;
prompt -- Analytical function execute on each records unlike aggregate function;
prompt ---------------------------------------------------;

SELECT department_id, AVG(SALARY) FROM employees GROUP BY department_id ORDER BY department_id;

prompt ---------------------------------------------------;
prompt -- Here with Agrregate function rows get reduced;
prompt -- Analytical function always come with OVER clause;
prompt -- With analytical function number reocrds will be the same as tabel records;
prompt ---------------------------------------------------;

SELECT employee_id, department_id, salary, AVG(salary) OVER(partition by department_id) AS average_Sal FROM employees;

prompt ---------------------------------------------------;
prompt 	Different analytical functions available; 
prompt ---------------------------------------------------;
prompt RANK(), DENSE_RANK(), row_number(), LAG, LEAD, first, least;
prompt ---------------------------------------------------;
prompt analytic_fuc([arguments]) OVER(analytic_clause);
prompt OVER(partition_query [orderby [windowing]]);
prompt ---------------------------------------------------;

prompt --- 2nd employee of the table ----;

SELECT * FROM ( SELECT employee_name, department_id, row_number() OVER(order by rowid) as rn FROM employees ) x where x.rn = 2;

prompt --- 2nd employee from each department ---;
SELECT * FROM ( SELECT employee_name, department_id, row_number() OVER(partition by department_id order by rowid) as rn FROM employees ) x where x.rn = 2;
