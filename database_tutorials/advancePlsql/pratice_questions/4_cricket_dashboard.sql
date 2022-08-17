/*
||	Program: cricket dashboard 
||	Author: codelocked
||	Change history:
||		02-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- 	Cricket Dashboard			--;
prompt ---------------------------------------------------;
prompt -- how many time each conuntry played in tournament;

SELECT team_name, count(*) FROM (
	SELECT team_a team_name FROM cricket
	UNION ALL
	SELECT team_b FROM cricket)
GROUP BY team_name;

