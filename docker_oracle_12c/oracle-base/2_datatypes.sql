/*
|	Program: TYPE and ROWTYPE 
|	Author: Raahool Kumeriya
|	Change history:
|		15-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE
	-- specific column from table
	l_username 	all_users.username%TYPE;
	
	-- whole record from table
	l_all_users_row	all_users%ROWTYPE;

	CURSOR cur_user	IS
		SELECT username, created
		FROM 	all_users
		WHERE username = 'SYS';

	-- Record that matches cursor definition
	l_all_user_cursor_row	cur_user%ROWTYPE;
BEGIN
	-- specfic column from table
	SELECT username
	INTO l_username
	FROM all_users
	WHERE username = 'SYS';

	DBMS_OUTPUT.PUT_LINE('l_username = '||l_username);

	-- whole record form tables
	SELECT * 
	INTO l_all_users_row
	FROM all_users
	WHERE username = 'SYS';

	DBMS_OUTPUT.PUT_LINE('l_all_users_row.username = '||l_all_users_row.username);
	DBMS_OUTPUT.PUT_LINE('l_all_users_row.user_id = '||l_all_users_row.user_id);
	DBMS_OUTPUT.PUT_LINE('l_all_users_row.created = '||l_all_users_row.created);

	-- record that matches cursor definition
	OPEN cur_user ;
	FETCH cur_user INTO l_all_user_cursor_row;
	CLOSE cur_user;

	DBMS_OUTPUT.PUT_LINE('l_all_user_cursor_row.username = '||l_all_user_cursor_row.username);
	DBMS_OUTPUT.PUT_LINE('l_all_user_cursor_row.created = '||l_all_user_cursor_row.created);
END;
/


prompt -----------------------------------;
prompt Assignment methods;
prompt -----------------------------------;

DECLARE
	l_number 	NUMBER;
	PROCEDURE 	add(p1	IN	NUMBER, p2 IN NUMBER , p3 OUT NUMBER) AS
	BEGIN
		p3 := p1 + p2;
	END;
BEGIN
	-- Direct assignment 
	l_number := 1;
	DBMS_OUTPUT.PUT_LINE('Direct assignment  way : '||l_number);
	
	-- Assignment via a select 
	SELECT 1 INTO l_number 
	FROM DUAL;
	DBMS_OUTPUT.PUT_LINE('Assignment via select way : '||l_number);
	
	-- Assignment via a Procedure call
	add(1,2,l_number);
	DBMS_OUTPUT.PUT_LINE('procedure way : '||l_number);
END;
/
