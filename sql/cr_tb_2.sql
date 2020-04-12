connect scott/tiger
DROP TABLE emp_info PURGE;
CREATE TABLE emp_info (empno NUMBER GENERATED AS IDENTITY, ename varchar2(30));
INSERT INTO emp_info (ename) values ('Employee Name');
INSERT INTO emp_info (ename) values ('Employee Name');
INSERT INTO emp_info (ename) values ('Employee Name');
INSERT INTO emp_info (ename) values ('Employee Name');
INSERT INTO emp_info (ename) values ('Employee Name');
INSERT INTO emp_info (ename) values ('Employee Name');
commit;
col ename format a20
select * from emp_info;

