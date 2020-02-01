connect hr/hr
drop table emp2 purge;
CREATE TABLE emp2 AS SELECT * FROM employees;
DESC EMP2
ALTER TABLE emp2
   MODIFY (salary NUMBER(9,2)); 
DESC EMP2

