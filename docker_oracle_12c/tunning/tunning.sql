/*
|	Program: Optimize the PLSQL  
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt -- There are many ways to optimize the plsql code --;

prompt ----------------------------------------------------;
prompt > Implement the logic in SQL (insteed of PLSQL) as for as possible;
prompt > Use the builtin functions/snalysticla functions as much as possible;
prompt > BULK Collection ;
prompt > Where you want to store huge amount of information use Global Temporary tables (instead of putting it into a variables);
prompt > Merge multiple statements into single statement wherever applicable
prompt > Use Insert append hint to imporove performance of instert statements
prompt > Use Pass By Reference (NOCOPY Compiler hint) 
prompt > Consilidate the redundant code
prompt > Use LOB variable only if needed (Use extended Data Types from 12C)

