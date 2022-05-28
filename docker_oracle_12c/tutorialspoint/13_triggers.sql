/*
|	Program: Triggers
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt DML ( INSERT, UPDATE, DELETE )
prompt DDL ( CREATE, DELETE, DROP )
prompt database Operation Triggers ( SERVERERROR, LOGON, LOGOFF, STARTUP, SHUTDOWN)

prompt ------------------------------------------------------------------
prompt -- Generating some derived column values automatically
prompt -- Enforcing referential integrity
prompt -- Event logging and storing information on table access
prompt -- Auditing
prompt -- Synchronus replication of tables
prompt -- Imposing security authorization
prompt -- preventing invalid transaction
prompt ------------------------------------------------------------------


CREATE OR REPLACE TRIGGER display_salary_changes
BEFORE INSERT OR UPDATE OR DELETE ON tp_customers
FOR EACH ROW
WHEN ( NEW.ID > 0 )
DECLARE
	sal_diff NUMBER;
BEGIN
	sal_diff := :NEW.salary - :OLD.salary;
	DBMS_OUTPUT.PUT_LINE('Old Salary '
				|| :OLD.salary 
				|| ' is replace with '
				|| :NEW.salary
				|| ', which gives difference of '
				|| sal_diff);
END;
/


INSERT INTO tp_customers 
VALUES (7, 'Sana', 22, 'HP', 7500.00);

