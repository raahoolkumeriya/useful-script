/*
|	Program: streaming Tabel function  
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --   In action : streaming Tabel function        --;
prompt ---------------------------------------------------;

INSERT INTO tickers
 SELECT * 
	FROM TABLE ( doubled ( CURSOR ( SELECT * FROM stocks)))
/

SELECT COUNT(*) FROM tickers
/

SELECT * 
	FROM tickers
FETCH FIRST 10 ROWS ONLY
/

