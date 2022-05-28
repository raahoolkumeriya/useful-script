prompt >>> DATABASE TRIGGERS <<<<

prompt > : 5 type of triggers 
prompt >  - Data defination Language ( DDL ) triggers: Fire when you CREATE, ALTER, RENAME, or DROP object in databse schema.
prompt 		to monitor poor programming practices creation or drop temporary tabels rather than use Oracle collections effectively in memory
prompt 		Temporary tables can framant disk space and over tiem degrade perfomrance

prompt
prompt > - Data Manipulation Language (DML ) or row-level triggers: Fire when you INSERT, UPDATE, or DELETE data from table
prompt 		to audit, check, save and replace values before they changed. 
prompt		Automatic numbering of pseudonumeric primary keys is frequently done using DML triggers

prompt
prompt > - Compound triggers: Act as both statement- and row-level triggers when you INSERT, UPDATE or DELETE data form a table
prompt 		Capture information at four points - BEFORE 1. firing statement 2. each row change from firing statement
prompt 						     AFTER  3. Each row change from the firing statement 4. firing statement
prompt 		to audit, check, save and replace values before they changes 

prompt
prompt > - Instead of triggers: Enable you to stop performance of a DML statement and redirect the DML statement. Often use with Not updatable views
prompt

prompt > - System or database event triggers: Fire when a system activity occurs in database
prompt 		login and logoff events, enable you to track system events and map them to users
 
