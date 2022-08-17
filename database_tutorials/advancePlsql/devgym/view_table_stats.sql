/*
||	Program: Viewing table stats
||	Author: codelocked
||	Change history:
||		09-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	Viewing table stats			--;
prompt ---------------------------------------------------;


COL TABLE_NAME FORMAT A30;
COL COLUMN_NAME FORMAT A30;
COL LOW_VAL FORMAT A40;
COL HIGH_VAL FORMAT A40;

select ut.table_name, ut.num_rows,
       utcs.column_name, utcs.num_distinct,
       case utc.data_type
         when 'VARCHAR2' then
           utl_raw.cast_to_varchar2 ( utcs.low_value )
        when 'NUMBER' then
           to_char ( utl_raw.cast_to_number ( utcs.low_value ) )
       end low_val,
       case utc.data_type
         when 'VARCHAR2' then
           utl_raw.cast_to_varchar2 ( utcs.high_value )
         when 'NUMBER' then
           to_char ( utl_raw.cast_to_number ( utcs.high_value ) )
       end high_val
from   user_tables ut
join   user_tab_cols utc
on     ut.table_name = utc.table_name
join   user_tab_col_statistics utcs
on     ut.table_name = utcs.table_name
and    utc.column_name = utcs.column_name
order  by ut.table_name, utcs.column_name;


