connect system/manager
drop table oe.base_tb purge;

create table oe.base_tb as select object_id, object_name, object_type from dba_objects;

select count(*) from oe.base_tb;

col num_rows format 999999
col blocks format 99999
col empty_blocks format 9999
col avg_space format 9999
col avg_row_len format 9999
set linesize 120
set pagesize 100
select num_rows
      , blocks
      , empty_blocks
      , avg_space
      , avg_row_len
      , last_analyzed
from  dba_tables
where owner = 'OE'
and   table_name = 'BASE_TB';


EXEC DBMS_STATS.gather_table_stats('OE', 'BASE_TB');
select count(*) from oe.base_tb;

select num_rows
      , blocks
      , empty_blocks
      , avg_space
      , avg_row_len
      , last_analyzed
from  dba_tables
where owner = 'OE'
and   table_name = 'BASE_TB';

