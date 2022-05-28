/*
|	Program: Multiset Operator 
|	Author: Raahool Kumeriya
|	Change history:
|		28-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --        MULTISET Operator                      --;
prompt ---------------------------------------------------;
prompt -- Combine elements of various collections into a single one;
prompt -- check common elements present accross the collections;
prompt -- Multiset operator is very much similar to SET operator in SQL;
prompt -- Multiser oeprator oeprate on collection of same type ;
prompt ----------------------------------------------------;

prompt Multiset Union ---------\;
prompt 'Multiset Interset	==>	ALL | DISTINCT'; 
prompt Multiset Except --------/;

prompt ----------------------------------------------------;
prompt UNION -> Combine the two sets, remove duplicates, sort and return the set;
prompt UNIONALL -> Combine the two sets, DOES NOT remove duplicated, DOES NOT sort and return the set;
prompt INTERSECT -> It just return the common rows present between two sets;
prompt MINUS -> This return the value set which not present in otehr set;
prompt ----------------------------------------------------;
  

prompt ---------------------------------------------------;
prompt --         MULTISET Union/MULTISET Union AL      --;
prompt ---------------------------------------------------;

DECLARE
	TYPE num_tab_type IS TABLE OF NUMBER;
	lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
	lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
	lv_num_list3 num_tab_type;
BEGIN
	lv_num_list3 := lv_num_list1 MULTISET UNION lv_num_list2;
	FOR i IN 1..lv_num_list3.COUNT LOOP
		dbms_output.put_line(lv_num_list3(i));
	END LOOP;
END;
/

prompt ---------------------------------------------------;
prompt --           MULTISET Union DISTINCT             --;
prompt ---------------------------------------------------;

DECLARE
        TYPE num_tab_type IS TABLE OF NUMBER;
        lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
        lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
        lv_num_list3 num_tab_type;
BEGIN
        lv_num_list3 := lv_num_list1 MULTISET UNION DISTINCT lv_num_list2;
        FOR i IN 1..lv_num_list3.COUNT LOOP
                dbms_output.put_line(lv_num_list3(i));
        END LOOP;
END;
/



prompt ---------------------------------------------------;
prompt --MULTISET INTERSECT/MULTISET INTERSECT ALL      --;
prompt ---------------------------------------------------;

DECLARE
        TYPE num_tab_type IS TABLE OF NUMBER;
        lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
        lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
        lv_num_list3 num_tab_type;
BEGIN
        lv_num_list3 := lv_num_list1 MULTISET INTERSECT ALL lv_num_list2;
        FOR i IN 1..lv_num_list3.COUNT LOOP
                dbms_output.put_line(lv_num_list3(i));
        END LOOP;
END;
/

prompt ---------------------------------------------------;
prompt --           MULTISET INTERSECT DISTINCT             --;
prompt ---------------------------------------------------;

DECLARE
        TYPE num_tab_type IS TABLE OF NUMBER;
        lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
        lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
        lv_num_list3 num_tab_type;
BEGIN
        lv_num_list3 := lv_num_list1 MULTISET INTERSECT DISTINCT lv_num_list2;
        FOR i IN 1..lv_num_list3.COUNT LOOP
                dbms_output.put_line(lv_num_list3(i));
        END LOOP;
END;
/

prompt ---------------------------------------------------;
prompt -- MULTISET EXPECT/MULTISET EXCEPT ALL      --;
prompt ---------------------------------------------------;

DECLARE
        TYPE num_tab_type IS TABLE OF NUMBER;
        lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
        lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
        lv_num_list3 num_tab_type;
BEGIN
        lv_num_list3 := lv_num_list1 MULTISET EXCEPT ALL lv_num_list2;
        FOR i IN 1..lv_num_list3.COUNT LOOP
                dbms_output.put_line(lv_num_list3(i));
        END LOOP;
END;
/

prompt ---------------------------------------------------;
prompt --           MULTISET EXCEPT DISTINCT             --;
prompt ---------------------------------------------------;

DECLARE
        TYPE num_tab_type IS TABLE OF NUMBER;
        lv_num_list1 num_tab_type := num_tab_type(1,1,2,2,3,4,5,8,8);
        lv_num_list2 num_tab_type := num_tab_type(9,1,1,2,6,7);
        lv_num_list3 num_tab_type;
BEGIN
        lv_num_list3 := lv_num_list1 MULTISET EXCEPT DISTINCT lv_num_list2;
        FOR i IN 1..lv_num_list3.COUNT LOOP
                dbms_output.put_line(lv_num_list3(i));
        END LOOP;
END;
/


