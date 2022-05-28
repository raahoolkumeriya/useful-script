prompt 	Struture of the PLSQL block 
prompt 	--> HEADER 
prompt  IS
prompt  --> Declaration Section
prompt  BEGIN
prompt  ----> Execution section
prompt  EXCEPTION
prompt  ----> Exception Section
prompt  END;


SET SERVEROUTPUT ON;

prompt -- Bare minimum Anonymous block
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello Codelocked!!!');
END;
/

prompt -- Declration section
DECLARE
	l_right_now	VARCHAR2(9);
BEGIN
	l_right_now := SYSDATE;
	DBMS_OUTPUT.PUT_LINE(l_right_now);
END;
/

prompt -- with exception handling
DECLARE
	l_right_now	VARCHAR2(5);
BEGIN
	l_right_now := SYSDATE;
	DBMS_OUTPUT.PUT_LINE(l_right_now);
EXCEPTION
	WHEN VALUE_ERROR
	THEN
		DBMS_OUTPUT.PUT_LINE('I bet l_right_now is too small '
			|| 'for the default date format!');
END;
/


show errors
