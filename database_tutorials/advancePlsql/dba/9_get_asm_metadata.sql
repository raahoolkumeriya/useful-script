/*
||	Program: get_asm_metadata.sql 
||	Author: codelocked
||	Change history:
||		22-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --		Get ASm Metadata		--;
prompt ---------------------------------------------------;

ALTER SESSION SET container = ORCLPDB1;

set head off
set feedback off
set pagesize 100
set linesize 100
set timi off
select ';'||
(select instance_name from v$instance) ||';'||
-- (select col from (select regexp_substr(banner,'CORE\s+(\d+\.\d\.\d\.\d\.\d)',1,1,'i',1) col from v$version) where col is not null) ||';'||
(select version from v$instance)||';'||
(select value from v$parameter where name = 'cluster_database')||';'||
(select listagg(instance_name,',') within group (order by instance_number) instance_list from gv$instance) ||';'||
(select status from v$instance where status in ('MOUNTED','STARTED')) ||';'||
(select host_name from v$instance) db_metadata
from dual;


