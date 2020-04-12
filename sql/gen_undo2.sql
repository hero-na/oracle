drop user scott2 cascade;
create user scott2 identified by tiger
default tablespace users
temporary tablespace temp;
grant dba to scott2;
connect scott2/tiger
DROP TABLE myemp2 PURGE;
CREATE TABLE myemp2 (employee_id number, last_name varchar2(10),
                        mgr_id NUMBER DEFAULT ON NULL 7566 NOT NULL);

INSERT INTO myemp2 (employee_id, last_name, mgr_id)
  (SELECT empno, ename, mgr from scott.emp);
commit;

SELECT employee_id, last_name, mgr_id
  FROM myemp2
  WHERE employee_id = 7839;

update myemp2 
set last_name='CHOI'
where employee_id=7839; 
