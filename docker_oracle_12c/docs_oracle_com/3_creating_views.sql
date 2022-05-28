/*
|	Program: Creating Views
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET PAGES 1000 LINES 132;
COL Name FORMAT A30
COL CITY FORMAT A30
COL COUNTRY FORMAT A30
 
CREATE OR REPLACE VIEW emp_locations AS
	SELECT e.employee_id,
		e.last_name||', '||e.first_name "Name",
		d.department_name Department,
		l.city CITY,
		c.country_name COUNTRY 
	FROM employees e, departments d, locations l, countries c
	WHERE e.department_id = d.department_id AND
		d.location_id = l.location_id AND
		l.country_id = c.country_id
	ORDER BY last_name;

SELECT * FROM emp_locations;

----------------------------------------------------------
prompt Changing VIEW name with REPLACE tool
----------------------------------------------------------
RENAME emp_locations TO VIEW_EMP_LOCATIONS;


SELECT * FROM VIEW_EMP_LOCATIONS;
