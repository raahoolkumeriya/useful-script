/*
|	Program: Squizzing wors to stock table 
|	Author: Raahool Kumeriya
|	Change history:
|		30-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     --;
prompt ---------------------------------------------------;


CREATE OR REPLACE TYPE stock_ot AUTHID DEFINER IS OBJECT 
(
   ticker VARCHAR2 (20),
   trade_date DATE,
   open_price NUMBER,
   close_price NUMBER
)
/

CREATE OR REPLACE TYPE stocks_nt AS TABLE OF stock_ot;
/

CREATE OR REPLACE FUNCTION singled (tickers_in IN stock_mgr.tickers_rc)
   RETURN stocks_nt
   AUTHID DEFINER
IS
   TYPE tickers_aat IS TABLE OF tickers%ROWTYPE INDEX BY PLS_INTEGER;
   l_tickers    tickers_aat;

   l_singles        stocks_nt := stocks_nt ();
BEGIN
   LOOP
      FETCH tickers_in BULK COLLECT INTO l_tickers LIMIT 100;

      EXIT WHEN l_tickers.COUNT = 0;
      
      FOR indx IN 1 .. l_tickers.COUNT
      LOOP
         l_singles.EXTEND;
         l_singles (l_singles.LAST) :=
            stock_ot (l_tickers (indx).ticker,
                       l_tickers (indx).pricedate,
                       l_tickers (indx).price,
                       l_tickers (indx).price * .5);
      END LOOP;
   END LOOP;

   RETURN l_singles;
END;
/


CREATE TABLE more_stocks
AS
   SELECT *
     FROM TABLE (
             singled (
                CURSOR (
                   SELECT * 
                     FROM TABLE (doubled (
                                   CURSOR (SELECT * FROM stocks))))))
/

SELECT COUNT (*)
  FROM more_stocks
/



