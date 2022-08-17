/*
|	Program: Database table
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE 
	CURSOR cur_tp_cust IS
		SELECT name FROM TP_CUSTOMERS;
	TYPE t_cust IS VARRAY(6) OF TP_CUSTOMERS.name%TYPE;
	name_list t_cust := t_cust();
	counter INTEGER := 0;
BEGIN
	FOR i IN cur_tp_cust LOOP
		counter := counter + 1;
		name_list.EXTEND;
		name_list(counter) := i.name;
		DBMS_OUTPUT.PUT_line('Customer('||counter||'):'||name_list(counter));
	END LOOP;
END;
/

