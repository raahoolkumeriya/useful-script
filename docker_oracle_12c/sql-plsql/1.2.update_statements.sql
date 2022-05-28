/*
|	Program: join two tables with update statements 
|	Author: Raahool Kumeriya
|	Change history:
|		16-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

/*
CREATE TABLE test_update AS (	
	SELECT employee_id, department_id, salary 
	FROM employees);

ALTER TABLE test_update ADD  NEW_SAL NUMBER(7,2);

CREATE TABLE update_mas (
	department_id 	NUMBER(4),
	per_incr	NUMBER(3));

INSERT INTO update_mas (department_id,per_incr) VALUES (10,10);
INSERT INTO update_mas (department_id,per_incr) VALUES (20,5);
INSERT INTO update_mas (department_id,per_incr) VALUES (30,15);
COMMIT;

*/

prompt ------------------------------------------;
prompt sperate update for all rows;
prompt ------------------------------------------;
/*
UPDATE test_update 
SET NEW_SAL = salary + ( salary * 5 ) /100
WHERE department_id = 10;


UPDATE test_update TU
SET TU.NEW_SAL = ( SELECT TU.salary + ( TU.salary * UM.per_incr / 100) FROM update_mas UM WHERE UM.department_id = TU.department_id )
WHERE EXISTS ( SELECT 1 FROM update_mas UM WHERE UM.department_id = TU.department_id );

*/


