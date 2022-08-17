/*
|	Program: Bulk operations 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     --;
prompt ---------------------------------------------------;

CREATE TABLE local_objects AS
	SELECT * FROM all_objects
/

SELECT count(*) FROM local_objects;

