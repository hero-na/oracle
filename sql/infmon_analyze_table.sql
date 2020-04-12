/*****************************************************************************
【スクリプト名】
infmon_analyze_table.sql
*****************************************************************************/

set trims on
set timing on
select * from global_name;
show user
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') "ANALYZED_DATE" from dual;
prompt ANALYZE &1
analyze table &1 LIST CHAINED ROWS INTO MNGUSER.CHAINED_ROWS;
set trims off
set timing off

