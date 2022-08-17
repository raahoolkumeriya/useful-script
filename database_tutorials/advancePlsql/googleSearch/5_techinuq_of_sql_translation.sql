/*
|	Program: Technic to handle sql transalation 
|	Author: Raahool Kumeriya
|	Change history:
|		02-JUN-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

prompt ---------------------------------------------------;
prompt --     Technic to handle sql transalation	--;
prompt ---------------------------------------------------;

create or replace package mask_translate is
	procedure tarnslate_sql(
				sql_text in clob,
				translated_text out clob);
	procedure translated_error(
				error_code in binary_integer,
				translated_code out binary_integer,
				translated_sqlstate out varchar2);
end;
/

-- package body 
create or replace package body mask_translate is
	procedure tarnslate_sql(
                                sql_text in clob,
                                translated_text out clob) is
		masks sys.odcivarchar2list := 
			sys.odcivarchar2list('yy','mm','dd','hh','mi','ss','ff');
	begin
		translated_text := sql_text;
		for i in 1 .. masks.count loop
			translated_text := replace(translated_text,masks(i),upper(masks(i)));
		end loop;
	end;

		
	procedure translated_error(
                                error_code in binary_integer,
                                translated_code out binary_integer,
                                translated_sqlstate out varchar2) is
	begin
		null;
	end;
end;
/
show errors;

begin
	dbms_sql_translator.create_profile(
		profile_name => 'DEMO_PROFILE');
	
	dbms_sql_translator.set_attribute(
		profile_name 	=> 'DEMO_PROFILE',
		attribute_name 	=> dbms_sql_translator.ATTR_FOREIGN_SQL_SYNTAX,
		attribute_value => dbms_sql_translator.ATTR_VALUE_FALSE);

	dbms_sql_translator.set_attribute(
		profile_name 	=> 'DEMO_PROFILE',
		attribute_name 	=> dbms_sql_translator.attr_translator,
		attribute_value => 'MCDONAC.mask_traslate');
end;
/
	
