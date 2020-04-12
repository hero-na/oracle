col index_name format a30
col table_name format a23
col column_name format a20
col table_owner format a10
set linesize 120
set pagesize 300
SELECT index_name, table_owner, table_name, column_name
     FROM   DBA_IND_COLUMNS
     WHERE index_owner = 'OE' and table_name='CUSTOMERS';

