/*
|	Program: RECORDs 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE
	-- define a record manually.
	TYPE t_all_users_record IS RECORD (
		username	VARCHAR2(30),
		user_id 	NUMBER,
		created 	DATE
	);

	-- declare record variabel using the manual and %ROWTYPE methods
	t_all_users_record_1 t_all_users_record;
	t_all_users_record_2 all_users%ROWTYPE;
BEGIN
	-- return some data into once record structure.
	SELECT username,user_id,created
	INTO t_all_users_record_1
	FROM all_users
	WHERE username = 'SYS';

	-- Display the contents of the first record.
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_1.username = '||t_all_users_record_1.username);
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_1.user_id = '||t_all_users_record_1.user_id);
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_1.created = '||t_all_users_record_1.created);

	
	SELECT *
	INTO t_all_users_record_2
	FROM all_users
	WHERE username = 'SYS';

	-- assign values to the second record structue in a single operation
	-- t_all_users_record_2 := t_all_users_record_1;

	-- Display the contents of the second record.
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_2.username = '||t_all_users_record_2.username);
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_2.user_id = '||t_all_users_record_2.user_id);
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_2.created = '||t_all_users_record_2.created);

	t_all_users_record_1 := NULL;
	-- Display the contents of the first record after deletion.
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_1.username = '||t_all_users_record_1.username);
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_1.user_id = '||t_all_users_record_1.user_id);
	DBMS_OUTPUT.PUT_LINE('t_all_users_record_1.created = '||t_all_users_record_1.created);

END;
/
	
