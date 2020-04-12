
col table_name for a15
col tablespace_name for a25
col index_name for a25
col index_type for a15
col table_type for a20
col partition_name for a15
col high_value for a10
col num_rows for 999
col status for a10


select index_name, partition_name, tablespace_name, high_value, num_rows,status
from dba_ind_partitions
where index_name='EMPLOYEES_GLOBAL_IDX'
order by partition_name;

select index_name, index_type, table_name
from dba_indexes
where index_name='EMPLOYEES_GLOBAL_IDX' and owner='SCOTT';

