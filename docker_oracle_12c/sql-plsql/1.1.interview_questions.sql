/*
|	Program: Interview Question 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ----------- FIND SALARY IN DESCENDING ORDER ---------------;

SELECT salary 
FROM 	employees 
ORDER BY salary DESC NULLS LAST;


prompt -------------------------------------------------------------;
prompt FIND MAX SALRAY;
prompt -------------------------------------------------------------;

SELECT MAX(salary) 
FROM employees;


prompt -------------------------------------------------------------;
prompt SECOND MAX SALARY ;
prompt -------------------------------------------------------------;

SELECT MAX(salary) 
FROM employees 
WHERE salary NOT IN ( SELECT MAX(salary) FROM employees );

prompt -------------------------------------------------------------;
prompt FIND THE 3rd MAX SALARY;
prompt -------------------------------------------------------------;

SELECT * 
FROM ( SELECT salary, ROWNUM as RANK FROM
	( SELECT salary FROM employees ORDER BY salary DESC ) ) K 
WHERE K.RANK = 3;

-- SELECT salary, ROWNUM as RANK FROM ( SELECT salary FROM employees ORDER BY salary DESC);


prompt -------------------------------------------------------------;
prompt Issue with above code it work correct with Unique rows ;
prompt -------------------------------------------------------------;
prompt DENSE_RANK function;
prompt -------------------------------------------------------------;

SELECT salary, DENSE_RANK() OVER ( ORDER BY salary DESC )
FROM employees;


prompt -------------------------------------------------------------;
prompt 3rd MIN SALARY ;
prompt -------------------------------------------------------------;

SELECT * 
FROM ( SELECT salary , DENSE_RANK() OVER ( ORDER BY salary ASC ) AS RANK
	FROM employees ) 
WHERE RANK = 3;


prompt -------------------------------------------------------------;
prompt FIND OUT MAX SALARY FROM each Departments;
prompt -------------------------------------------------------------;

SELECT * FROM (
	SELECT salary,
		department_id, 
		DENSE_RANK() OVER (PARTITION BY department_id  ORDER BY salary DESC) AS RANK 
	FROM employees)
WHERE RANK = 1;

