/*
||	Program: Create, Alter, Resize, Drop Tablespace 
||	Author: codelocked
||	Change history:
||		22-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --  		Check Tablespace		--;
prompt ---------------------------------------------------;

SELECT tablespace_name FROM dba_tablespaces;

COL FILE_NAME FORMAT A60;

SELECT file_id, file_name, tablespace_name FROM dba_data_files;

prompt ---------------------------------------------------;
prompt --  		CREATE NEW TABLESPACE		--;
prompt ---------------------------------------------------;

CREATE tablespace rahul datafile '/u02/app/oracle/oradata/ORCLCDB/orclpdb1/rahul01.dbf'
SIZE 10m
AUTOEXTEND ON NEXT 1m
MAXSIZE 20m
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO
LOGGING;

SELECT file_id, file_name, tablespace_name FROM dba_data_files;

prompt ---------------------------------------------------;
prompt --  		ALTER TABLESPACE		--;
prompt ---------------------------------------------------;

ALTER tablespace rahul add datafile '/u02/app/oracle/oradata/ORCLCDB/orclpdb1/rahul02.dbf' 
SIZE 10m;

SELECT file_id, file_name, tablespace_name, bytes/1024/1024 "in MB"  FROM dba_data_files;

ALTER database datafile 22 resize 15m;

SELECT file_id, file_name, tablespace_name, bytes/1024/1024 "in MB"  FROM dba_data_files;

ALTER database datafile '/u02/app/oracle/oradata/ORCLCDB/orclpdb1/rahul01.dbf' resize 20m;

SELECT file_id, file_name, tablespace_name, bytes/1024/1024 "in MB"  FROM dba_data_files;

prompt ---------------------------------------------------;
prompt --  		DROP TABLESPACE			--;
prompt ---------------------------------------------------;

DROP tablespace rahul including contents and datafiles;

SELECT file_id, file_name, tablespace_name, bytes/1024/1024 "in MB"  FROM dba_data_files;
