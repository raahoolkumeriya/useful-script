/*
|	Program: Index-by tables
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE
	CURSOR cur_tp_customers IS 
		SELECT * FROM tp_customers;
	TYPE t_a_tp_cust IS TABLE OF tp_customers.name%TYPE 
		INDEX BY BINARY_INTEGER;
	name_list t_a_tp_cust;
	counter INTEGER := 0;
BEGIN
	FOR cur IN cur_tp_customers LOOP
	 	counter := counter + 1;
		name_list(counter) := cur.name;
		DBMS_OUTPUT.put_line('Coustmer('||counter||') = '||name_list(counter));
	END LOOP;
END;
/
