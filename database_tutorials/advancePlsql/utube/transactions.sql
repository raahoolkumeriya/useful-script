/*
|	Program: Transactions 
|	Author: Raahool Kumeriya
|	Change history:
|		10-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     		Transactions			--;
prompt ---------------------------------------------------;
prompt --> Transaction is where a small unit of work that is perform aginst the database.;
prompt --> It is always accomplish by using DML statements (Insert,update,delete);
prompt ---------------------------------------------------;
prompt --	Nature of Transaction			--;
prompt ---------------------------------------------------;
prompt --> It is always has a begining and an end;
prompt --> can always save or Undo;
prompt --> Whenever transaction fails in middle, no part of it can be save to database;
prompt --> COMMIT, ROLLBACK, SAVEPOINT;
prompt ---------------------------------------------------;
prompt --	ACID - properties of Transactions;	--;
prompt ---------------------------------------------------;
prompt --> Atomicity --> Gaurntee that will transaction happens or none of them happens;
prompt --> Consistency --> Correctness transaction should never leaves the DB with incorrect value;
prompt --> Isolation --> transaction kept seperatly until they are completed;
prompt --> Durability --> Gurantee that Database can keep the track of pending chnages in such a way that the server can recovered form abnormal termination;
prompt ---------------------------------------------------;



