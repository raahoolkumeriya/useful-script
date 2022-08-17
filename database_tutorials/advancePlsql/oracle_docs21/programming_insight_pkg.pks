/*
||	Author: Raahool Kumeriya
||	
||	Purpose: Oracle docs Learning 
||
||	Change history:
||	Date		Who		Description
||	----------	----------	-----------------------------------
||	26-JUN-2022  	codelocked	Program Created
*/

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 			Oracle PLSQL Docs		  ;
prompt ---------------------------------------------------;
-- Pacakge interface/Speacification
create or replace package learning_pkg 
	AUTHID DEFINER 
IS
	-- Processing Query Result Rows One at a Time
	procedure precessing_one_row_at_a_time;

	-- Qualifying Identifier with Subprogram Name
	procedure check_credit ( credit_limit NUMBER);

	-- predefine inquiry directive
	procedure show_inquiry_directive;

	
end learning_pkg;
/

show errors;

