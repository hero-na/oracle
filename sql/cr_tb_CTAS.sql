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
select * from emp_test_1;

drop table emp_test_2 purge;
create table emp_test_2   
as select * from emp
where deptno=10;
select * from emp_test_2;

drop table emp_test_3 purge;
create table emp_test_3
as select ename from emp;
select * from emp_test_3;

drop table emp_test_4 purge;
create table emp_test_4
as select * from emp
where 1=0;
select * from emp_test_4;

