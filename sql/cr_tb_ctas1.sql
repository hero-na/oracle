connect scott/tiger
col empno format 99999
col ename format a10
col job format a10
col mgr format 99999
set linesize 120
set pagesize 100
drop table emp_test_1 purge;
create table emp_test_1
as select * from emp;

