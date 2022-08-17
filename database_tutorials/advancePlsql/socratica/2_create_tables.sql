/*
|	Program: CREATE TABLE 
|	Author: Raahool Kumeriya
|	Change history:
|		06-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		CREATE TABLE			--;
prompt ---------------------------------------------------;

CREATE TABLE users (
	user_id		int,
	first_name	VARCHAR2(100),
	last_name	VARCHAR2(100),
	email		VARCHAR2(255)
);

prompt ALTER command will add new column to table users;

ALTER TABLE users ADD encrypted_password VARCHAR2(1000);

prompt to Drop column form table;
ALTER TABLE users DROP COLUMN email;

prompt to drop table all togethere;
DROP TABLE users;

prompt to clean the database;
DROP DATABASE social_network;
