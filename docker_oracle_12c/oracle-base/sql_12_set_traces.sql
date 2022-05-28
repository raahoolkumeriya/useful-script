/*
|	Program: 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

alter session set container = ORCLPDB1;
show con_name;
ALTER SESSION SET EVENTS '10053 trace name context forever';

SELECT  d.department_name, e.employee_name
FROM    axiomus.departments d
        JOIN axiomus.employees e
                ON d.department_id = e.department_id
WHERE   d.department_id >= 30
ORDER BY 1;



ALTER SESSION SET EVENTS '10053 trace name context off';
