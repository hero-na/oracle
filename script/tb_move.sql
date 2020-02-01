connect system/manager
drop tablespace cust_test_tbs including contents and datafiles;
create tablespace cust_test_tbs datafile '/u01/app/oracle/oradata/orcl/cust_test_tbs01.dbf' size 100M;
select table_name, tablespace_name
    from dba_tables
    where owner='OE' and table_name='CUSTOMERS';

alter table oe.customers move tablespace cust_test_tbs;
select table_name, tablespace_name
    from dba_tables
    where owner='OE' and table_name='CUSTOMERS';

