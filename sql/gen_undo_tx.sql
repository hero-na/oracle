connect scott/tiger
DROP TABLE myemp PURGE;
CREATE TABLE myemp (employee_id number, last_name varchar2(10),
                        mgr_id NUMBER DEFAULT ON NULL 7566 NOT NULL);

INSERT INTO myemp (employee_id, last_name, mgr_id)
  (SELECT empno, ename, mgr from emp);
commit;
SELECT employee_id, last_name, mgr_id
  FROM myemp
  WHERE employee_id = 7839;

update myemp
set last_name='CHOI'
where employee_id=7839;
