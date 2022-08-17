/*
||	Program: Smart Way of Technology | DBA
||		--> Find the temp usage by sessions in Oracle
||	Author: codelocked
||	Change history:
||		1-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	Find the temp usage by sessions in Oracle --;
prompt ---------------------------------------------------;

prompt --Check the temp usage by sessions;

SELECT b.tablespace,
ROUND(((b.blocks*p.value)/1024/1024),2)||'M' AS temp_size,
a.inst_id as Instance,
a.sid||','||a.serial# AS sid_serial,
NVL(a.username, '(oracle)') AS username,
a.program, a.status, a.sql_id
FROM gv$session a, gv$sort_usage b, gv$parameter p
WHERE p.name = 'db_block_size' AND a.saddr = b.session_addr
AND a.inst_id=b.inst_id AND a.inst_id=p.inst_id
ORDER BY temp_size desc;

prompt -- Find the temp tablespace usage;

select a.tablespace_name tablespace,
d.TEMP_TOTAL_MB,
sum (a.used_blocks * d.block_size) / 1024 / 1024 TEMP_USED_MB,
d.TEMP_TOTAL_MB - sum (a.used_blocks * d.block_size) / 1024 / 1024 TEMP_FREE_MB
from v$sort_segment a,
(
select b.name, c.block_size, sum (c.bytes) / 1024 / 1024 TEMP_TOTAL_MB
from v$tablespace b, v$tempfile c
where b.ts#= c.ts#
group by b.name, c.block_size
) d
where a.tablespace_name = d.name
group by a.tablespace_name, d.TEMP_TOTAL_MB;

prompt --Check detail of size and free space in TEMP;

SELECT * FROM dba_temp_free_space;

