/*
||	Program: Smart Way of Technology | DBA
||		--> Check primary and standby databases are in sync Dataguard 
||	Author: codelocked
||	Change history:
||		1-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --Check primary and standby databases are in sync Dataguard--;
prompt ---------------------------------------------------;

--alter system archive log current;

select thread#, max(sequence#) "Last Primary Seq Generated" from v$archived_log val, v$database vdb where val.resetlogs_change# = vdb.resetlogs_change# group by thread# order by 1;


--Check received log on standby
select thread#, max(sequence#) "Last Standby Seq Received" from v$archived_log val, v$database vdb where val.resetlogs_change# = vdb.resetlogs_change# group by thread# order by 1;

--Check applied log on standby
select thread#, max(sequence#) "Last Standby Seq Applied" from v$archived_log val, v$database vdb where val.resetlogs_change# = vdb.resetlogs_change# and val.applied in ('YES','IN-MEMORY') group by thread# order by 1;



