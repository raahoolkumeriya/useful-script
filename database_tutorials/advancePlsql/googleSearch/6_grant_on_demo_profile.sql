/*
|	Program: 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --   GRANT all on DEMO_PROFILE		  --;
prompt ---------------------------------------------------;

select username from dba_users where username='axiomus';

--Grant all on sql translation profile DEMO_PROFILE to AXIOMUS;

-- alter session set sql_translation_profile = DEMO_PROFILE;

