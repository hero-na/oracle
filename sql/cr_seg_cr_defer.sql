CONNECT scott/tiger
DROP TABLE cr_tb_defer PURGE;
CREATE TABLE cr_tb_defer (col1 NUMBER, col2 VARCHAR2(20))    SEGMENT CREATION DEFERRED;
SELECT table_name from USER_TABLES
WHERE table_name ='CR_TB_DEFER';

COLUMN segment_name FORMAT A20
COLUMN segment_type FORMAT A20

SELECT segment_name,
       segment_type
FROM   user_segments
WHERE SEGMENT_NAME ='CR_TB_DEFER';

col segment_name for a15
select tablespace_name, extent_id, blocks, bytes
from user_extents
where segment_name = 'CR_TB_DEFER';


INSERT INTO cr_tb_defer values (1, 'CHOI');
COMMIT;
SELECT table_name from USER_TABLES
WHERE table_name ='CR_TB_DEFER';

COLUMN segment_name FORMAT A20
COLUMN segment_type FORMAT A20
SELECT segment_name,
       segment_type
FROM   user_segments
WHERE SEGMENT_NAME ='CR_TB_DEFER';

col tablespace_name for a15
select segment_name, extent_id, blocks, bytes
from user_extents
where segment_name = 'CR_TB_DEFER';

