connect /as sysdba

DROP TABLE scott.employees PURGE;
DROP TABLE scott.employees_test PURGE;

DROP TABLESPACE EMPLOYEES_20_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMPLOYEES_40_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMPLOYEES_60_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMPLOYEES_80_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMPLOYEES_100_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE EMPLOYEES_120_TBS INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE EMPLOYEES_20_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_20_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMPLOYEES_40_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_40_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMPLOYEES_60_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_60_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMPLOYEES_80_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_80_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMPLOYEES_100_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/employees_100_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE EMPLOYEES_120_TBS 
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
partition p_20 values less than(21) tablespace EMPLOYEES_20_TBS,
partition p_40 values less than(41) tablespace EMPLOYEES_40_TBS,
partition p_60 values less than(61) tablespace EMPLOYEES_60_TBS,
partition p_80 values less than(81) tablespace EMPLOYEES_80_TBS,
partition p_100 values less than(101) tablespace EMPLOYEES_100_TBS,
partition p_120 values less than(121)tablespace EMPLOYEES_120_TBS
)
;

insert into scott.employees 
        select * from scott.employees_test where department_id IS NOT NULL ;
commit;
EXEC DBMS_STATS.gather_table_stats('SCOTT', 'EMPLOYEES');

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

@check_global_index_table_partition_info.sql

drop index scott.employees_global_idx;

drop TABLESPACE IDX_EMPLOYEES_120_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMPLOYEES_160_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMPLOYEES_200_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMPLOYEES_max_TBS INCLUDING CONTENTS AND DATAFILES;
drop TABLESPACE IDX_EMPLOYEES_MOVE_TBS INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE IDX_EMPLOYEES_120_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_120_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMPLOYEES_160_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_160_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMPLOYEES_200_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_200_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMPLOYEES_max_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_max_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;
CREATE TABLESPACE IDX_EMPLOYEES_MOVE_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_employees_move_tbs01.dbf' size 10 M autoextend on next 10m maxsize 160m;


create index scott.employees_global_idx
on scott.employees (employee_id) 
global partition by range(employee_id)
(
partition gp1_idx values less than (120) tablespace IDX_EMPLOYEES_120_TBS,
partition gp2_idx values less than (160) tablespace IDX_EMPLOYEES_160_TBS,
partition gp3_idx values less than (200) tablespace IDX_EMPLOYEES_200_TBS,
partition gp4_idx values less than (maxvalue) tablespace IDX_EMPLOYEES_MAX_TBS
)
;
EXEC DBMS_STATS.gather_index_stats('SCOTT', 'EMPLOYEES_GLOBAL_IDX');

@check_global_indexpartition_info.sql


alter index scott.employees_global_idx rename partition gp4_idx to gp_max_idx;

@check_global_indexpartition_info.sql

alter index scott.employees_global_idx rebuild partition GP1_IDX tablespace IDX_EMPLOYEES_MOVE_TBS;

@check_global_indexpartition_info.sql

alter index scott.employees_global_idx drop partition GP1_IDX;

@check_global_indexpartition_info.sql

alter index scott.employees_global_idx  rebuild partition GP2_IDX tablespace IDX_EMPLOYEES_120_TBS;
@check_global_indexpartition_info.sql

col tablespace_name format a20
col partition_name format a20
col num_rows format 9999
set linesize 120
set pagesize 200

@check_global_index_table_partition_info.sql
@check_global_indexpartition_info.sql

alter table scott.employees drop partition P_20;
alter table scott.employees drop partition P_40;
alter table scott.employees drop partition P_60;


@check_global_indexpartition_info.sql

alter index scott.employees_global_idx  rebuild partition GP2_IDX tablespace IDX_EMPLOYEES_120_TBS;
alter index scott.employees_global_idx  rebuild partition GP3_IDX tablespace IDX_EMPLOYEES_200_TBS;
alter index scott.employees_global_idx  rebuild partition GP_MAX_IDX tablespace IDX_EMPLOYEES_MAX_TBS;

@check_global_indexpartition_info.sql

