/*
|	Program: ACCESSIBLE BY in package 
|	Author: Raahool Kumeriya
|	Change history:
|		01-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --    ACCESSIBLE BY in package		        --;
prompt ---------------------------------------------------;
promtp -- The ACCESSIBLE BY clause can be specified for schema-level programs only.;


/*Package with the accessible by clause*/

CREATE OR REPLACE PACKAGE pkg_fin_proc
ACCESSIBLE BY ( PACKAGE pkg_fin_internals )
IS
	PROCEDURE p_fin_qtr;
	PROCEDURE p_fin_ann;
END;
/

/*Invoke the packaged subprogram from the PL/SQL block*/
BEGIN
   pkg_fin_proc.p_fin_qtr;
END;
/


