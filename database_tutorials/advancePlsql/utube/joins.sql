/*
|	Program: JOINS 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		JOINS				--;
prompt ---------------------------------------------------;
prompt -- Why we use joins?;
prompt --> Initially we used to stores data in flat files or in a single table;
prompt ---> With this data keep on repeating and redundency increses and it didnt had that much efficency;
prompt ---> We brought a concept of NORMALIZATION to handle the data redendency;
prompt ---> with this we are able to divide big tables into small-small tables;
prompt ---> To club all the small tables we use Joins;
prompt ---------------------------------------------------;
prompt --		TYPE of JOINS			--;
prompt ---------------------------------------------------;
prompt -- INNER JOIN;
prompt -- OUTER JOIN;
prompt ---------> LEFT OUTER JOIN;
prompt ---------> RIGHT OUTER JOIN;
prompt ---------> FULL OUTER JOIN;
prompt -- CROSS JOIN;
prompt ---------------------------------------------------;
prompt -- 	INNER JOIN -- Gives similar data	--;
prompt ---------------------------------------------------;

SELECT * FROM 
	employees e
	INNER JOIN
	departments d
	ON e.department_id = d.department_id;

prompt ---------------------------------------------------;
prompt -- LEFT OUTER JOIN -- all the match columns from left table and rows doesnt match with right table from left table is getting display --;
prompt ---------------------------------------------------;

SELECT * FROM
	employees e
	LEFT OUTER JOIN
	departments d
	ON e.department_id = d.department_id;

 
prompt ---------------------------------------------------;
prompt -- RIGHT OUTER JOIN -- all the match columns from right table and rows doesnt match with left table from right table is getting display --;
prompt ---------------------------------------------------;

SELECT * FROM
	employees e
	RIGHT OUTER JOIN
	departments d
	ON e.department_id = d.department_id;

prompt ---------------------------------------------------;
prompt -- FULL OUTER JOIN -- all the match rows and unmatch rows form left and rigth tables are getting display ;
prompt ---------------------------------------------------;

SELECT * FROM
	employees e
	FULL  OUTER JOIN
	departments d
	ON e.department_id = d.department_id;


