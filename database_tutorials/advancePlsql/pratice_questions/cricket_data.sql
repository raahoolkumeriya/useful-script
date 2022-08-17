/*
||	Program: Create and Insert Cricket data 
||	Author: codelocked
||	Change history:
||		02-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt -- Create and Insert Cricket data 		--;
prompt ---------------------------------------------------;

DROP TABLE cricket; 

CREATE TABLE cricket (
	match_no	NUMBER,
	team_a		CHAR(30),
	team_b		CHAR(30),
	winner		CHAR(30)
);

INSERT into cricket values(01,'WESTINDIES','SRILANKA','WESTINDIES');
INSERT into cricket values(02,'INDIA','SRILANKA','INDIA');
INSERT into cricket values(03,'AUSTRALIA','SRILANKA','AUSTRALIA');
INSERT into cricket values(04,'WESTINDIES','SRILANKA','SRILANKA');
INSERT into cricket values(05,'AUSTRALIA','INDIA','AUSTRALIA');
INSERT into cricket values(06,'WESTINDIES','SRILANKA','WESTINDIES');
INSERT into cricket values(07,'INDIA','WESTINDIES','WESTINDIES');
INSERT into cricket values(08,'WESTINDIES','AUSTRALIA','AUSTRALIA');
INSERT into cricket values(09,'WESTINDIES','INDIA','INDIA');
INSERT into cricket values(10,'AUSTRALIA','WESTINDIES','WESTINDIES');
INSERT into cricket values(11,'WESTINDIES','SRILANKA','WESTINDIES');
INSERT into cricket values(12,'INDIA','AUSTRALIA','INDIA');
INSERT into cricket values(13,'SRILANKA','NEWZEALAND','SRILANKA');
INSERT into cricket values(14,'NEWZEALAND','INDIA','INDIA');

COMMIT;

