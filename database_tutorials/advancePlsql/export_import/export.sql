/*
|	Program: Export Table 
|	Author: Raahool Kumeriya
|	Change history:
|		07-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     	   EXPORT table with expdp		--;
prompt ---------------------------------------------------;

COL OWNER FORMAT A20;
COL DIRECTORY_NAME FORMAT A30;
COL DIRECTORY_PATH FORMAT A80;
COL ORIGIN_CON_ID FORMAT A40;

CREATE DIRECTORY axiom_external AS '/u01/STUFF';

SELECT * FROM ALL_DIRECTORIES ;

-- SELECT * FROM DBA_DIRECTORIES;


