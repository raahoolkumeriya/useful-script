/*
||	Program: Create xdual tabel with Index on it 
||	Author: Raahool Kumeriya
||	Change history:
||		14-JUN-2022 - Program Created
*/
SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --   Create xdual tabel with Index on it  	--;
prompt ---------------------------------------------------;
/*
create table xdual (
   dummy varchar2(1) primary key
)
organization index;


insert into xdual SELECT * FROM DUAL;
*/

SELECT * from xdual;

