/*
|	Program: Oracle Docs
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

-------------------------------
prompt Unlocking the HR Account
-------------------------------

-- ALTER USER HR ACCOUNT UNLOCK IDENTIFIED BY HR;

-------------------------------
prompt View Schema Objects
-------------------------------

SET PAGES 1000 LINES 132;
COLUMN OBJECT_NAME FORMAT A25
COL OBJECT_TYPE FORMAT A25

SELECT object_name, object_type FROM USER_OBJECTS
ORDER BY object_type, object_name;


------------------------------
prompt Rounding Numeric Data
------------------------------
COL LAST_NAME FORMAT A25
COL name FORMAT A20

SELECT 	FIRST_NAME||' '||LAST_NAME "name"
,	ROUND(((SALARY * 12)/365), 2) "Daily Pay"
,	TRUNC((SALARY * 12)/365) "Daily pay 2"
FROM 	EMPLOYEES
WHERE MANAGER_ID = 25
ORDER BY LAST_NAME;

------------------------------------------------ 
prompt Diplay the number of years between dates
------------------------------------------------ 
SELECT 	LAST_NAME
,	(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)) "Years Employed"
FROM employees
WHERE MANAGER_ID = 25; 


------------------------------------------------ 
prompt Display system date and time
------------------------------------------------ 
SELECT 	EXTRACT(HOUR FROM SYSTIMESTAMP) ||':'||
	EXTRACT(MINUTE FROM SYSTIMESTAMP)||':'||
	ROUND(EXTRACT(SECOND FROM SYSTIMESTAMP), 0)||', '||
	EXTRACT(MONTH FROM SYSTIMESTAMP)||'/'||
	EXTRACT(DAY FROM SYSTIMESTAMP)||'/'||
	EXTRACT(YEAR FROM SYSTIMESTAMP) "System Time and Date"
FROM DUAL;


------------------------------------------------ 
prompt Converting Dates to Characters using a format tempate
----------------------------------------------- 
SELECT LAST_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'FMMonth DD YYYY') "Date Started"
FROM EMPLOYEES WHERE MANAGER_ID = 25
ORDER BY LAST_NAME;


------------------------------
prompt Counting the Number of rows in each groups
------------------------------
SELECT manager_id "Manger",
count(*) "Number of Reports"
FROM employees
GROUP BY manager_id
ORDER BY manager_id;

------------------------------------------------ 
prompt Limiitng Aggregate functions to rows that statify condition
------------------------------------------------ 

SELECT 	MANAGER_ID "Manager"
,	SUM(Salary*12) "All Salries"
FROM employees
HAVING SUM(salary * 12) >= 2000000
GROUP BY manager_id;

------------------------------------------------ 
prompt Using aggregate function for statistical information
------------------------------------------------ 
SELECT 	MANAGER_ID
,	COUNT(*) "#"
,	MIN(SALARY) "Minimum"
,	ROUND(AVG(SALARY), 0) "Average"
,	MEDIAN(SALARY) "Median"
,	MAX(SALARY) "Maximum"
,	ROUND(STDDEV(SALARY)) "Std dev"
FROM employees
GROUP BY MANAGER_ID
ORDER BY MANAGER_ID;

------------------------------------------------ 
prompt Using NULL- related function in Queries
-----------------------------------------------
SELECT 	LAST_NAME
,	NVL(TO_CHAR(COMMISSION_PCT), 'Not Applicable') "COMMISSION"
FROM EMPLOYEES
WHERE LAST_NAME LIKE 'B%'
ORDER BY LAST_NAME;

------------------------------------------------ 
prompt Specifuing Different Expression for NULL and NOT NULL values
------------------------------------------------
SELECT 	LAST_NAME, SALARY
,	NVL2(COMMISSION_PCT, SALARY + ( salary * commission_pct), salary) INCOME
FROM employees WHERE LAST_NAME LIKE 'B%'
ORDER BY LAST_NAME;
 
------------------------------------------------
prompt Using a Simple CASE Expression in a Query
------------------------------------------------
SELECT UNIQUE country_id ID,
	CASE country_id
		 WHEN 'AU' THEN 'Australia'
		 WHEN 'BR' THEN 'Brazil'
		 WHEN 'CA' THEN 'Canada'
		 WHEN 'CH' THEN 'Switzerland'
		 WHEN 'CN' THEN 'China'
		 WHEN 'DE' THEN 'Germany'
		 WHEN 'IN' THEN 'India'
		 WHEN 'IT' THEN 'Italy'
		 WHEN 'JP' THEN 'Japan'
		 WHEN 'MX' THEN 'Mexico'
		 WHEN 'NL' THEN 'Netherlands'
		 WHEN 'SG' THEN 'Singapore'
		 WHEN 'UK' THEN 'United Kingdom'
		 WHEN 'US' THEN 'United States'
        ELSE 'Unknown'
	END AS COUNTRY
FROM locations
ORDER BY country_id;

------------------------------------------------
prompt Using searched case Expression in a query
------------------------------------------------
SELECT last_name "Name"
,	hire_date "Started"
,	salary	"Salary"
,	CASE
		WHEN hire_date < TO_DATE('01-JAN-16','dd-mon-yy')
			THEN TRUNC(salary*1.15,0)
		WHEN hire_date >= TO_DATE('01-AUG-16','dd-mon-yy') AND hire_date < TO_DATE('01-DEC-16','dd-mon-yy')
			THEN TRUNC(salary*1.10,0)
		WHEN hire_date >= TO_DATE('01-JAN-16','dd-mon-yy') AND hire_date < TO_DATE('01-DEC-17','dd-mon-yy')
			THEN TRUNC(salary*1.15,0)
		ELSE salary
	END "Proposed Salary"
FROM employees
WHERE department_id = 100
ORDER BY hire_date; 

------------------------------------------------
prompt Using DECODE function in queries
------------------------------------------------
COL job_title FORMAT A30

SELECT last_name, job_title, salary,
DECODE(job_title,
	'Purchasing Clerk',SALARY * 1.10,
	'Shipping Clerk', SALARY * 1.15,
	'Stock Clerk', Salary * 1.20,
	SALARY) "Proposed Salary"
FROM EMPLOYEES
WHERE UPPER(job_title) LIKE '%CLERK'
AND last_name < 'E'
ORDER BY last_name;

------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
