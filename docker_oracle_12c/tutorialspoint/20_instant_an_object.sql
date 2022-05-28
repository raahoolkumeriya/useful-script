/*
|	Program: Object Oriented
|	Author: Raahool Kumeriya
|	Change history:
|		08-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;


prompt --------- Instantiating an Object 

DECLARE
	residence address;
BEGIN
	residence := address('10','JK-Road','Katol','MH','441302');
	DBMS_OUTPUT.PUT_LINE('Address :'
			||residence.house_no
			||', '
			||residence.street
			||', '
			||residence.city
			||' '
			||residence.state
			||'. Pin code - '
			||residence.pincode);
END;
/



