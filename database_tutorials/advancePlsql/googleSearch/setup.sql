/*
|	Program: Building a Google-search 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    	Building a Google-search 		--;
prompt ---------------------------------------------------;

alter session set container = ORCLPDB1;
show con_name;

CREATE TABLE AXIOMUS.bigtab as 
	SELECT e.*,
		date '2020-01-01' + rownum/140 dte,
		rpad('x',1000) padding
	FROM AXIOMUS.employees e,
		( SELECT 1 FROM dual
		CONNECT BY level <= 10005 ) 
	WHERE rownum <= 140003;

SELECT min(dte), max(dte) 
FROM AXIOMUS.bigtab;



