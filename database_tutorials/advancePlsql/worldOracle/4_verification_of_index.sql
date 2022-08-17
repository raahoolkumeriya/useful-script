/*
|	Program: Verify Index | World of Oracle
|	Author: Raahool Kumeriya
|	Change history:
|		09-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;


prompt ---------------------------------------------------;
prompt --               INDEX Options                   --;
prompt ---------------------------------------------------;
prompt o A unique Index ensure that every indexed value is unique;
prompt o An index can have its key values stored in ascending or descending order;
prompt o A reverse key index index has its key value bytes stored in reverse order;
prompt o A composite index is one that is based on more than one column;
prompt o A function-based index is an index based on a function's return value;
prompt o A compressed insex has repeated key values removed.;
prompt ---------------------------------------------------;

prompt ---------------------------------------------------;
prompt --     		Verify Index			--;
prompt ---------------------------------------------------;

COL index_name FORMAT A30;

SELECT index_name, index_type,uniqueness
	FROM user_indexes 
	WHERE lower(table_name) = 'employees_bk';


