/*
|	Program: Create Index | World of Oracle
|	Author: Raahool Kumeriya
|	Change history:
|		09-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     Create Index | World of Oracle		--;
prompt ---------------------------------------------------;

SELECT * FROM employees_bk;

-- CREATE INDEX idx ON employees_bk(salary);

prompt ---------------------------------------------------;
prompt --     		Composite Index			--;
prompt ---------------------------------------------------;

-- CREATE INDEX cmptindx ON employees_bk(employee_id,salary);

prompt ---------------------------------------------------;
prompt --     	Function based Index			--;
prompt ---------------------------------------------------;

-- CREATE INDEX funbidx
 --	ON employees_bk(lower(employee_name));

prompt ---------------------------------------------------;
prompt --     	Reverse Key Index			--;
prompt ---------------------------------------------------;

--CREATE INDEX revidx 
--	ON employees_bk(MANAGER_ID)
--	REVERSE;


SELECT index_name, index_type, uniqueness
FROM user_indexes
WHERE lower(table_name) = 'employees_bk';
