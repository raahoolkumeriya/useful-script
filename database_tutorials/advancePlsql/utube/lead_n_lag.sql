/*
|	Program: Lead and Lag 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		LEAD				--;
prompt ---------------------------------------------------;
prompt -- Lead is used to find next row value within th same table;
prompt SYNTAX: lead(column,context,default) OVER partition caluse;

SELECT department_id, HIREDATE, LEAD(HIREDATE,1) OVER (order by HIREDATE) Next_hiredate
FROM Employees;

SELECT department_id, HIREDATE, LEAD(HIREDATE,2) OVER (order by HIREDATE) Next_hiredate
FROM Employees;


SELECT department_id, HIREDATE, LEAD(HIREDATE,1) OVER (partition by department_id order by HIREDATE) Next_hiredate
FROM Employees;

prompt ---------------------------------------------------;
prompt --     		LAG				--;
prompt ---------------------------------------------------;
prompt -- Lag is used to find previous row value within th same table;
prompt SYNATX: LAG(column,context,default) over partition clause;
prompt 

SELECT employee_name , salary, lag(salary,1) OVER (order by salary) ,salary - lag(salary,1) OVER (order by salary)
From employees;


