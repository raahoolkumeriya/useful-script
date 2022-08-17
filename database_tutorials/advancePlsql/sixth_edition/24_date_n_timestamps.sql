/*
|	Program: Dates and Timestamps
|	Author: Raahool Kumeriya
|	Change history:
|		11-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		Dates and Timestamps		--;
prompt ---------------------------------------------------;

DECLARE
	hire_date	TIMESTAMP(0) WITH TIME ZONE;
	todays_date	CONSTANT DATE := SYSDATE;
	pay_date	TIMESTAMP DEFAULT TO_TIMESTAMP('20050204','YYYYMMDD');
BEGIN 
	NULL;
END;
/

BEGIN
	DBMS_OUTPUT.PUT_LINE('Session Timezone='||SESSIONTIMEZONE);
	DBMS_OUTPUT.PUT_LINE('Session Timestamp='||CURRENT_TIMESTAMP);
	DBMS_OUTPUT.PUT_LINE('DB Server Timestamp='||SYSTIMESTAMP);
	DBMS_OUTPUT.PUT_LINE('DB Timezone='||DBTIMEZONE);
	      
	EXECUTE IMMEDIATE 'ALTER SESSION SET TIME_ZONE=DBTIMEZONE';
	
	DBMS_OUTPUT.PUT_LINE('DB Timestamp='||CURRENT_TIMESTAMP);
	-- Revert session time zone to local setting
	EXECUTE IMMEDIATE 'ALTER SESSION SET TIME_ZONE=LOCAL';
END;
/


prompt ---------------------------------------------------;
prompt --     		CAST timestamps 		--;		
prompt ---------------------------------------------------;

DECLARE
	ts1 TIMESTAMP;
	ts2 TIMESTAMP;
BEGIN
	ts1 := CAST(SYSTIMESTAMP AS TIMESTAMP);
	ts2 := SYSDATE;
	DBMS_OUTPUT.PUT_LINE(TO_CHAR(ts1, 'DD-MON-YYYY HH:MI:SS AM'));
	DBMS_OUTPUT.PUT_LINE(TO_CHAR(ts2, 'DD-MON-YYYY HH:MI:SS AM'));
END;
/


