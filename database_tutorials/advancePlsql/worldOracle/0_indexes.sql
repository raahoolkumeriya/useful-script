/*
|	Program: Indexes | World of Oracle
|	Author: Raahool Kumeriya
|	Change history:
|		09-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		INDEX				--;
prompt ---------------------------------------------------;
prompt o SIMPLE INDEX: Creating for single column;
prompt - e.g., CREATE INDEX INDX_NAME ON TABLE(COLUMN1);
prompt ---------------------------------------------------;
prompt o COMPOSITE INDEX: Creating for multiple columns;
promtp - e.g., CREATE INDEX INDX_NAME2 ON TABLE(COLUMN1,COLUMN2);
prompt ---------------------------------------------------;
prompt o UNIQUE INDEXL Creating index on unique data (without duplicate row)(PK and UK);
prompt - e.g., CREATE UNIQUE INDEX INDX_NAME3 ON TABLE(COLUMN1);
prompt ---------------------------------------------------;
prompt o NON-UNIQUE INDEX: Creating index on non-unique data ( with duplicate rows);
prompt - e.g., CREATE INDEX INDX_NAME4 ON TABLE(COLUMN1);
prompt ---------------------------------------------------;
prompt o BITMAP INDEX: Column with less cardinality; 
prompt ---------------------------------------------------;
prompt o B-TREE INDEX: Columns with high cardinality;
prompt ---------------------------------------------------;
prompt o FUNCTION-BASED INDEX : Creating index based on function like upper, lower;
prompt ---------------------------------------------------;
prompt  CARDINALITY = ( No. of Distinct rows ) / ( Total No. of Rows );
prompt > If cardinality value is 1 then data is highest cardinality -> B-Tree Index;
prompt > If cardinality value is less than 1 that data is lowest cardinality -> BitMap Index;
prompt ---------------------------------------------------;
