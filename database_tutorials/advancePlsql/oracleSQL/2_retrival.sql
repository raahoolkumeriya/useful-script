prompt Retrival : The basics

prompt -- Six main clauses of SELECT command are
prompt -- Mandatory Claues - SELECT and FROM other are Optional clauses
prompt 
prompt >>-------- SELECT ----------- FROM ---------->
prompt 

prompt "  |--- WHERE ---|     |-- GROUP BY ---|"	
prompt >--|-------------|-----|---------------|------>

prompt "  |---- HAVING--|    |--- ORDER BY ----|"
prompt >--|-------------|----|-----------------|---->>
prompt 

prompt -- Must be process in the following order 
prompt --- FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY.


prompt -- Issue a Simple SELECT Command
SET PAGESIZE 1000;
set colsep " | "
SET LINESIZE 200;
COL FIRST_NAME FORMAT A15;
COL LAST_NAME FORMAT A15;
COL EMAIL FORMAT A30;
COL PHONE FORMAT A20;
COL JOB_TITLE FORMAT A35;

SELECT * 
FROM REGIONS;

prompt -- Select specific columns
SELECT EMPLOYEE_ID, FIRST_NAME,LAST_NAME, EMAIL, PHONE as CONTACT#
FROM EMPLOYEES
WHERE EMPLOYEE_ID < 5;

prompt -- Changing Heading of Columns
SELECT REGION_NAME as GLOBAL_REGION_NAME 
FROM regions;

prompt -- Using DISTINCT to eliminate Duplicates
SELECT DISTINCT manager_id, JOB_TITLE
FROM employees;

prompt -- Concatenate the employee names
COL employee_name FORMAT A30;
COL Position FORMAT A30;
SELECT first_name||' '||last_name as employee_name
, job_title as Position
FROM employees 
WHERE employee_id = 25;
 
prompt -- Using SYSDATE 
SELECT (SYSDATE - HIRE_DATE ) / 365
FROM employees
WHERE employee_id = 100;

prompt -- Arithmatic operation : ROUND, CEIL, FLOOR
SELECT ROUND(345.324,0), CEIL(1334.342), FLOOR(3432.432)
FROM dual;

SELECT ROUND(123.123, 2)
,	ROUND(123.123,-1)
,	ROUND(123.123,-2)
FROM dual;

SELECT ABS(-123)
,	ABS(0)
,	ABS(456)
,	SIGN(-123)
,	SIGN(0)
,	SIGN(456)
FROM dual;

SELECT 	POWER(2,3)
,	POWER(-2,3)
,	MOD(8,3)
,	MOD(13,0)
FROM dual;

prompt -- Use MOD with WHERE clause ( ODD number of records )
SELECT	employee_id
,	first_name
,	last_name
,	hire_date
FROM employees
WHERE	MOD(employee_id,2) = 1 
ORDER BY employee_id ASC;


prompt -- Use MOD with WHERE clause ( EVEN number of records )
SELECT  employee_id
,       first_name
,       last_name
,       hire_date
FROM employees
WHERE   MOD(employee_id,2) = 0
ORDER BY employee_id ASC;


prompt -- Using FLOOR and MOD

SELECT 	first_name||' '||last_name AS employee_name
,	FLOOR((SYSDATE - hire_date )/7 ) AS weeks
,	FLOOR(MOD(SYSDATE - hire_date, 7)) AS days
FROM employees
WHERE employee_id = 25;

prompt -- trignometric Exponential, logarithmic
SELECT 	SIN(30*3.1421/180)
,	TANH(0.5)
,	EXP(4)
,	LOG(2,32)
,	LN(32)
FROM dual;


prompt -- TEXT Functions

prompt -- Using LOWER, UPPER,INITCAP, LENGTH functions
SELECT 	LOWER(job_title) AS job_title
,	INITCAP(first_name) AS FIRST_NAME
FROM employees
WHERE UPPER(job_title) = 'PROGRAMMER'
ORDER BY LENGTH(first_name);


prompt -- using the INSTR and SUBSTR functions
COL substr1 FORMAT A30;
SELECT 	first_name
,	SUBSTR(first_name,4) as substr1
,	SUBSTR(first_name,4,3) as substr2
,	INSTR(first_name,'I') as instr1
,	INSTR(first_name,'I',5) as instr2
,	INSTR(first_name,'I',3,2) as instr3
FROM employees;

