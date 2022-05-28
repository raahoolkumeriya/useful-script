
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello Codelocked!!!');
END;
/

SET SERVEROUTPUT ON;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Again ... Hello Codelocked!!!');
END;
/

REM Ignore BEGIN and END typing with EXEC 
EXECUTE DBMS_OUTPUT.PUT_LINE('Hello there Codelocked!!');

prompt -- Execute local directory plsql code with @
@sixth_edition/1_integration_with_sql.sql

prompt -- Execute local code with SATRT 
START sixth_edition/1_integration_with_sql.sql

