/*
|	Program: External tables 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		External tables			--;
prompt ---------------------------------------------------;
prompt -- Read only table that point to the OS files;
prompt -- we can Not index table, it does not store data;
prompt -- Can NOT do any DML operations;
prompt -- AdvantageS: - does not hold any memory;
prompt -------------: - Different file can be laoded without changing logic.;
prompt ---------------------------------------------------;

COL OWNER FORMAT A20;
COL DIRECTORY_NAME FORMAT A30;
COL DIRECTORY_PATH FORMAT A70;

select * from all_directories;

CREATE table admins
(
	emp_id	NUMBER(4),
	ename	VARCHAR2(20),
	dname	VARCHAR2(20)
)
organization external
(
	type	oracle_loader
	default	directory AXIOM_EXTERNAL
	access 	parameters
	(
		records delimited by newline
		fields	terminated by ','
	)
	location('names.txt')
)
reject limit unlimited
/


prompt ---------------------------------------------------;
prompt Access external table;
prompt ---------------------------------------------------;
SELECT * from admins;


prompt ---------------------------------------------------;
prompt Show errors with reject limit 0;
prompt ---------------------------------------------------;

drop table admins;

CREATE table admins
(
        emp_id  NUMBER(4),
        ename   VARCHAR2(20),
        dname   VARCHAR2(20)
)
organization external
(
        type    oracle_loader
        default directory AXIOM_EXTERNAL
        access  parameters
        (
                records delimited by newline
                fields  terminated by ','
        )
        location('names.txt')
)
reject limit 0
/


prompt ---------------------------------------------------;
prompt Access external table;
prompt ---------------------------------------------------;
SELECT * from admins;


