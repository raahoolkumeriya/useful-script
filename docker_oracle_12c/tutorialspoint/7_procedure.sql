/*
|	Program: Procedures 
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt A Subprogram can be created at 1. Schema level, 2. Inside a Package, 3. Inside a PL/SQL block

prompt --> At Schema Level: Subprogam is called as Standalone subporgram. 
prompt --------------------> It is created with CREATE PROCEDURE or CREATE FUNCTION statements. 
prompt --------------------> It can be deleted with DROP PROCEDURE or DROP FUNCTION statements.

prompt --> Inside A Package: Subprogram is called as Packaged Subprogram.
prompt --------------------> It is stored in Database and can be deleted only when the package is deleted with DROP PACKAGE statement.

prompt --> PL/SQL block: Subprogram are called PL/SQL Subprograms
prompt --------------------> FUNCTION: Subprogram return Single value; mainly use to compute and return value
prompt --------------------> PROCEDURE: Subprogram does not return a value direclty; mainly used to perform action.

prompt PArt of PLSQL Subprograms
prompt ---> Header, declaration, execution , exception block


CREATE OR REPLACE PROCEDURE greeting
AS
BEGIN
	DBMS_OUTPUT.put_line('Hello world!');
END;
/

EXEC greeting;


prompt IN & OUT mode 

DECLARE
	a NUMBER;
	b NUMBER;
	c NUMBER;
	PROCEDURE findMin(x IN NUMBER, y IN NUMBER, z OUT NUMBER)
	IS
	BEGIN
		IF x < y
		THEN
			z := x;
		ELSE
			z := y;
		END IF;
	END;
BEGIN
	a := 100;
	b := 99;
	findMin(a, b, c);
	DBMS_OUTPUT.put_line('Minimum number : '|| c);
END;
/


DECLARE
	a NUMBER;
	c NUMBER;
	PROCEDURE SquareNumber( x IN NUMBER, z OUT NUMBER)
	AS 
	BEGIN
		z := x ** 2;
	END;
BEGIN
	a := 12;
	SquareNumber( a, z => c );
	DBMS_OUTPUT.put_line('Squared number : '|| c);
END;
/	
