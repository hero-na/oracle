connect scott/tiger
DROP TABLE myemp PURGE;
CREATE TABLE myemp as SELECT empno, ename, mgr from emp;
select * from myemp;

 
