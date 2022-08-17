/*
||	Program: Bright DBA
||		--> http://www.br8dba.com/category/dataguard/
||	Author: codelocked
||	Change history:
||		02-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	DATAGUARD and SWITCH 			--;
prompt ---------------------------------------------------;

prompt ---------------------------------------------------;
prompt [oracle@7c1faf5df40c /]$ dgmgrl								;
prompt DGMGRL for Linux: Release 12.2.0.1.0 - Production on Tue Aug 2 16:26:32 2022		;
	
prompt Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.		;

prompt Welcome to DGMGRL, type "help" for information.							;
prompt DGMGRL> connect sys@ORCLPDB1									;
prompt Password:											;
prompt Connected to "ORCLCDB"										;
prompt Connected as SYSDBA.										;
prompt DGMGRL>												;
prompt DGMGRL>  show configuration;									;

prompt Configuration - ORCLPDB1										;
		
prompt   Protection Mode: MaxPerformance								;
prompt   Members:											;
prompt   ORCLPDB1    - Primary database									;
prompt     ORCLPDB1_DG - Physical standby database							;
	
prompt Fast-Start Failover: DISABLED									;

prompt Configuration Status:										;
prompt SUCCESS   (status updated 35 seconds ago)							;
	
prompt DGMGRL>												;
prompt DGMGRL> DISABLE CONFIGURATION; <----								;
prompt Disabled.											;
prompt DGMGRL>												;
prompt DGMGRL> show configuration									;


COL OWNER FORMAT A50;
COL TABLE_NAME FOMRAT A50;

select name,open_mode,database_role from v$database;


show parameter DG_BROKER_START;

prompt ALTER SYSTEM SET DG_BROKER_START=FALSE;

prompt -----------------------------;
prompt -- Verify INVALID OBJECTS ---;
prompt -----------------------------;
select count(*) from dba_objects where status='INVALID';

prompt -----------------------------;
prompt -- Verify Protection mode  --;
prompt -----------------------------;
SELECT NAME,OPEN_MODE,DATABASE_ROLE,PROTECTION_MODE FROM V$DATABASE;

prompt ------------------------------------;
prompt -- Verify fast_recovery_area size --;
prompt ------------------------------------;

show parameter db_recovery_file_dest;


select owner from dba_logstdby_skip where statement_opt = 'INTERNAL SCHEMA' order by owner;

prompt --------------------------------------------;
prompt -- Find list of objects are not supported --;
prompt --------------------------------------------;

select distinct owner, table_name from dba_logstdby_unsupported order by owner,table_name;

prompt --------------------------------------------;
prompt -- Find list of objects are not supported --;
prompt --------------------------------------------;

SELECT OWNER, TABLE_NAME,BAD_COLUMN FROM DBA_LOGSTDBY_NOT_UNIQUE;

select owner, table_name from dba_logstdby_not_unique where (owner, table_name) not in (select distinct owner, table_name from dba_logstdby_unsupported) order by owner, table_name;

prompt ------------------------------------------------------------;
prompt -- Create Flashback Guaranteed Restore Point (On Primary) --;
prompt ------------------------------------------------------------;

select * from V$restore_point;

col name for a20
col GUARANTEE_FLASHBACK_DATABASE for a10
col TIME for a60
set lines 190

select NAME,GUARANTEE_FLASHBACK_DATABASE,TIME from V$restore_point;

prompt -------------------------------;
prompt -- Enable Flashback Database --;
prompt -------------------------------;

select flashback_on from v$database;

show parameter flashback

prompt ----------------;
prompt -- Verify GAP --;
prompt ----------------;

select name,open_mode,db_unique_name,database_role from v$database;


SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last Sequence Received", APPL.SEQUENCE# "Last Sequence Applied", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference" FROM (SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,(SELECT THREAD# ,SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL WHERE ARCH.THREAD# = APPL.THREAD# ORDER BY 1;

prompt ----------------;
prompt -- Cancel MRP --;
prompt ----------------;

select process,status,sequence#,thread# from v$managed_standby where process like 'MRP%';

prompt ---------------------------------------------;
prompt -- Build the logminer dictionary (Primary) --;
prompt ---------------------------------------------;

SELECT * FROM V$LOGSTDBY_STATE WHERE STATE='LOADING DICTIONARY';


prompt --------------------------;
prompt -- Verify DATABASE_ROLE --;
prompt --------------------------;

select name,open_mode,db_unique_name,database_role from v$database;


select guard_status from v$database;


select name,open_mode,db_unique_name,database_role,version from v$database,v$instance;


