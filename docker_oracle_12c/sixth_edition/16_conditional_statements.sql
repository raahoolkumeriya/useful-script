/*
|	Program: Case Expression
|	Author: Raahool Kumeriya
|	Change history:
|		06-May-2022	Program created.
|*/

SET SERVEROUTPUT ON;

DECLARE
	boolean_true	BOOLEAN	:= TRUE;
	boolean_false	BOOLEAN := FALSE;
	boolean_null	BOOLEAN;
	
	FUNCTION boolean_to_varchar2(flag IN BOOLEAN) 
	RETURN VARCHAR2 IS
	BEGIN
		RETURN 
			CASE flag
				WHEN	TRUE	THEN 'True'
				WHEN	FALSE	THEN 'False'
				ELSE	'NULL'
			END;
	END;
	
BEGIN
	DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_true));
	DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_false));
	DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_null));
END;
/

