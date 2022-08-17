/*
||	Program: Smart Way of Technology | DBA
||		--> Check the Undo tablespace Usage in Oracle 
||	Author: codelocked
||	Change history:
||		1-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --  Check the Undo tablespace Usage in Oracle 	--;
prompt ---------------------------------------------------;

prompt -- Check the undo tablespace total, free and used space(Size in MB) in Oracle --;

SELECT a.tablespace_name,
SIZEMB,
USAGEMB,
(SIZEMB - USAGEMB) FREEMB
FROM ( SELECT SUM (bytes) / 1024 / 1024 SIZEMB, b.tablespace_name
FROM dba_data_files a, dba_tablespaces b
WHERE a.tablespace_name = b.tablespace_name AND b.contents like 'UNDO'
GROUP BY b.tablespace_name) a,
( SELECT c.tablespace_name, SUM (bytes) / 1024 / 1024 USAGEMB
FROM DBA_UNDO_EXTENTS c
WHERE status <> 'EXPIRED'
GROUP BY c.tablespace_name) b
WHERE a.tablespace_name = b.tablespace_name;


prompt -- Check the Active, expired and unexpired transaction space usage in Undo Tablespace --;
prompt ---> ACTIVE: Status show us the active transaction going in database, utilizing the undo tablespace and cannot be truncated.;
prompt ---> EXPIRED: Status show us the transaction which is completed and complete the undo_retention time and now first candidate for trucated from undo tablespace.'
prompt ---> UNEXPIRED: Status show us the transaction which is completed but not completed the undo retention time. It can be trucated if required.;

select tablespace_name tablespace, status, sum(bytes)/1024/1024 sum_in_mb, count(*) counts
from dba_undo_extents
group by tablespace_name, status order by 1,2;

prompt -- Check undo usage by User or schema ;

select u.tablespace_name tablespace, s.username, u.status, sum(u.bytes)/1024/1024 sum_in_mb, count(u.segment_name) seg_cnts
from dba_undo_extents u, v$transaction t , v$session s
where u.segment_name = '_SYSSMU' || t.xidusn || '$' and t.addr = s.taddr
group by u.tablespace_name, s.username, u.status order by 1,2,3;

