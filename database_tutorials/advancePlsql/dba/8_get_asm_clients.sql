/*
||	Program: get_asm_clients.sql 
||	Author: codelocked
||	Change history:
||		22-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --		Get ASM Clients			--;
prompt ---------------------------------------------------;

ALTER SESSION SET container = ORCLPDB1;

set head off
set feedback off
set pagesize 100
set linesize 100
set timi off

select ';'||asm_clients.col
from dual,  (select count(*) cnt, listagg(db_name||','||instance_name,';') within group (order by instance_name) col from (select distinct db_name, instance_name from v$asm_client where db_name not like '+%' and db_name not like '\_%' escape '\')) asm_clients
where asm_clients.cnt > 0;




