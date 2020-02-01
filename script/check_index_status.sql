connect /as sysdba
col index_name format a20
col table_name format a13
col tablespace_name format a18
col index_type format a10
col uniqueness format a10
col status format a7 
col column_name format a13
col table_owner format a10
col VISIBILITY format a10
set linesize 120
set pagesize 300

SELECT index_name, table_name,tablespace_name, index_type,
            uniqueness, status, VISIBILITY  
     FROM  DBA_INDEXES
     WHERE owner = 'OE' and table_name ='CUST_IDX_TEST';


SELECT index_name, table_owner, table_name, column_name
     FROM   DBA_IND_COLUMNS
     WHERE index_owner = 'OE' and table_name='CUST_IDX_TEST'
     ORDER BY index_name, column_position;

