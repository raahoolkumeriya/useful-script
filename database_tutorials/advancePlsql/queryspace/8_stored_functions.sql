/*

FUNCTION function_name
	[( parameter1 [IN][OUT] [NOCOPY] sql_datatype | plsql_datatype
	[, parameter2 [IN][OUT] [NOCOPY] sql_datatype | plsql_datatype
	[, parameter(n+1) [IN][OUT] [NOCOPY] sql_datatype | plsql_datatype )]]] RETURN [ sql_data_type | plsql_data_type ]
	[ AUTHID [ DEFINER | CURRENT_USER ]]
	[ DETERMINISTIC | PARALLEL_ENABLED ]
	[ PIPELINED ]
	[ RESULT_CACHE [ RELIES ON table_name ]] IS
	  declaration_statements
BEGIN
 	 execution_statements
  	RETURN variable;
[EXCEPTION]
	exception_handling_statements END [function_name];
/


CALLING Functions:
	1. SQL Statements
	2. CALL statement to capture a return value into a bind variable

Functions offer a great deal of power to database developers. They are callable in both SQL statements and PL/SQL blocks

*/


prompt >>>>>>>> JOIN STRINGS - STORED FUNCTION <<<<<<<<<<

CREATE OR REPLACE FUNCTION join_strings ( string1 VARCHAR2, string2 VARCHAR2 ) 
	RETURN VARCHAR2 IS
BEGIN
	RETURN string1 ||' '|| string2||'.';
END;
/


prompt >>> Query Function from SQL <<<<<
SELECT join_strings('Hello', 'World') FROM dual;



prompt >>> Session level bind variable with CALL statement <<<<
VARIABLE session_var VARCHAR2(30);
CALL join_strings('Session','Bind-Variable') INTO :session_var;

SELECT :session_var FROM dual;


