/*
|	Program: 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     --;
prompt ---------------------------------------------------;

SHOW con_name;

SELECT name, pdb
FROM   v$services
ORDER BY name;

show con_name;
-- Switch container while connected to a common user.
alter session set container = ORCLPDB1;

show con_name;

