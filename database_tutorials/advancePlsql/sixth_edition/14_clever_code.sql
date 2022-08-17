SET SERVEROUTPUT ON;

DECLARE
	"pi"	CONSTANT NUMBER := 3.141592654;
	"PI"	CONSTANT NUMBER := 3.141592623423423454354345;
	"2 pi"	CONSTANT NUMBER := 2 * "pi";
BEGIN
	DBMS_OUTPUT.PUT_LINE('pi: ' || "pi");
	DBMS_OUTPUT.PUT_LINE('PI: ' || pi);
	DBMS_OUTPUT.PUT_LINE('2 pi:'|| "2 pi");

	/* Notice that line 7 refers to pi without quotation marks. 
	|  Because the compiler accomplishes its case-independence by defaulting identifiers and keywords to uppercase, 
	|  the variable that line 7 refers to is the one declared on line 3 as "PI"
	*/
END;
/

show errors;
