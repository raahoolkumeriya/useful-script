/*
|	Program: Checking simple query on database 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     Checking simple query on database		--;
prompt ---------------------------------------------------;
COL PADDING FORMAT A30;

set autotrace on stat

select *
from axiomus.bigtab
where dte >= to_date('2022-09-27','YYYY-MM-DD');

prompt -------------------------------------------------------;
prompt above query is taking very big physical IO ;
prompt -------------------------------------------------------;

create index axiomus.bigtab_ix 
	on axiomus.bigtab (dte);

select *
from axiomus.bigtab
where dte >= to_date('2022-09-27','YYYY-MM-DD');

