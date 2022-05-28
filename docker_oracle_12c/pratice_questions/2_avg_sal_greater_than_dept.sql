/*
|	Program: Select employees getting salary greater than average salary of hte dpeertment that are workign in 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;
SET timing on;

prompt ---------------------------------------------------;
prompt --   Department wise AVG salary                  --;
prompt ---------------------------------------------------;

SELECT DEPARTMENT_ID, TRUNC(AVG(salary)) avg_salary
FROM employees
GROUP BY DEPARTMENT_ID;

REM --- Computing avg salry in inline view and coparing woth salary
 
SELECT *
FROM employees a, (SELECT DEPARTMENT_ID, TRUNC(AVG(salary)) avg_salary
			FROM employees
			GROUP BY DEPARTMENT_ID) b
WHERE a.DEPARTMENT_ID = b.DEPARTMENT_ID
AND 	a.salary > b.avg_Salary;


prompt ---------------------------------------------------;
prompt --    COrrelated Query                           --;
prompt ---------------------------------------------------;

SELECT *
FROM employees a 
WHERE a.salary > ( SELECT avg(b.salary) FROM employees b where a.department_id = b.department_id);


prompt ---------------------------------------------------;
prompt -- BEST WAY  -->  ANalaytical function           --;
prompt ---------------------------------------------------;

SELECT * FROM (
	SELECT employee_name,JOb,MANAGER_ID,HIREDATE,SALARY,COMMISSION,DEPARTMENT_ID,
	AVG(salary) OVER ( partition by DEPARTMENT_ID) avg_Salary 
	FROM employees )
WHERE SALARY > avg_Salary;


prompt ---------------------------------------------------;
prompt --        WITH clause support to 12c             --;
prompt ---------------------------------------------------;

WITH 
	function avg_sal(p_deprtno NUMBER) RETURN NUMBER AS
		v_avg_sal NUMBER;
	BEGIN
		SELECT AVG(salary)
		INTO v_avg_sal
		FROM employees
		WHERE DEPARTMENT_ID = p_deprtno;
		
		RETURN v_avg_sal;
	END avg_sal;
SELECT employee_id,employee_name, job,MANAGER_ID,hiredate,salary,DEPARTMENT_ID
FROM employees
WHERE salary > avg_sal(DEPARTMENT_ID);
/

