/*
|	Program: Two Dimensional Array 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

DECLARE
	TYPE matrix_elem_type IS VARRAY(3) OF NUMBER;
	TYPE matrix_type IS VARRAY(3) OF matrix_elem_type;
	lv_matrix1		matrix_type := matrix_type(NULL,NULL,NULL);
	lv_matrix2		matrix_type := matrix_type(NULL,NULL,NULL);
	lv_matrix3_total	matrix_type := matrix_type(NULL,NULL,NULL);
	lv_matrix_elem 		matrix_elem_type := matrix_elem_type(NULL,NULL,NULL);
	-- local procedure to print the array
	PROCEDURE print_array(pin_array matrix_type, pin_desc VARCHAR2) AS
	BEGIN
		dbms_output.put_line('Printing the '||pin_desc||' .....');
		FOR i IN pin_array.FIRST .. pin_array.LAST LOOP
			FOR j IN pin_array(i).FIRST .. pin_array(i).LAST LOOP
				dbms_output.put(pin_array(i)(j)||'  ');
			END LOOP;
			dbms_output.put_line('');
		END LOOP;
	END;
BEGIN
	-- Assigning First Array
	lv_matrix_elem := matrix_elem_type(1,2,3);
	lv_matrix1(1) := lv_matrix_elem;
	lv_matrix_elem := matrix_elem_type(4,5,6);
	lv_matrix1(2) := lv_matrix_elem;
	lv_matrix_elem := matrix_elem_type(7,8,9);
	lv_matrix1(3) := lv_matrix_elem;
	
	-- printing the first array
	print_array(lv_matrix1, 'First Array');

	-- Assigning Second Array
	lv_matrix_elem := matrix_elem_type(11,12,13);
	lv_matrix2(1) := lv_matrix_elem;
	lv_matrix_elem := matrix_elem_type(14,15,16);
	lv_matrix2(2) := lv_matrix_elem;
	lv_matrix_elem := matrix_elem_type(17,18,19);
	lv_matrix2(3) := lv_matrix_elem;
	
	-- printing the first array
	print_array(lv_matrix2, 'Second Array');


	-- add array1 + aray2	
		
	FOR i IN lv_matrix1.FIRST .. lv_matrix1.LAST LOOP
		FOR j IN lv_matrix2.FIRST .. lv_matrix2.LAST LOOP
			lv_matrix_elem(j) := lv_matrix1(i)(j) + lv_matrix2(i)(j);
		END LOOP;
		lv_matrix3_total(i) := lv_matrix_elem;
	END LOOP;
	
	-- printing the Total array
        print_array(lv_matrix3_total, 'Addition of Two array');
END;
/

