connect /as sysdba

DROP TABLE scott.employees PURGE;
DROP TABLE scott.employees_test PURGE;

DROP TABLESPACE EMP_20_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMP_40_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMP_60_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMP_80_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMP_100_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMP_120_TBS INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE EMP_20_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_20_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMP_40_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_40_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMP_60_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_60_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMP_80_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_80_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMP_100_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_100_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMP_120_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_120_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;

create table scott.employees_test 
as select employee_id,department_id,last_name,hire_date,salary
       from hr.employees;

create table scott.employees
(
employee_id number,
department_id number,
last_name varchar2(20),
hire_date date,
salary number
)
partition by range (department_id)
(
partition p_20 values less than(21) tablespace EMP_20_TBS,
partition p_40 values less than(41) tablespace EMP_40_TBS,
partition p_60 values less than(61) tablespace EMP_60_TBS,
partition p_80 values less than(81) tablespace EMP_80_TBS,
partition p_100 values less than(101) tablespace EMP_100_TBS,
partition p_120 values less than(121)tablespace EMP_120_TBS
)
;

insert into scott.employees 
        select * from scott.employees_test where department_id IS NOT NULL ;
commit;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'EMP');

col EMPLOYEE_ID format 999
col DEPARTMENT_ID format 999
col LAST_NAME format a20
col HIRE_DATE format a10
col SALARY format 9999999
col tablespace_name format a20
col partition_name format a20
col num_rows format 9999
set linesize 120
set pagesize 200
select * from scott.employees order by employee_id;


drop TABLESPACE IDX_EMP_20_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMP_40_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMP_60_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMP_80_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMP_100_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMP_120_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMP_MOVE_TBS INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE IDX_EMP_20_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_20_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMP_40_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_40_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMP_60_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_60_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMP_80_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_80_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMP_100_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_100_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMP_120_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_120_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMP_MOVE_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_move_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;


create index scott.emp_lp_idx
on scott.employees (department_id) 
local
(
partition lpp1_idx tablespace IDX_EMP_20_TBS,
partition lpp2_idx tablespace IDX_EMP_40_TBS,
partition lpp3_idx tablespace IDX_EMP_60_TBS,
partition lpp4_idx tablespace IDX_EMP_80_TBS,
partition lpp5_idx tablespace IDX_EMP_100_TBS,
partition lpp6_idx tablespace IDX_EMP_120_TBS
)
;

EXEC DBMS_STATS.gather_index_stats('SCOTT', 'EMP_LP_IDX');


@check_local_indexpartition_info.sql

alter index scott.emp_lp_idx rename partition lpp6_idx to lpp_max_idx;

@check_local_indexpartition_info.sql

alter index scott.emp_lp_idx rebuild partition LPP1_IDX tablespace IDX_EMP_MOVE_TBS;

@check_local_indexpartition_info.sql

alter index scott.emp_lp_idx drop partition LPP1_IDX;

@check_local_indexpartition_info.sql

alter index scott.emp_lp_idx  rebuild partition LPP2_IDX tablespace IDX_EMP_40_TBS;
@check_local_indexpartition_info.sql

@check_local_indexpartition_table_info.sql
@check_local_indexpartition_info.sql

alter table scott.employees drop partition P_20;
alter table scott.employees drop partition P_40;
alter table scott.employees drop partition P_60;


@check_local_indexpartition_info.sql

alter index scott.emp_lp_idx  rebuild partition LPP1_IDX tablespace IDX_EMP_20_TBS;
alter index scott.emp_lp_idx  rebuild partition LPP2_IDX tablespace IDX_EMP_40_TBS;
alter index scott.emp_lp_idx  rebuild partition LPP3_IDX tablespace IDX_EMP_60_TBS;

@check_local_indexpartition_info.sql
