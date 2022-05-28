/*
|	Program: Explicit Cursors
|	Author: Raahool Kumeriya
|	Change history:
|		07-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;

DECLARE
	c_id	TP_CUSTOMERS.id%TYPE;
	c_name  TP_CUSTOMERS.name%TYPE;
	c_addr	TP_CUSTOMERS.address%TYPE;
	CURSOR c_tp_cust IS
		SELECT id, name, address FROM TP_CUSTOMERS;
BEGIN
	OPEN c_tp_cust;
	LOOP
		FETCH c_tp_cust INTO c_id, c_name, c_addr;
		EXIT WHEN c_tp_cust%NOTFOUND;
		DBMS_OUTPUT.put_line(c_id ||' '||c_name||' '||c_name);
	END LOOP;
	CLOSE c_tp_cust;
END;
/
