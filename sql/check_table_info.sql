col num_rows format 999
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
where owner = 'SCOTT'
and   table_name = 'EMP';
