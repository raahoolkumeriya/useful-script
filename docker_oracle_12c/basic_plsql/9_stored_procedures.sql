/*

PROCEDURE procedure_name
	[( parameter1 [IN][OUT] [NOCOPY] sql_datatype | plsql_datatype [, parameter2 [IN][OUT] [NOCOPY] sql_datatype | plsql_datatype
	[, parameter(n+1) [IN][OUT] [NOCOPY] sql_datatype | plsql_datatype )]]] 
	[ AUTHID DEFINER | CURRENT_USER ] IS
	  declaration_statements
BEGIN
	execution_statements
[EXCEPTION]
	exception_handling_statements END [procedure_name];
/


*/


prompt >>> FORMAT STRINGS - STOIRED PROCEDURE <<<<
CREATE OR REPLACE PROCEDURE format_strings (string_in IN OUT VARCHAR2 ) IS
BEGIN
	string_in := '['||string_in||']';
END;
/

prompt >>>> CALL statement into bind variable <<<<
VARIABLE session_var VARCHAR2(30);
CALL join_strings('Hello','World') INTO :session_var;
CALL format_strings(:session_var);

SELECT :session_var FROM dual;



prompt >>>>> EXECUTE statement with stored procedure <<<<<
EXECUTE format_strings(:session_var);

SELECT :session_var FROM dual;


