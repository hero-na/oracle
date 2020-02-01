drop user scott3 cascade;
create user scott3 identified by tiger
default tablespace users
temporary tablespace temp;
grant dba to scott3;
connect scott3/tiger
DROP TABLE myemp3 PURGE;
CREATE TABLE myemp3 (employee_id number, last_name varchar2(10),
                        mgr_id NUMBER DEFAULT ON NULL 7566 NOT NULL);

INSERT INTO myemp3 (employee_id, last_name, mgr_id)
  (SELECT empno, ename, mgr from scott.emp);
commit;

SELECT employee_id, last_name, mgr_id
  FROM myemp3
  WHERE employee_id = 7839;

update myemp3 
set last_name='CHOI'
where employee_id=7839; 
