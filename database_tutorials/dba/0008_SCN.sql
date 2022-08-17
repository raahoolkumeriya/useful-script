/*
||	Program: ASK Tom
||		--> https://asktom.oracle.com/pls/apex/f?p=100:11:0::::P11_QUESTION_ID:48052838748707 
||	Author: codelocked
||	Change history:
||		17-Aug-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	SCN system change Number 		--;
prompt ---------------------------------------------------;

SELECT dbms_flashback.get_system_change_number scn 
FROM dual;

COL username FOR A30;

SELECT username, program 
FROM v$session;

