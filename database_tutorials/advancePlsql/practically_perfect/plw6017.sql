/*
|	Program: PL/SQL Tips and Techniques 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';
/

CREATE OR REPLACE PROCEDURE plw6017
	AUTHID CURRENT_USER
IS
	c 	VARCHAR2(1) := 'abc';
	n	NUMBER;
BEGIN
	n := 1/0;
END;
/

SHO ERR;

BEGIN plw6017; END;

