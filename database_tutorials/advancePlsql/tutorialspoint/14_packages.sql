/*
|	Program: Packages
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

prompt ----------------------------------------------------------

prompt ---> Package Specification: Interface to the Package. 
prompt ----------> It just DECLAREs the TYPEs, VARIABLEs, CONSTANTs, EXCEPTIONs, CURSORs and Subprograms taht can be reference outside the package.
prompt ----------> All objects place in hte specification are called public onjects.
prompt ----------> Any subprogam not in the package specification but coded in package body is called Private object.
prompt ----------------------------------------------------------

CREATE OR REPLACE PACKAGE cust_sal
IS
	PROCEDURE find_sal(c_id tp_customers.id%TYPE);
END cust_sal;
/

prompt ----------------------------------------------------------

prompt ---> Package Body or deifinition
prompt -------------> codes of various methods declared in pacakge specification and other private declarations, which are hidden from the code outside the package
prompt ----------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY cust_sal
AS
	PROCEDURE find_sal(c_id tp_customers.id%TYPE) IS
	c_sal	tp_customers.salary%TYPE;
	BEGIN
		SELECT salary
		INTO c_sal
		FROM tp_customers
		WHERE id = c_id;
		DBMS_OUTPUT.PUT_LINE('Customer Salary : '
					|| c_sal);
	END find_sal;
END;
/

EXECUTE cust_sal.find_sal(1);


