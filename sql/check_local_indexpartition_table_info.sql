connect /as sysdba
col tablespace_name format a20
col partition_name format a20
col num_rows format 9999
set linesize 120
set pagesize 200

SELECT partition_name,tablespace_name, num_rows
FROM dba_tab_partitions where table_name='EMPLOYEES' and table_owner='SCOTT'
ORDER by table_name, partition_name;

