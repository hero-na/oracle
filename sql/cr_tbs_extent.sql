create tablespace extent_test_tbs 
datafile '/u01/app/oracle/oradata/orcl/extent_test_tbs.dbf.dbf' size 10M;
create table extend_test_tb  ( no number, name varchar2(10)) tablespace extent_test_tbs;
