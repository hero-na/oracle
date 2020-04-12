connect /as sysdba

DROP TABLE scott.dept_part PURGE;
CREATE TABLE scott.dept_part
(deptno NUMBER NOT NULL,
loc VARCHAR2(10))
PARTITION BY RANGE (deptno)
(PARTITION part1 VALUES LESS THAN(30),
PARTITION part2 values less than (MAXVALUE));

CREATE INDEX scott.dept_idx ON scott.dept_part(deptno) LOCAL;

set pagesize 200
set linesize 120
col table_name format a20
col partition_name format a30
col index_owner format a20
col index_name format a20
col status format a10
select table_name,partition_name
from dba_tab_partitions
where table_name = 'DEPT_PART';

select index_owner, index_name, partition_name, status 
from dba_ind_partitions
where index_name='DEPT_IDX'; 

ALTER TABLE scott.dept_part MODIFY PARTITION part1 
   UNUSABLE LOCAL INDEXES;

select index_owner, index_name, partition_name, status
from dba_ind_partitions
where index_name='DEPT_IDX';

ALTER TABLE scott.dept_part MODIFY PARTITION part2     
   UNUSABLE LOCAL INDEXES;

select index_owner, index_name, partition_name, status
from dba_ind_partitions
where index_name='DEPT_IDX';

ALTER TABLE scott.dept_part MODIFY PARTITION part1
   REBUILD UNUSABLE LOCAL INDEXES;

ALTER TABLE scott.dept_part MODIFY PARTITION part2
   REBUILD UNUSABLE LOCAL INDEXES;

select index_owner, index_name, partition_name, status
from dba_ind_partitions
where index_name='DEPT_IDX';





