/*
|	Program: Block Struture
|	Author: Raahool Kumeriya
|	Change history:
|		11-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt -------------------------------;
prompt Simple plsql block;
prompt -------------------------------;

BEGIN
	-- simple plsql block
	NUll;
END;
/

prompt -------------------------------;
prompt Simple plsql block with 1 variable;
prompt -------------------------------;

DECLARE
	l_variable NUMBER;
BEGIN
	-- simple plsql block with 1 variable
	l_variable := 3;
	DBMS_OUTPUT.PUT_LINE(l_variable);
END;
/

prompt -------------------------------;
prompt embaded blocks;
prompt -------------------------------;

BEGIN
	-- embaded block
	BEGIN
		DBMS_OUTPUT.PUT_LINE('First block');
	END ;
	DBMS_OUTPUT.PUT_LINE('Second block');
END;
/


prompt -------------------------------;
prompt embaded blocks variables;
prompt -------------------------------;

DECLARE 
	l_outer_variable NUMBER := 1;
BEGIN
	DECLARE
		l_inner_variable NUMBER := 2;
	BEGIN
		DBMS_OUTPUT.PUT_LINE(l_outer_variable || ' ' || l_inner_variable);
	END;
END;
/



prompt -------------------------------;
prompt embaded blocks and duplicate variable names;
prompt -------------------------------;
------ Watch out for scope of the duplicate variables
DECLARE
	l_outer_variable NUMBER := 1;
BEGIN
	DECLARE
		-- embedded block and duplicate variable names
		l_outer_variable NUMBER := 2;
	BEGIN	
		DBMS_OUTPUT.PUT_LINE(l_outer_variable);
	END;
	DBMS_OUTPUT.PUT_LINE(l_outer_variable);
END;
/


prompt -------------------------------;
prompt embaded blocks and variables;
prompt -------------------------------;
DECLARE
	l_outer_variable NUMBER := 1;
BEGIN
	DECLARE
		l_inner_variable NUMBER := 2;
	BEGIN
		DBMS_OUTPUT.PUT_LINE(l_outer_variable||' '||l_inner_variable);
	END;
	-- fails beacuase l_inner_variable is out of scope
--	DBMS_OUTPUT.PUT_LINE(l_outer_variable||' '||l_inner_variable);
END;
/


prompt -------------------------------;
prompt blocks  structure within a procedure
prompt -------------------------------;

CREATE OR REPLACE PROCEDURE abc IS
	-- block strucutre within a procedure
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hello');
END abc;
/

prompt -------------------------------;
prompt blocks  structure when calling a procedure
prompt -------------------------------;

BEGIN
	abc;
END;
/



prompt -------------------------------;
prompt embedding procedure within procedure;
prompt -------------------------------;


CREATE OR REPLACE PROCEDURE def IS
	--end labesl
	PROCEDURE ghi IS
	BEGIN
		NULL;
	END ghi;
BEGIN
	NULL;
END def;
/

 
prompt -------------------------------;
prompt label defined in code;
prompt -------------------------------;

BEGIN
	-- label defined in code
	<<label_one>>
	BEGIN
		NULL;
	END label_one;
END;

