connect /as sysdba
drop table scott.emp_test purge;
create table scott.emp_test as select * from dba_objects;

exec dbms_stats.gather_table_stats('SCOTT','EMP_TEST');

set linesize 200
set pagesize 300

col segment_name format a20
col blocks format 99999999999999
col empty_blocks format 99999999999999

select BLOCKS "Blk below HWM" 
from dba_tables 
where table_name='EMP_TEST' and owner='SCOTT';

select blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='EMP_TEST' and owner='SCOTT';


alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;
alter table scott.emp_test allocate extent;


exec dbms_stats.gather_table_stats('SCOTT','EMP_TEST');
select BLOCKS "Blk below HWM" 
from dba_tables 
where table_name='EMP_TEST' and owner='SCOTT';

select blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='EMP_TEST' and owner='SCOTT';


ALTER TABLE scott.emp_test
    DEALLOCATE UNUSED;

exec dbms_stats.gather_table_stats('SCOTT','EMP_TEST');

select BLOCKS "Blk below HWM" 
from dba_tables 
where table_name='EMP_TEST' and owner='SCOTT';

select blocks "How many blks", extents "How many exts"
from dba_segments where segment_name='EMP_TEST' and owner='SCOTT';


