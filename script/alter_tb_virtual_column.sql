connect hr/hr

CREATE TABLE emp2 AS SELECT * FROM employees;
DESC EMP2
ALTER TABLE emp2 ADD (income AS (salary + (salary*commission_pct)));
DESC EMP2

