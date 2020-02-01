col tablespace_name format a20
col partition_name format a20
col subpartition_name format a20
col num_rows format 9999
SELECT partition_name, tablespace_name, subpartition_name, num_rows
FROM dba_tab_subpartitions where table_name='SALES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

