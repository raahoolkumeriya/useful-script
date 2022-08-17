/*
|	Program: Bulk Operations 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --   		ROW Fetch Operations		--;
prompt ---------------------------------------------------;

DECLARE
	obj_id		local_objects.object_id%TYPE;
	obj_type	local_objects.object_type%TYPE;
	obj_name	local_objects.object_name%TYPE;
	
	counter		NUMBER;
	clock_in	NUmBER;
	clock_out	 NUMBER;

	CURSOR cur IS
		SELECT object_id, object_type, object_name
		FROM local_objects;
BEGIN
	-- capture start time
	clock_in := DBMS_UTILITY.get_time();

	OPEN cur;
	LOOP
		FETCH cur INTO obj_id, obj_type, obj_name;
		EXIT WHEN cur%NOTFOUND;
		-- count the number of procedures in the test table
		IF obj_type = 'PROCEDURE' THEN
			counter := counter + 1;
		END IF;
	END LOOP;
	CLOSE cur;

	-- capture start time
	clock_out := DBMS_UTILITY.get_time();
	DBMS_OUTPUT.put_line('Time taken in row fetch : '||TO_CHAR(clock_out - clock_in ));
END;
/	

prompt ---------------------------------------------------;
prompt --   		BULK  Operations		--;
prompt ---------------------------------------------------;


/*Start the PL/SQL block*/
DECLARE
	/*Declare the local record and table collection*/
	TYPE obj_rec IS RECORD
		(obj_id local_objects.object_id%TYPE,
		obj_type local_objects.object_TYPE%TYPE,
		obj_name local_objects.object_name%TYPE);

	TYPE obj_tab IS TABLE OF obj_rec;
	t_all_objs 	obj_tab;

	counter   	NUMBER;
	clock_in  	NUMBER;
	clock_out 	NUMBER;
BEGIN
	/*Capture the start time*/
	clock_in := DBMS_UTILITY.GET_TIME();

	/*Select query to bulk fetch multi-record set in nested table collection*/
	SELECT object_id, object_TYPE, object_name
	BULK COLLECT INTO t_all_objs
	FROM local_objects;

	/*Loop through the collection to count number of procedures*/
	FOR I IN t_all_objs.FIRST..t_all_objs.LAST
	LOOP
		IF (t_all_objs(i).obj_type = 'PROCEDURE') THEN
			counter := counter+1;
		END IF;
	END LOOP;

	/*Capture the end time*/
	clock_out := DBMS_UTILITY.GET_TIME();
	DBMS_OUTPUT.PUT_LINE ('Time taken in bulk fetch:'||to_char (clock_out-clock_in));
END;
/


prompt ---------------------------------------------------;
prompt --   	BULK Operations with LIMIT Clause	--;
prompt ---------------------------------------------------;


/*Start the PL/SQL block */
DECLARE
	/*Local block variables - object type record and nested table*/
	TYPE obj_rec IS RECORD
		(obj_id local_objects.object_id%TYPE,
		obj_type local_objects.object_TYPE%TYPE,
		obj_name local_objects.object_name%TYPE);
	TYPE obj_tab is table of obj_rec;
	t_all_objs obj_tab;

	counter NUMBER;
	p_rec_limit NUMBER := 100;
	clock_in NUMBER;
	clock_out NUMBER;

	/*Cursor to fetch object details from LOCAL_OBJECTS*/
	CURSOR C IS
		SELECT object_id, object_TYPE, object_name
		FROM local_objects;
BEGIN
   /*Capture the start time*/
   clock_in := DBMS_UTILITY.GET_TIME();
   /*Open the cursor*/
   OPEN c;
   LOOP
      /*Bulk fetch the records by specifying the limit*/
      FETCH c BULK COLLECT INTO t_all_objs LIMIT p_rec_limit;
      EXIT WHEN c%NOTFOUND;
      /*FOR loop to count the procedures */
      FOR I IN t_all_objs.FIRST..t_all_objs.LAST
       LOOP
        IF (t_all_objs(i).obj_type = 'PROCEDURE') THEN
           counter := counter+1;
        END IF;
       END LOOP;
      t_all_objs.DELETE;
   END LOOP;
   CLOSE c;
clock_out := DBMS_UTILITY.GET_TIME();
   DBMS_OUTPUT.PUT_LINE ('Time taken in controlled fetch:'||to_char(clock_out-clock_in));
END; 
/
