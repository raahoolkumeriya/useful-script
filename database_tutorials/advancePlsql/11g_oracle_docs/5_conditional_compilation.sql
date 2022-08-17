/*
|	Program: Code for Checking Database Version 
|	Author: Raahool Kumeriya
|	Change history:
|		29-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     Code for Checking Database Version        --;
prompt ---------------------------------------------------;

BEGIN
	$IF DBMS_DB_VERSION.VER_LE_10_1 $THEN		-- selection directive begin
		$ERROR 'unsupported databse release' $END   --- error directive
	$ELSE
		DBMS_OUTPUT.PUT_LINE(
			'Release '||DBMS_DB_VERSION.VERSION ||'.'||
				DBMS_DB_VERSION.RELEASE || ' is supported.'
		);
		-- This COMMIT syntax is newly supported in 10.2.
		COMMIT WRITE IMMEDIATE NOWAIT;
	$END						-- selctive directive ends
END;
/
