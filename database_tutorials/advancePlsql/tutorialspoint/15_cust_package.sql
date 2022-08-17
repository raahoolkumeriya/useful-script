/*
|	Program: Packages
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;


prompt -----------------------------------------------------------------------

-- package specification for tp_customers
CREATE OR REPLACE PACKAGE tp_customer_pkg 
AS
	-- Add a customers
	PROCEDURE addCustomer(
		 c_id tp_customers.id%TYPE
		,c_name tp_customers.name%TYPE
		,c_age tp_customers.age%TYPE
		,c_addr tp_customers.address%TYPE
		,c_sal tp_customers.salary%TYPE);
	-- Remove a customers
	PROCEDURE delCustomer(c_id tp_customers.id%TYPE);
	-- List customers
	PROCEDURE listCustomer;
END tp_customer_pkg;
/

show errors;

-- package body for tp_customers activity

CREATE OR REPLACE PACKAGE BODY tp_customer_pkg 
AS
        -- Add a customers
        PROCEDURE addCustomer(
		c_id tp_customers.id%TYPE
                ,c_name tp_customers.name%TYPE
                ,c_age tp_customers.age%TYPE
                ,c_addr tp_customers.address%TYPE
                ,c_sal tp_customers.salary%TYPE) IS
	BEGIN
		INSERT INTO tp_customers(id,name,age,address,salary)
		  VALUES (c_id,c_name,c_age,c_addr,c_sal);
	END addCustomer;
	
	-- remove a customers
	PROCEDURE delCustomer(c_id tp_customers.id%TYPE)
	IS
	BEGIN
		DELETE tp_customers 
		WHERE id = c_id;
		DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' records deleted.');
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('No Specific record found!');
	END delCustomer;

	-- list all cutomers
	PROCEDURE listCustomer IS
		CURSOR cur_customers IS
		  SELECT * FROM tp_customers;	
	BEGIN
		DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
		FOR cur_item IN cur_customers
		LOOP
			DBMS_OUTPUT.PUT_LINE(
				cur_item.name
				|| ' from location : '
				|| RTRIM(cur_item.address, ' ')
				|| ' of age '
				|| cur_item.age
				|| ' having Salry '
				|| cur_item.salary);
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
	END listCustomer;

END tp_customer_pkg;
/
	
show errors	


EXECUTE tp_customer_pkg.listCustomer;
EXECUTE tp_customer_pkg.addCustomer(8,'Raahool',34,'Katol',3608500);
EXECUTE tp_customer_pkg.addCustomer(9,'Aniket',32,'Katol',5000000);
EXECUTE tp_customer_pkg.addCustomer(10,'Sandeep',34,'Katol',788500);
EXECUTE tp_customer_pkg.addCustomer(11,'Vishal',34,'Katol',5668500);
EXECUTE tp_customer_pkg.addCustomer(12,'Pintu',34,'Katol',6758500);
EXECUTE tp_customer_pkg.addCustomer(13,'Ganesh',34,'Katol',8788500);
EXECUTE tp_customer_pkg.listCustomer;
EXECUTE tp_customer_pkg.delCustomer(8);
EXECUTE tp_customer_pkg.delCustomer(9);
EXECUTE tp_customer_pkg.delCustomer(10);
EXECUTE tp_customer_pkg.delCustomer(11);
EXECUTE tp_customer_pkg.delCustomer(12);
EXECUTE tp_customer_pkg.delCustomer(13);
EXECUTE tp_customer_pkg.listCustomer;

