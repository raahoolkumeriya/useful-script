/* - - - +
|
|	Author: Raahool Kumeriya
|	
|	Purpose: Standalone Procedure and Function Example 
|
|	Change history:
|	Date		Who		Description
|	----------	----------	-----------------------------------
|	28-JUN-22  	codelocked	Program Created
|
+ - - - */

SET TIMING ON;
SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt 	Standalone Procedure & Function Example		  ;
prompt ---------------------------------------------------;

-- package specification
CREATE OR REPLACE PACKAGE ecomm 
	AUTHID DEFINER
IS
	PROCEDURE apply_discount ( company_id_in IN company.company_id%TYPE,
				   discount_in	IN NUMBER);

	FUNCTION tot_sales ( company_id_in IN company.company_id%TYPE,
			     status_in IN orders.status_code%TYPE := NULL) 
			RETURN NUMBER;

END ecomm;
/

sho err


--package implememtation 
CREATE OR REPLACE PACKAGE body ecomm
IS
        PROCEDURE apply_discount ( company_id_in IN company.company_id%TYPE,
                                   discount_in  IN NUMBER)
	IS
		NULL;
	END apply_discount;



        FUNCTION tot_sales ( company_id_in IN company.company_id%TYPE,
                             status_in IN order.status_code%TYPE := NULL)
                        RETURN NUMBER
	IS 
		RETURN 1;
	END tot_sales;

END ecomm;
/

sho err
