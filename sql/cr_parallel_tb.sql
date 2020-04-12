connect scott/tiger
drop table emp_pl purge;
create table emp_pl PARALLEL
as select * from emp;

