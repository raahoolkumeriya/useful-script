/*
|	Program: GTT Global Temporary table/Temp table  
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --  GTT Global Temporary table/Temp table   	--;
prompt ---------------------------------------------------;
prompt o data stored in table is temporary one;
prompt o Data is stored in RAM and hence it is logical read which is faster;
prompt ---------------------------------------------------;
prompt -- 		TYPE oF GTT			--;
prompt o Transaction Specific GTT: The data will be there until we get the COMMIT/ROLLBACK keywords;
prompt o Sesssion Specific GTT: Data will remain till the end of the session; 
prompt ---------------------------------------------------;


prompt ---------------------------------------------------;
prompt --	Transaction Specific GTT		--;
prompt ---------------------------------------------------;

CREATE global temporary table gtt1 
(
	id	NUMBER
)
ON COMMIT delete rows;

prompt ------------------------------;
prompt Insert some data in GTT;
prompt ------------------------------;

INSERT ALL 
	INTO gtt1 (ID) values (1)
	INTO gtt1 (ID) values (2)
	INTO gtt1 (ID) values (3)
SELECT * FROM DUAL;


prompt ------------------------------;
prompt Check data in GTT1;
prompt ------------------------------;
select * from gtt1;

prompt ------------------------------;
prompt Issue commit;
prompt ------------------------------;
commit;

prompt ------------------------------;
prompt Check data in GTT1 after commit;
prompt ------------------------------;
select * from gtt1;


prompt ---------------------------------------------------;
prompt --	Session Specific GTT		--;
prompt ---------------------------------------------------;

create global temporary table gtt2
(
	id number
)
on commit preserve rows;

INSERT ALL
        INTO gtt2 (ID) values (1)
        INTO gtt2 (ID) values (2)
        INTO gtt2 (ID) values (3)
SELECT * FROM DUAL;


prompt ------------------------------;
prompt Check data in GTT2;
prompt ------------------------------;
select * from gtt2;

prompt ------------------------------;
prompt Issue commit;
prompt ------------------------------;
commit;

prompt ------------------------------;
prompt Check data in GTT2 after commit;
prompt ------------------------------;
select * from gtt2;
