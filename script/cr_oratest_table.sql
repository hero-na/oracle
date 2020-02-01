drop table wchoi.oraemp purge;
create table wchoi.oraemp as select empno,ename,hiredate,sal,deptno from scott.emp;
drop table wchoi.oradept purge;
create table wchoi.oradept as select deptno,dname from scott.emp;

