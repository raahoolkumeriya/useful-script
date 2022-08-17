/*
|	Program: INTERVALS  
|	Author: Raahool Kumeriya
|	Change history:
|		12-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REMARK to enable all warnings in your session;
ALTER SESSION SET plsql_warnings = 'enable:all';

prompt ---------------------------------------------------;
prompt --     		INTERVALS			--;
prompt ---------------------------------------------------;
prompt -- Finding the difference between two datetime values--;
prompt ---------------------------------------------------;

DECLARE
	start_date	TIMESTAMP;
	end_date	TIMESTAMP;
	service_interval	INTERVAL YEAR TO MONTH;
	years_of_service	NUMBER;
	months_of_service	NUMBER;
BEGIN
	-- normally we would retrive start and end dates from a database
	start_date := TO_TIMESTAMP('26-DEC-1988', 'dd-mon-yyyy');
	end_date := TO_TIMESTAMP('26-DEC-1995', 'dd-mon-yyyy');

	-- Determine and display years and months of service
	service_interval := ( end_date - start_date ) YEAR TO MONTH;
	DBMS_OUTPUT.put_line(service_interval);

	-- Use the new EXTRACT function to grab individual
	-- year and month components
	years_of_service := EXTRACT( YEAR FROM service_interval);
	months_of_service := EXTRACT( MONTH FROM service_interval);
	DBMS_OUTPUT.put_line(years_of_service 	|| ' years and '
						|| months_of_service
						|| ' months.');
END;
/

prompt ---------------------------------------------------;
prompt -- 	Datetime conversion 			--;
prompt ---------------------------------------------------;

DECLARE
	dt 	DATE;
	ts	TIMESTAMP;
	tstz	TIMESTAMP WITH TIME ZONE;
	tsltz	TIMESTAMP WITH LOCAL TIME ZONE;
BEGIN
	dt := TO_DATE('12/26/2005','mm/dd/yyyy');
	ts := TO_TIMESTAMP('24-feb-2002 09.00.00.50 PM');
	tstz := TO_TIMESTAMP_TZ('06/2/2022 09:00:00.05 PM EST','mm/dd/yyyy hh:mi:ssxff AM TZD');
	tsltz := TO_TIMESTAMP_TZ('06/2/2022 09:00:00.05 PM EST','mm/dd/yyyy hh:mi:ssxff AM TZD');
	DBMS_OUTPUT.put_line(dt);
	DBMS_OUTPUT.put_line(ts);
	DBMS_OUTPUT.put_line(tstz);
	DBMS_OUTPUT.put_line(tsltz);
END;
/

prompt ---------------------------------------------------;
prompt --     		Date Formatting			--;
prompt ---------------------------------------------------;
BEGIN
	--- it will fill with zeors 
	DBMS_OUTPUT.put_line('Blanks and Zeros added --> '|| TO_CHAR(SYSDATE, 'Month DD, YYYY')); 
	DBMS_OUTPUT.put_line('FM fill emelent to supress blanks and Zeros --> '|| TO_CHAR(SYSDATE, 'FMMonth DD, YYYY')); 
	DBMS_OUTPUT.put_line('Th formatting --> '|| TO_CHAR (SYSDATE, 'MON DDth, YYYY'));
	DBMS_OUTPUT.put_line(TO_CHAR (SYSDATE, 'fmMon DDth, YYYY'));
	DBMS_OUTPUT.put_line('Day of the week for the date --> '|| TO_CHAR (SYSDATE, 'DDD DD D '));
	DBMS_OUTPUT.put_line(TO_CHAR (SYSDATE, 'fmDDD fmDD D '));
	DBMS_OUTPUT.put_line('Fancy formatting for reporting --> '|| TO_CHAR (SYSDATE, '"In month "RM" of year "YEAR'));
END;
/


DECLARE
       ts TIMESTAMP WITH TIME ZONE;
BEGIN
       ts := TIMESTAMP '2002-02-19 13:52:00.123456789 -5:00';
       DBMS_OUTPUT.PUT_LINE(TO_CHAR(ts,'YYYY-MM-DD HH:MI:SS.FF6 AM TZH:TZM'));
END;
/

prompt ---------------------------------------------------;
prompt --     		Num To Y M Interval		--;
prompt ---------------------------------------------------;
DECLARE
       y2m INTERVAL YEAR TO MONTH;
BEGIN
       y2m := NUMTOYMINTERVAL (10.5,'Year');
       DBMS_OUTPUT.PUT_LINE(y2m);
END;
/

prompt ---------------------------------------------------;
prompt --     		Num TO D S Interval		--;
prompt ---------------------------------------------------;
DECLARE
      an_interval INTERVAL DAY TO SECOND;
BEGIN
       an_interval := NUMTODSINTERVAL (1440,'Minute');
       DBMS_OUTPUT.PUT_LINE(an_interval);
END;
/


prompt ---------------------------------------------------;
prompt --  	TO_YMINTERVAL,TO_DSINTERVAL		--;
prompt ---------------------------------------------------;
DECLARE
       y2m INTERVAL YEAR TO MONTH;
       d2s1 INTERVAL DAY TO SECOND;
       d2s2 INTERVAL DAY TO SECOND;
BEGIN
       y2m := TO_YMINTERVAL('40-3'); -- my age
       d2s1 := TO_DSINTERVAL('10 1:02:10');
       d2s2 := TO_DSINTERVAL('10 1:02:10.123'); -- fractional seconds
	DBMS_OUTPUT.put_line(y2m);
	DBMS_OUTPUT.put_line(d2s1);
	DBMS_OUTPUT.put_line(d2s2);
END;
/


DECLARE
       y2m INTERVAL YEAR TO MONTH;
BEGIN
       y2m := INTERVAL '40-3' YEAR TO MONTH;
       DBMS_OUTPUT.PUT_LINE(
          EXTRACT(YEAR FROM y2m) || ' Years and '
          || EXTRACT(MONTH FROM y2m) || ' Months'); 
END;
/

