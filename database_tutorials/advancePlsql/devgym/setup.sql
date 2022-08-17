/*
||	Program: Get and Read Execution Plans
||	Author: codelocked
||	Change history:
||		08-JUL-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --	Get and Read Execution Plans		--;
prompt ---------------------------------------------------;

create table bricks (
  colour   varchar2(10),
  shape    varchar2(10)
);

create table colours (
  colour        varchar2(10),
  rgb_hex_value varchar2(6)
);

create table cuddly_toys (
  toy_name varchar2(20),
  colour   varchar2(10)
);

create table pens (
  colour   varchar2(10),
  pen_type varchar2(10)
);


insert into cuddly_toys values ( 'Miss Snuggles', 'pink' ) ;
insert into cuddly_toys values ( 'Cuteasaurus', 'blue' ) ;
insert into cuddly_toys values ( 'Baby Turtle', 'green' ) ;
insert into cuddly_toys values ( 'Green Rabbit', 'green' ) ;
insert into cuddly_toys values ( 'White Rabbit', 'white' ) ;

insert into colours values ( 'red' , 'FF0000' ); 
insert into colours values ( 'blue' , '0000FF' ); 
insert into colours values ( 'green' , '00FF00' ); 

insert into bricks values ( 'red', 'cylinder' );
insert into bricks values ( 'blue', 'cube' );
insert into bricks values ( 'green', 'cube' );

insert into bricks
  select * from bricks;
  
insert into bricks
  select * from bricks;
  
insert into bricks
  select * from bricks;

insert into pens values ( 'black', 'ball point' );
insert into pens values ( 'black', 'permanent' );
insert into pens values ( 'blue', 'ball point' );
insert into pens values ( 'green', 'permanent' );
insert into pens values ( 'green', 'dry-wipe' );
insert into pens values ( 'red', 'permanent' );
insert into pens values ( 'red', 'dry-wipe' );
insert into pens values ( 'blue', 'permanent' );
insert into pens values ( 'blue', 'dry-wipe' );

commit;

exec dbms_stats.gather_table_stats ( null, 'pens' ) ;
exec dbms_stats.gather_table_stats ( null, 'colours' ) ;
exec dbms_stats.gather_table_stats ( null, 'bricks' ) ;
exec dbms_stats.gather_table_stats ( null, 'cuddly_toys' ) ;
