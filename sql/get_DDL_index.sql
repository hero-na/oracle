set heading off;
set echo off;
Set pages 999;
set long 90000; 
spool get_ddl_index.log 
select dbms_metadata.get_ddl('INDEX','CUST_LNAME_IX','OE') from dual;
spool off
