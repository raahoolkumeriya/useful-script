/*
|	Program: Read only tables 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		Read only tables		--;
prompt ---------------------------------------------------;

DROP TABLE demo_read_only;

Create table demo_read_only (
	ID	NUMBER,
	NAME	VARCHAR2(30)
);

INSERT ALL
	INTO demo_read_only (ID,NAME) VALUES (1, 'science')
	INTO demo_read_only (ID,NAME) VALUES (2, 'social')
	INTO demo_read_only (ID,NAME) VALUES (3, 'maths')
SELECT * FROM DUAL;

commit;

select * from demo_read_only;

prompt ---------------------------------------------------;
prompt --     Making table as Read only table		--;
prompt ---------------------------------------------------;

ALTER TABLE demo_read_only READ ONLY;


prompt ---------------------------------------------------;
prompt --     ONly certain OPERATION we can perform	--;
prompt ---------------------------------------------------;
prompt ---- Operation allowed;
prompt o Select, rename the table, we can move table from one tablespace to another;
prompt o Drop the table;

prompt ---- Operation NOT allowed;
prompt o DML operation (insert,udpate,delete,merge);
prompt o We can not Trancate table;
prompt o we can NOT remove,rename, add a new column;
prompt o We can NOT flashback the table;

prompt ---------------------------------------------------;
prompt --     Making table back to Read write table	--;
prompt ---------------------------------------------------;

ALTER TABLE demo_read_only READ WRITE;

