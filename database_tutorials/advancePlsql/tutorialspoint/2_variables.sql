SET SERVEROUTPUT ON;

DECLARE
	a INTEGER := 10;
	b INTEGER := 20;
	c INTEGER;
	d REAL;
BEGIN
	c := a + b;
	DBMS_OUTPUT.put_line('Value of C : '|| c);
	d := 70.0 / 3.0;
	DBMS_OUTPUT.put_line('Value of d : '|| d);
END;
/

prompt Variable Scope In PLSQL

DECLARE
	-- Global variables
	l_g_var NUMBER := 95;
	l_l_var NUMBER := 2;
BEGIN
	DBMS_OUTPUT.put_line('varibale in Outter Block : '|| l_g_var);
	DBMS_OUTPUT.put_line('variable in Outter block : '|| l_l_var);
	DECLARE
		-- Local variables
		l_l_var NUMBER := 20;
		l_g_var NUMBER := 195;
	BEGIN
		DBMS_OUTPUT.put_line('Variable in inner block : '|| l_g_var);
		DBMS_OUTPUT.put_line('Variable in inner block : '|| l_l_var);
	END;
END;
/

prompt Assiging SQL query Result to PLSQl variables

DECLARE
	ddl_qry VARCHAR2(10000);
	table_exists NUMBER(2);
	dml_qry VARCHAR2(1000);
BEGIN
	dml_qry := 'SELECT COUNT(1) FROM TABS WHERE UPPER(table_name) = ''TP_CUSTOMERS''';
	EXECUTE IMMEDIATE dml_qry INTO table_exists;
	DBMS_OUTPUT.put_line(table_exists);
	IF table_exists = 0 
	THEN
		
		ddl_qry := 'CREATE TABLE TP_CUSTOMERS(
				ID	INT NOT NULL,
				NAME	VARCHAr2(20) NOT NULL,
				AGE 	INT NOT NULL,
				ADDRESS CHAR(25),
				SALARY DECIMAL(18,2),
				PRIMARY KEY (ID))';
		EXECUTE IMMEDIATE ddl_qry;
		
		INSERT INTO TP_CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
		VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );  

		INSERT INTO TP_CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
		VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );  

		INSERT INTO TP_CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
		VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );
		  
		INSERT INTO TP_CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
		VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 ); 
		 
		INSERT INTO TP_CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
		VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );  

		INSERT INTO TP_CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
		VALUES (6, 'Komal', 22, 'MP', 4500.00 ); 
	END IF;
END;
/

DECLARE
	l_tp_cust_id NUMBER := 1;
	l_tp_customer_record TP_CUSTOMERS%ROWTYPE;
BEGIN
	SELECT * INTO l_tp_customer_record
	FROM tp_customers
	WHERE id = l_tp_cust_id;
 	DBMS_OUTPUT.put_line('Customer '
		|| l_tp_customer_record.name
		|| ' from '
		|| l_tp_customer_record.address
		|| ' earns '
		|| l_tp_customer_record.salary);
END;
/

