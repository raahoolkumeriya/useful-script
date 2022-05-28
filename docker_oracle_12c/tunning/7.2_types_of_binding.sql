/*
|	Program: Type of Binding 
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ----------------------------------------------------------;
prompt IN-BIND : When an INSERT, UPDATE or MERGE operation and if you are using an collection variable to transfer content from DML statement into a Table the bind operation happens is IN-BINDing.
prompt ----------------------------------------------------------;
prompt --- to achive this binding we have reseve keyword is FORALL;


prompt DECLARE
prompt 		TYPE t_num_list_type IS TABLE OF NUMBER;
prompt 		lv_num_list t_num_list_type := t_num_list_type(1,2,3,4,5);
prompt BEGIN
prompt 		FORALL i IN lv_num_list.FIRST .. lv_num_list.LAST
prompt 			INSERT INTO A values(lv_num_list(i));
prompt	END;




prompt ----------------------------------------------------------;
prompt OUT-BIND : Whereve we do a DML operation and if you want to get the modified data into a Collection.;
prompt >>>> That means you are taking the result of DML statemtn into a Collection is called OUT-BINDing.;
prompt ----------------------------------------------------------;
prompt -- Tp acheive this we haev RETURNING clause;


prompt DECLARE
prompt 		TYPE t_num_list_type IS TABLE OF NUMBER;
prompt 		lv_num_list t_num_list_type := t_num_list_type();
prompt 	BEGIN
prompt 		UPDATE A
prompt 		SET COL=COL+100
prompt 		RETURNING COL
prompt 		BULK COLLECT INTO lv_num_list;
prompt 	END;



prompt ----------------------------------------------------------;
prompt DEFINE : Whenever we want to hold the output of SELECt statement into a PLSQL collection variable with a minimual contact switch. The method we use is called DEFINE.;
prompt ----------------------------------------------------------;
prompt -- to achive this we have BULK COLLECT keyword;


prompt DECLARE
prompt 		TYPE t_num_list_type IS TABLE OF NUMBER;
prompt 		lv_num_list t_num_list_type := t_num_list_type();
prompt 	BEGIN
prompt		SELECT COL
prompt 		BULK COLLECT INTO lv_num_list
prompt 		FROM A;
prompt 	END;

prompt -------------------------;
prompt  As part of CURSOR;
prompt -------------------------;

prompt DEFINE
prompt 		TYPE t_num_list_type IS TABLE OF NUMBER;
prompt		lv_num_list t_num_list_type := t_num_list_type();
prompt		CURSOR cur is SELECT * FROM A;
prompt 	BEGIN
prompt 		OPEN cur;
prompt 		FETCH cur 
prompt 		BULK COLLECT INTO lv_num_list;
prompt 		CLOSE cur;
prompt 	END;



