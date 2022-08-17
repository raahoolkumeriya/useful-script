/*
|	Program: VIEWS 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		VIEWS				--;
prompt ---------------------------------------------------;
prompt -- It is database object, when we say database object it means it stored in database;
prompt -- This database object will provide the restricted access on the table;
prompt -- it is also called Virtual table;

drop view employee_view;

CREATE VIEW employee_view
	AS
	SELECT * FROM employees_bk where department_id = 20;

prompt ---------------------------------------------------;
prompt Whenever we query from view, actually query is fires against the base table, and fetch data from base table;
prompt There is not data present in VIEW;
prompt Each table can have N number of views;
prompt Whenever we are dropping the VIEW, base tabel does not affected;
prompt but when we drop the base table, VIEW become the INVALID;
prompt Advantages : ;
prompt -----------: Security ;
prompt -----------: Does NOT store any data, so there is no any moemory consumption;
prompt -----------: VIEW will provide to Column, row or table level access to the tabel data;
prompt -----------: Any complex,long query can be stored in VIEW for easier references;
prompt ---------------------------------------------------;

SELECT * FROM employee_view;


prompt ---------------------------------------------------;
prompt --		TYPEs of VIEW			--;
prompt ---------------------------------------------------;
prompt -- o Updateble and Non-Updatebel View;
prompt -- o Simple and Complex Views;
prompt -- o Read only view;
prompt -- o Force view;
prompt ---------------------------------------------------;
prompt o Updateble View;
prompt ----> Whenever we are updating View that automaticcaly affect the base table, such views are called Updateble view.;
prompt ---------------------------------------------------;

INSERT into employee_view values (9001,'JOY','CLERK',7878,'16-DEC-13',7000,100,10);

SELECT * FROM employee_view;

SELECT * FROM employees_bk;

prompt ---------------------------------------------------;
prompt o Non-Updateble View;
prompt ----> When View having GROUP BY, ORDER BY, DISTINCT, Complex JOINS then it does not afffect the base table; 
prompt ---------------------------------------------------;
prompt o Simple Views;
prompt ---> If a view is created with Simple view and by default simpe view is updatable view;
prompt o Complex view;
prompt ----> If a view is created with compelx query and by default complex view are non-updateble views;
prompt ---------------------------------------------------;
prompt o Read Only View;
prompt ---> When Updateble view can be made non-updateble view;
prompt ---------------------------------------------------;

Drop view employee_view;

prompt ---------------------------------------------------;
prompt -- 	CREATE READ ONLY VIEW 			--;
prompt ---------------------------------------------------;

CREATE VIEW employee_view
AS 
	SELECT * FROM employees_bk 
	WHERE department_id = 20 
	with READ ONLY;

prompt ---------------------------------------------------;
prompt -- 		FORCE view 			--;
prompt ---------------------------------------------------;
prompt o Force view;
prompt When view is created without base table;

CREATE FORCE VIEW empl_view1
AS
	SELECT * FROM demo18;



