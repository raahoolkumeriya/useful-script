/*
|	Program: Streaming Table function
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     Streaming Table function			--;
prompt ---------------------------------------------------;
prompt -- A processing in which data is transfer form one step to another step in stream of events all stay in single sql statement;
prompt ---------------------------------------------------;
prompt --> Table function accepts Cursor variable.;
prompt --> Use Cursor expression to pass in rows;
prompt --> Pass back array for TABLE clause processing;
prompt --> repeat as oftne as needed in statements;
prompt ---------------------------------------------------;
/*
CREATE TABLE stocks (
	ticker	VARCHAR2(20),
	trade_date	DATE,
	open_price	NUMBER,
	close_price	NUMBER
)
/
*/

BEGIN
	FOR indx IN 1 .. 1000
	LOOP
		-- might as well be optimistic
		INSERT INTO stocks
			VALUES ('STK'||indx,
				SYSDATE,
				indx,
				indx + 15);
	END LOOP;
	COMMIT;
END;
/

CREATE TABLE tickers (
	ticker 	VARCHAR2(20),
	pricedate DATE,
	pricetype VARCHAR2(1),
	price	NUMBER
)
/

CREATE OR REPLACE TYPE ticker_ot AUTHID DEFINER IS OBJECT 
(
	tikcer 	VARCHAR2(20),
	pricedate DATE,
	pricetype VARCHAR2(1),
	price NUMBER
);
/

CREATE OR REPLACE TYPE tickers_nt AS TABLE OF ticker_ot;
/

