/*
|	Program: Environemt setup
|	Author: Raahool Kumeriya
|	Change history:
|		27-MAY-2022 - Program Created
*/

SET SERVEROUTPUT ON;
SET PAGES 1000 LINES 192;

REM =========================================================================
REM Suppose to execute but tables not exits
REM @/u01/app/oracle/product/12.2.0/dbhome_1/rdbms/admin/proftab.sql
REM =========================================================================

Rem
Rem $Header: plsql/admin/proftab.sql /main/5 2015/03/12 14:26:21 lvbcheng Exp $
Rem
Rem proftab.sql
Rem
Rem Copyright (c) 1998, 2015, Oracle and/or its affiliates. 
Rem All rights reserved.
Rem
Rem    NAME
Rem      proftab.sql
Rem
Rem    DESCRIPTION
Rem      Create tables for the PL/SQL profiler
Rem
Rem    NOTES
Rem      The following tables are required to collect data:
Rem        plsql_profiler_runs  - information on profiler runs
Rem        plsql_profiler_units - information on each lu profiled
Rem        plsql_profiler_data  - profiler data for each lu profiled
Rem
Rem      The plsql_profiler_runnumber sequence is used for generating unique
Rem      run numbers.
Rem
Rem      The tables and sequence can be created in the schema for each user
Rem      who wants to gather profiler data. Alternately these tables can be
Rem      created in a central schema. In the latter case the user creating
Rem      these objects is responsible for granting appropriate privileges
Rem      (insert,update on the tables and select on the sequence) to all 
Rem      users who want to store data in the tables. Appropriate synonyms 
Rem      must also be created so the tables are visible from other user 
Rem      schemas.
Rem
Rem      The other tables are used for rolling up to line level; the views are
Rem      used to roll up across multiple runs. These are not required to 
Rem      collect data, but help with analysis of the gathered data. 
Rem
Rem      THIS SCRIPT DELETES ALL EXISTING DATA!
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    lvbcheng    03/05/15 - Use longer identifiers
Rem    sylin       06/12/13 - long identifier
Rem    jmuller     10/07/99 - Fix bug 708690: TAB -> blank
Rem    astocks     04/19/99 - Add owner,related_run field to runtab
Rem    astocks     10/21/98 - Add another spare field
Rem    ciyer       09/15/98 - Create tables for profiler
Rem    ciyer       09/15/98 - Created
Rem

/*
-- Does not exists hence
drop table plsql_profiler_data cascade constraints;
drop table plsql_profiler_units cascade constraints;
drop table plsql_profiler_runs cascade constraints;

drop sequence plsql_profiler_runnumber;
*/

create table plsql_profiler_runs
(
  runid           number primary key,  -- unique run identifier,
                                       -- from plsql_profiler_runnumber
  related_run     number,              -- runid of related run (for client/
                                       --     server correlation)
  run_owner       varchar2(128),       -- user who started run
  run_date        date,                -- start time of run
  run_comment     varchar2(2047),      -- user provided comment for this run
  run_total_time  number,              -- elapsed time for this run
  run_system_info varchar2(2047),      -- currently unused
  run_comment1    varchar2(2047),      -- additional comment
  spare1          varchar2(256)        -- unused
);

comment on table plsql_profiler_runs is
        'Run-specific information for the PL/SQL profiler';

create table plsql_profiler_units
(
  runid              number references plsql_profiler_runs,
  unit_number        number,           -- internally generated library unit #
  unit_type          varchar2(128),    -- library unit type
  unit_owner         varchar2(128),    -- library unit owner name
  unit_name          varchar2(128),    -- library unit name
  -- timestamp on library unit, can be used to detect changes to
  -- unit between runs
  unit_timestamp     date,
  total_time         number DEFAULT 0 NOT NULL,
  spare1             number,           -- unused
  spare2             number,           -- unused
  --  
  primary key (runid, unit_number)
);

comment on table plsql_profiler_units is 
        'Information about each library unit in a run';

create table plsql_profiler_data
(
  runid           number,           -- unique (generated) run identifier
  unit_number     number,           -- internally generated library unit #
  line#           number not null,  -- line number in unit
  total_occur     number,           -- number of times line was executed
  total_time      number,           -- total time spent executing line
  min_time        number,           -- minimum execution time for this line
  max_time        number,           -- maximum execution time for this line
  spare1          number,           -- unused
  spare2          number,           -- unused
  spare3          number,           -- unused
  spare4          number,           -- unused
  --
  primary key (runid, unit_number, line#),
  foreign key (runid, unit_number) references plsql_profiler_units
);

comment on table plsql_profiler_data is 
        'Accumulated data from all profiler runs';

create sequence plsql_profiler_runnumber start with 1 nocache;

