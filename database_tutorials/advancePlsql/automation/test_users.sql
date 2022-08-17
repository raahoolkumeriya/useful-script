/*
||	Program: Users in databse
||	Author: Raahool Kumeriya
||	Change history:
||		15-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

ALTER SESSION SET container = ORCLPDB1;

prompt ---------------------------------------------------;
prompt --     		USERS in database		--;
prompt ---------------------------------------------------;

COL USERNAME FORMAT A30;
COL DEFAULT_COLLATION FORMAT A30;

SELECT * FROM all_users
ORDER BY created;


-- SELECT USERNAME  FROM dba_users;

-- SELECT USERNAME FROM user_users;

