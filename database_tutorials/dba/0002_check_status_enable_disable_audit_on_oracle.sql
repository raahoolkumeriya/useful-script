/*
||	Program: Smart Way of Technology | DBA
||		--> Check status, enable and disable the Audit in Oracle 
||	Author: codelocked
||	Change history:
||		1-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- Check status, enable and disable the Audit in Oracle --;
prompt ---------------------------------------------------;

show parameter audit_trail;


prompt --Check the parameter is enabled or disable for Audit
select name || '=' || value PARAMETER from sys.v_$parameter where name like '%audit%';


prompt --Statement Audits Enabled on this Database
column user_name format a10
column audit_option format a40
select * from sys.dba_stmt_audit_opts;


prompt --Privilege Audits Enabled on this Database
select * from dba_priv_audit_opts;


prompt -- Object Audits Enabled on this Database
select (owner ||'.'|| object_name) object_name,
alt, aud, com, del, gra, ind, ins, loc, ren, sel, upd, ref, exe
from dba_obj_audit_opts
where alt != '-/-' or aud != '-/-'
or com != '-/-' or del != '-/-'
or gra != '-/-' or ind != '-/-'
or ins != '-/-' or loc != '-/-'
or ren != '-/-' or sel != '-/-'
or upd != '-/-' or ref != '-/-'
or exe != '-/-';
