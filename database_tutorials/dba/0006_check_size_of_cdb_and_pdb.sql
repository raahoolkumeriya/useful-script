/*
||	Program: Smart Way of Technology | DBA
||		--> Check the Size of Oracle Database and PDB databases 
||	Author: codelocked
||	Change history:
||		1-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- Check the Size of Oracle Database and PDB databases --;
prompt ---------------------------------------------------;



prompt ---Check the database size physical consume on disk.;

select sum(bytes)/1024/1024 size_in_mb from dba_data_files;

prompt --Check the total space used by the data.;

select sum(bytes)/1024/1024 size_in_mb from dba_segments;

prompt ---Check the size of the User or Schema in Oracle.;

select owner, sum(bytes)/1024/1024 Size_MB from dba_segments group by owner;

prompt ---Check free space and used space in the database.;

select
"Reserved_Space(MB)", "Reserved_Space(MB)" - "Free_Space(MB)" "Used_Space(MB)","Free_Space(MB)"
from(
select
(select sum(bytes/(1014*1024)) from dba_data_files) "Reserved_Space(MB)",
(select sum(bytes/(1024*1024)) from dba_free_space) "Free_Space(MB)"
from dual );

prompt --Check overall size of database plus temp files plus redo file.;

select
( select sum(bytes)/1024/1024/1024 data_size from dba_data_files ) +
( select nvl(sum(bytes),0)/1024/1024/1024 temp_size from dba_temp_files ) +
( select sum(bytes)/1024/1024/1024 redo_size from sys.v_$log ) +
( select sum(BLOCK_SIZE*FILE_SIZE_BLKS)/1024/1024/1024 controlfile_size from v$controlfile) "Size in GB"
from
dual;


prompt --Check the PDB Size of the databases;

select con_id, name, open_mode, total_size/1024/1024/1024 "PDB_SIZE_GB" from v$pdbs;


prompt --- Check the CDB Size of the databases;

select sum(bytes)/1024/1024/1024 from cdb_data_files;
