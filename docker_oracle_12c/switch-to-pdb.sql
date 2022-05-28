col name FORMAT A25;
COL pdb FORMAT A30;

SELECT name, pdb
FROM   v$services
ORDER BY name;

show con_name;
-- Switch container while connected to a common user.
alter session set container = ORCLPDB1;

show con_name;

-- Create the local user using the CONTAINER clause.
CREATE USER axiomus IDENTIFIED BY axiomus123 CONTAINER=CURRENT;
GRANT CREATE SESSION TO axiomus CONTAINER=CURRENT;
GRANT CREATE TABLE TO axiomus CONTAINER=CURRENT;
GRANT INSERT, UPDATE, DELETE TO axiomus CONTAINER=CURRENT;
GRANT REFERENCES TO axiomus CONTAINER=CURRENT;
GRANT INDEX TO axiomus CONTAINER=CURRENT;
GRANT CREATE VIEW TO axiomus CONTAINER=CURRENT;
GRANT RESOURCE TO axiomus CONTAINER=CURRENT;
GRANT CREATE PROCEDURE TO axiomus CONTAINER=CURRENT;
GRANT CREATE ANY directory, drop any directory TO axiomus CONTAINER=CURRENT;

