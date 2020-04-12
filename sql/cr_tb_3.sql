CONN scott/tiger
DROP TABLE my_temp_table PURGE;
CREATE GLOBAL TEMPORARY TABLE my_temp_table (
  id           NUMBER,
  description  VARCHAR2(20)
)
ON COMMIT PRESERVE ROWS;

INSERT INTO my_temp_table VALUES (1, 'ONE');
COMMIT;

SELECT * FROM my_temp_table;

CONN scott/tiger
SELECT * FROM my_temp_table;
