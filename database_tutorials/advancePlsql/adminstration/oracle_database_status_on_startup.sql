/*
|	Program: Start Oracle Database 
|	Author: Raahool Kumeriya
|	Change history:
|		07-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		Start Oracle Database		--;
prompt ---------------------------------------------------;

SELECT 
    instance_name, 
    status 
FROM 
    v$instance;


prompt ---------------------------------------------------;
prompt --     		Tablespace			--;
prompt ---------------------------------------------------;

COL FILE_NAME FORMAT A50;
SELECT 
   tablespace_name, 
   file_name, 
   bytes / 1024/ 1024  MB
FROM
   dba_data_files;


SELECT * FROM DBA_TABLESPACE_GROUPS;

prompt ---------------------------------------------------;
prompt --     		CREATE USER			--;
prompt ---------------------------------------------------;

COL USERNAME FORMAT A30;
COL PROFILE FORMAT A30;

SELECT 
    username, 
    default_tablespace, 
    profile, 
    authentication_type
FROM
    dba_users
WHERE 
    account_status = 'OPEN';


prompt ---------------------------------------------------;
prompt --     		GRANT USER			--;
prompt ---------------------------------------------------;

SELECT * FROM session_privs;

prompt ---------------------------------------------------;
prompt --     		List Users			--;
prompt ---------------------------------------------------;

SELECT * FROM all_users;


COL USERNAME FORMAT A10;
COL USER_ID FORMAT A7;
COL PASSWORD FORMAT A10;
COL ACCOUNT_STATUS FORMAT A10;
COL DEFAULT_TABLESPACE FORMAT A10;
COL TEMPORARY_TABLESPACE FORMAT A10;
COL LOCAL_TEMP_TABLESPACE FORMAT A10;
COL PROFILE FORMAT A5;
COL INITIAL_RSRC_CONSUMER_GROUP FORMAT A10;
COL EXTERNAL_NAME FORMAT A10;
COL DEFAULT_COLLATION FORMAT A10;
COL LAST_LOGIN FORMAT A10;


SELECT * FROM dba_users;

COL USERNAME FORMAT A10;
COL ACCOUNT_STATUS FORMAT A10;
COL DEFAULT_TABLESPACE FORMAT A15;
COL TEMPORARY_TABLESPACE FORMAT A10;
COL LOCAL_TEMP_TABLESPACE FORMAT A10;
COL INITIAL_RSRC_CONSUME FORMAT A10;
COL EXTERNAL_NAME FORMAT A10;
SELECT * FROM user_users;

prompt ---------------------------------------------------;
prompt --     		Profiles			--;
prompt ---------------------------------------------------;
COL PROFILE FORMAT A30;
COL LIMIT FORMAT A20;
SELECT 
  * 
FROM 
    dba_profiles
WHERE 
    PROFILE = 'DEFAULT'
ORDER BY 
    resource_type, 
    resource_name;

