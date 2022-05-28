/*
|	Program: Execute profiler 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

/*
EXEC DBMS_PROFILER.START_PROFILER ('MY_TEST_PERFORMANCE_RUN1');
EXEC proc_a;
EXEC DBMS_PROFILER.STOP_PROFILER();
*/

COL UNIT_TYPE FORMAT A20;
COL UNIT_OWNER FORMAT A30;
COL UNIT_NAME FORMAT A20;
COL RUN_OWNER  FORMAT A30;
COL RUN_SYSTEM_INFO  FORMAT A30;
COL RUN_COMMENT1  FORMAT A30;
COL RUN_COMMENT FORMAT A25;
COL SPARE1 FORMAT A30;

prompt -------------------------------------------------------;
prompt PLSQL_PROFILER_RUNS -- Contains one row for each execution;
prompt -------------------------------------------------------;

select * from PLSQL_PROFILER_RUNS;

prompt -------------------------------------------------------;
prompt PLSQL_PROFILER_UNITS captures inforamtion about what all the API/units as part of profiler;
prompt -------------------------------------------------------;
select * from PLSQL_PROFILER_UNITS;

prompt -------------------------------------------------------;
prompt PLSQL_PROFILER_DATA capture information about line by line details how much time take and how many time line execute;
prompt -------------------------------------------------------;
select * from PLSQL_PROFILER_DATA;


prompt -------------------------------------------------------;
prompt JOIN summary ;
prompt -------------------------------------------------------;

SELECT 
	runs.run_date,
	runs.run_comment,
	units.unit_type,
	units.unit_name,
	data.line#,
	data.total_occur,
	data.total_time,
	data.min_time,
	data.max_time,
	ROUND(data.total_time/1000000000) total_time_in_sec,
	TRUNC(((data.total_time)/(sum(data.total_time) OVER()))*100,2) pct_of_time_taken
FROM
	PLSQL_PROFILER_RUNS runs, 
	PLSQL_PROFILER_UNITS units,
	PLSQL_PROFILER_DATA data
WHERE 	data.total_time > 0
AND	data.runid = runs.runid
AND	units.unit_number = data.unit_number
AND	units.runid = runs.runid
ORDER BY
	data.total_time DESC;



