DECLARE 
	otmr tmr_t := tmr_t.make('OPEN?');
	ftmr tmr_t := tmr_t.make('FETCH?');
	CURSOR lots_stuff IS
		SELECT * 
		FROM plsql_profiler_data
		ORDER BY total_time DESC;
	lots_rec lots_stuff%ROWTYPE;
BEGIN
	otmr.go;
	OPEN lots_stuff;
	otmr.stop;

	ftmr.go;
	FETCH lots_stuff INTO lots_rec;
	ftmr.stop;
END;
/

