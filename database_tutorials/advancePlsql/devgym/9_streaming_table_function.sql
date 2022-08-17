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

/*
CREATE TABLE stocks (
	ticker	VARCHAR2(20),
	trade_date	DATE,
	open_price	NUMBER,
	close_price	NUMBER
)
/

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

*/

CREATE OR REPLACE PACKAGE stock_mgr
	AUTHID DEFINER 
IS
	TYPE stock_rc IS REF CURSOR RETURN stocks%ROWTYPE;

	TYPE tickers_rc IS REF CURSOR RETURN tickers%ROWTYPE;
END stock_mgr;
/

CREATE OR REPLACE FUNCTION doubled ( rows_in stock_mgr.stock_rc)
	RETURN tickers_nt AUTHID DEFINER
IS
	TYPE stocks_aat IS TABLE OF stocks%ROWTYPE INDEX BY PLS_INTEGER;
	l_stocks stocks_aat;

	l_doubled 	tickers_nt := tickers_nt();
BEGIN
	LOOP
		FETCH rows_in BULK COLLECT INTO l_stocks LIMIT 100;
		EXIT WHEN l_stocks.COUNT = 0;
	
		FOR l_row IN 1 .. l_stocks.COUNT 
		LOOP
			l_doubled.EXTEND;
			l_doubled(l_doubled.LAST) := 
				ticker_ot ( l_stocks(l_row).ticker,
					    l_stocks(l_row).trade_date,
					    'O',
					    l_stocks(l_row).open_price);

			l_doubled.EXTEND;
			l_doubled(l_doubled.LAST) := 
				ticker_ot (l_stocks(l_row).ticker,
                                            l_stocks(l_row).trade_date,
                                            'C',
                                            l_stocks(l_row).close_price);
		END LOOP;
	END LOOP;
	CLOSE rows_in;

	RETURN l_doubled;
END;
/


