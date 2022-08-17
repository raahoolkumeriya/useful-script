/*
||	Program: DML in PLSQL 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		DML in PLSQL			--;
prompt ---------------------------------------------------;


CREATE OR REPLACE PACKAGE sql_test_dml_utility
	AUTHID CURRENT_USER
IS
	PROCEDURE insert_in_sql_test(
		p_id IN sql_test.id%TYPE, p_desc IN sql_test.description%TYPE);

	PROCEDURE update_sql_test(
		p_id IN sql_test.id%TYPE, p_desc IN sql_test.description%TYPE);

	PROCEDURE delete_from_sql_test(p_id IN sql_test.id%TYPE);

	PROCEDURE delete_from_sql_test(p_desc IN sql_test.description%TYPE);

END;
/

SHO ERR;

-- Package body 
CREATE OR REPLACE PACKAGE BODY sql_test_dml_utility
IS
        PROCEDURE insert_in_sql_test(
                p_id IN sql_test.id%TYPE, p_desc IN sql_test.description%TYPE)
	IS
	BEGIN
		INSERT INTO sql_test (id, description)
			VALUES (p_id, p_desc);
		IF SQL%ROWCOUNT = 1 THEN
			DBMS_OUTPUT.put_line('table inserted with value '||p_id||' - '||p_desc);
		END IF;
	END insert_in_sql_test;


	PROCEDURE update_sql_test(
		p_id IN sql_test.id%TYPE, p_desc IN sql_test.description%TYPE)
	IS 
	BEGIN
		UPDATE sql_test SET description = p_desc
		WHERE id = p_id;
		IF SQL%ROWCOUNT = 1 THEN
			DBMS_OUTPUT.put_line('table updated with value '||p_id||' - '||p_desc);
		END IF;
	END update_sql_test;

	PROCEDURE delete_from_sql_test(p_id IN sql_test.id%TYPE)
	IS 
	BEGIN
		DELETE FROM sql_test WHERE id = p_id ;
		IF SQL%ROWCOUNT = 1 THEN
			DBMS_OUTPUT.put_line('record deleted with value '||p_id);
		END IF;
	END delete_from_sql_test;

	PROCEDURE delete_from_sql_test(p_desc IN sql_test.description%TYPE)
	IS 
	BEGIN
		DELETE FROM sql_test WHERE UPPER(description) = UPPER(p_desc);
		IF SQL%ROWCOUNT = 1 THEN
			DBMS_OUTPUT.put_line('record deleted with value '||p_desc);
		END IF;
	END delete_from_sql_test;
		

END sql_test_dml_utility;
/

SHO ERR;

prompt ---> TABLE RESULT ---->;
SELECT * FROM sql_test;

prompt ----- Unit testing for Insert statemtnt ------>;
DECLARE
	l_id 	sql_test.id%TYPE;
BEGIN
	SELECT MAX(id) + 1 INTO l_id FROM sql_test;
	-- insert record
	 sql_test_dml_utility.insert_in_sql_test(l_id, 'value-'||TO_CHAR(l_id));
	 sql_test_dml_utility.insert_in_sql_test(l_id + 1, 'value-'||TO_CHAR(l_id + 1));
END;
/

prompt ---> AFTER INSERT RESULT ---->;
SELECT * FROM sql_test;

prompt ----- Unit testing for Update statemtnt ------>;
BEGIN
	-- update record	
	 sql_test_dml_utility.update_sql_test(4,'four');
	 sql_test_dml_utility.update_sql_test(5,'five');
END;
/

prompt ---> AFTER UPDATE RESULT ---->;
SELECT * FROM sql_test;

prompt ----- Unit testing for Delete statemtnt ------>;
BEGIN
	-- delete record
	 sql_test_dml_utility.delete_from_sql_test(5);
	 sql_test_dml_utility.delete_from_sql_test('four');

END;
/

prompt ---> AFTER DELETE RESULT ---->;
SELECT * FROM sql_test;

