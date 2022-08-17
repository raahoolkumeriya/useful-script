/*
|	Program: Materialized Views | World of Oracle
|	Author: Raahool Kumeriya
|	Change history:
|		09-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;


prompt ---------------------------------------------------;
prompt --    Materialized Views / Sanpshots             --;
prompt ---------------------------------------------------;
prompt As we know Normal Views we use for security purpose;
prompt o also called as Snapshots;
prompt o Database object which physically store the output of query and help us in Performance improvement.;
prompt o Store the o/p of a query;
prompt o Refresh on its own whenever base table gets affected;
prompt ---------------------------------------------------;
prompt ------   Intervals of Refresh ----------------------;
prompt ---------------------------------------------------;
prompt o Manual Refresh : --> refresh on demand;
prompt --------> Manual refresh can be done with DBMS_SNAPSHOT.REFRESH_MVIEW package;
prompt o Automatic Refresh : --> refresh on commit;
prompt ---------------------------------------------------;

prompt ---------------------------------------------------;
prompt --       Types of Refresh                        --;
prompt ---------------------------------------------------;
prompt o Complete (full) Refresh: --> When base table modified Mview get truncated first and then it again reloaded;
prompt o Fast Refresh: Updated record in base only those are updated. To fast refresh mvlog file is mandatory. If it is corrupted fast refresh will not work.;
prompt o Force Refresh: In case of Fast refresh fails, Force refresh first will try fast refresh it fails then it will do the complete refresh.;
prompt ---------------------------------------------------;
prompt Creating Mview;
prompt ---------------------------------------------------;

/*
CREATE  materialized VIEW employees_mview
REFRESH COMPLETE ON COMMIT 
ENABLE QUERY REWRITE
AS 
	SELECT department_id, sum(salary) 
	FROM employees_bk 
	GROUP BY department_id;

prompt ---------------------------------------------------;
prompt Checking Mview content;
prompt ---------------------------------------------------;
SELECT * FROM employees_mview;
*/

prompt ---------------------------------------------------;
prompt insert into original table;
prompt ---------------------------------------------------;

INSERT INTO employees_bk values (1000,'STALIN','COMPUTER',8989,'03-MAR-14',10000,0,50);


prompt ---------------------------------------------------;
prompt  Commit original table insert;
prompt ---------------------------------------------------;
commit;

prompt ---------------------------------------------------;
prompt Checking Mview content after Commit which is automatically udpated;
prompt ---------------------------------------------------;
SELECT * FROM employees_mview;


