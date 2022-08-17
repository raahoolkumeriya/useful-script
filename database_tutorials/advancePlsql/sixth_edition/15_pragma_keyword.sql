
prompt 	PRAGMA Keyword
prompt 	--------> A line od source code prescribing an action you want the compiler to take
prompt	--------> PLSQL Compilier will accept such directivies anywhere in the Declaration Section

prompt --> AUTONOMOUS_TRANSACTION: Tells the PL/SQL runtime engine to commit or rollback any changes made to the database
prompt ---------------------------> inside the current block without affecting the main or outer transaction.

prompt --> EXCEPTION_INIT: Tells the compiler to associate a particular error number with an identifier you have declared
prompt ------------------>  as an exception in your program.

prompt --> RESTRICT_REFERENCES: Tells the compiler the purity level (freedom from side effects) of a packaged program.

prompt --> SERIALLY_REUSABLE: Tells the PL/SQL runtime engine that package-level data should not persist between references to that data.

SET SERVEROUTPUT ON;

DECLARE
	no_such_sequence EXCEPTION;
	PRAGMA EXCEPTION_INIT (no_such_sequence, -2289);
BEGIN
	DBMS_OUTPUT.PUT_LINE('Sequence not defined');
EXCEPTION
	WHEN no_such_sequence
	THEN
		-- q$error_manager.raise_error('Sequence not defined');
		DBMS_OUTPUT.PUT_LINE('Sequence not defined');
END;
/
 
