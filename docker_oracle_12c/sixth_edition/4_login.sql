
REM Number of lines of SELECT statement output before reprinting headers
    SET PAGESIZE 999

REM Width of displayed page, expressed in characters
    SET LINESIZE 132

REM Enable display of DBMS_OUTPUT messages. Use 1000000 rather than
REM "UNLIMITED" for databases earlier than Oracle Database 10g Release 2
    SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

REM Change default to "vi improved" editor
    DEFINE _EDITOR = /usr/local/bin/vim

REM Format misc columns commonly retrieved from data dictionary
    COLUMN segment_name FORMAT A30 WORD_WRAP
    COLUMN object_name FORMAT A30 WORD_WRAP

REM Set the prompt (works in SQL*Plus
    REM in Oracle9i Database or later)
    SET SQLPROMPT "_USER'@'_CONNECT_IDENTIFIER > "


