connect /as sysdba

DROP TABLE oe.cust_idx_test PURGE;

DROP TABLESPACE CUST_TEST_TBS INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE IDX_CUST_TEST_TBS INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE CUST_TEST_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/cust_test_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;
CREATE TABLESPACE IDX_CUST_TEST_TBS 
DATAFILE '/u01/app/oracle/oradata/orcl/idx_cust_test_tbs01.dbf' size 10 M autoextend on next 10m maxsize 100m;

create table oe.cust_idx_test
( customer_id number(6),
  cust_first_name varchar2(20),
  cust_last_name varchar2(20),
  date_of_birth date,
  credit_limit number(9,2),
  gender varchar2(1))
tablespace cust_test_tbs;

insert into oe.cust_idx_test 
select customer_id, cust_first_name, cust_last_name,date_of_birth,credit_limit, gender
       from oe.customers ;
commit;

EXEC DBMS_STATS.gather_table_stats('OE', 'CUST_IDX_TEST');

col customer_id format 99999
col cust_first_name format a20
col cust_last_name format a20
col date_of_birth format a10
col credit_limit format 9999
col gender format a10

select * from oe.cust_idx_test order by customer_id;

set autotrace on
select customer_id, cust_last_name
from oe.cust_idx_test
where cust_last_name='SEN';
set autotrace off

grant unlimited tablespace to oe;


create index oe.idx_cust_name
on oe.cust_idx_test(cust_last_name) tablespace idx_cust_test_tbs;
EXEC DBMS_STATS.gather_index_stats('OE', 'IDX_CUST_NAME');
@check_index_status.sql
set autotrace on
select customer_id, cust_last_name
from oe.cust_idx_test
where upper(cust_last_name)= 'SEN';
set autotrace off

drop index oe.idx_cust_name;

create index oe.idx_upper_cust_name
on oe.cust_idx_test(UPPER(cust_last_name)) tablespace idx_cust_test_tbs;

EXEC DBMS_STATS.gather_index_stats('OE', 'IDX_UPPER_CUST_NAME');

@check_index_status.sql

set autotrace on
select customer_id, cust_last_name 
from oe.cust_idx_test
where upper(cust_last_name)= 'SEN';

set autotrace off

alter system flush shared_pool;
alter system flush buffer_cache;

