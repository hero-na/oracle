show parameter db_block_size
drop table scott.emp_test purge;
create table scott.emp_test as select * from dba_objects;

exec dbms_stats.gather_table_stats('SCOTT','EMP_TEST');

set linesize 200
set pagesize 300

col segment_name format a20
col blocks format 99999999999999
col empty_blocks format 99999999999999

select NUM_ROWS "Total Rows", INITIAL_EXTENT "Init ext size", NEXT_EXTENT "Next ext size", BLOCKS "Blk below HWM", EMPTY_BLOCKS "Blks beyond HWM" 
from dba_tables 
where table_name='EMP_TEST' and owner='SCOTT';

select count(*) "Blks Actually in Use below HWM"
from
(select substr(rowid,1,15) from scott.emp_test group by substr(rowid,1,15));

select table_name, 
GREATEST(4, ceil(num_rows /((round(((8192 - (ini_trans * 23)) * ((100 - pct_used) /100)) / avg_row_len)))) * 8192)/1024/1024 TableSize_Mbytes 
from dba_tables
where table_name='EMP_TEST';


select header_file "DB File#", header_block, bytes/1024/1024 "Total size in MB", blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='EMP_TEST' and owner='SCOTT';

select segment_name , extent_id , block_id, blocks "How many blks inside ext", bytes/1024 "Ext size in KB"  
from dba_extents
where segment_name='EMP_TEST' and owner='SCOTT';

-- INSERT MORE DATA

insert into scott.emp_test select * from scott.emp_test;
commit;

exec dbms_stats.gather_table_stats('SCOTT','EMP_TEST');

select NUM_ROWS "Total Rows", INITIAL_EXTENT "Init ext size", NEXT_EXTENT "Next ext size", BLOCKS "Blk below HWM", EMPTY_BLOCKS "Blks beyond HWM" 
from dba_tables 
where table_name='EMP_TEST' and owner='SCOTT';

select count(*) "Blks Actually in Use below HWM"
from
(select substr(rowid,1,15) from scott.emp_test group by substr(rowid,1,15));

select table_name, GREATEST(4, ceil(num_rows /
((round(((8192 - (ini_trans * 23)) *
((100 - pct_used) /100)) / avg_row_len)))) *
8192)/1024/1024
TableSize_Mbytes
from dba_tables
where table_name='EMP_TEST';


select header_file "DB File#", header_block, bytes/1024/1024 "MB", blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='EMP_TEST' and owner='SCOTT';

select segment_name , extent_id , block_id, blocks "How many blks inside ext", bytes/1024 "Ext size in KB"  
from dba_extents
where segment_name='EMP_TEST' and owner='SCOTT';


-- DELETE TABLE

delete scott.emp_test;
commit;

exec dbms_stats.gather_table_stats('SCOTT','EMP_TEST');

select NUM_ROWS "Total Rows", INITIAL_EXTENT "Init ext size", NEXT_EXTENT "Next ext size", BLOCKS "Blk below HWM", EMPTY_BLOCKS "Blks beyond HWM"
from dba_tables
where table_name='EMP_TEST' and owner='SCOTT';

select count(*) "Blks Actually in Use below HWM"
from
(select substr(rowid,1,15) from scott.emp_test group by substr(rowid,1,15));

select table_name, GREATEST(4, ceil(num_rows /
((round(((8192 - (ini_trans * 23)) *
((100 - pct_used) /100)) / avg_row_len)))) *
8192)/1024/1024
TableSize_Mbytes
from dba_tables
where table_name='EMP_TEST';

select header_file "DB File#", header_block, bytes/1024/1024 "MB", blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='EMP_TEST' and owner='SCOTT';

select segment_name , extent_id , block_id, blocks "How many blks inside ext", bytes/1024 "Ext size in KB"
from dba_extents
where segment_name='EMP_TEST' and owner='SCOTT';


-- TRUNCATE TABLE


truncate table scott.emp_test;
exec dbms_stats.gather_table_stats('SCOTT','EMP_TEST');

select NUM_ROWS "Total Rows", INITIAL_EXTENT "Init ext size", NEXT_EXTENT "Next ext size", BLOCKS "Blk below HWM", EMPTY_BLOCKS "Blks beyond HWM"
from dba_tables
where table_name='EMP_TEST' and owner='SCOTT';

select count(*) "Blks Actually in Use below HWM"
from
(select substr(rowid,1,15) from scott.emp_test group by substr(rowid,1,15));

select table_name, GREATEST(4, ceil(num_rows /
((round(((8192 - (ini_trans * 23)) *
((100 - pct_used) /100)) / avg_row_len)))) *
8192)/1024/1024
TableSize_Mbytes
from dba_tables
where table_name='EMP_TEST';

select header_file "DB File#", header_block, bytes/1024/1024 "MB", blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='EMP_TEST' and owner='SCOTT';

select segment_name , extent_id , block_id, blocks "How many blks inside ext", bytes/1024 "Ext size in KB"
from dba_extents
where segment_name='EMP_TEST' and owner='SCOTT';

-- DROP TABLE

drop table scott.emp_test purge;

