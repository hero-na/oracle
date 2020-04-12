--set termout off
set feedback off
set pagesize 0
set linesize 2000
set heading off
set trimspool on
set colsep '	'

--column year_month new_value year_month_text noprint
--column node new_value node_text noprint

--select to_char(sysdate,'yyyymm') year_month from dual;
--select instance_name node from v$instance;

--spool log/longsql_check_detail_&node_text._&year_month_text..log append
--spool log/now_longsql_check_detail_&node_text..log

SELECT TARGET
      ,OPNAME AS "Operation"
      ,LONGOPS.SQL_ID
      ,VS.SQL_TEXT
      ,TO_CHAR(MIN(START_TIME) 
      ,'yyyy/mm/dd hh24:mi:ss') AS "最古記録時間"
      ,TO_CHAR(MAX(START_TIME) 
      ,'yyyy/mm/dd hh24:mi:ss') AS "最新記録時間"
      ,TO_CHAR(COUNT(*) 
      ,'999999') AS "発生回数"
      ,TO_CHAR(SUM(ELAPSED_SECONDS) 
      ,'999999') AS "SUM 実行時間[s]"
      ,TO_CHAR(AVG(ELAPSED_SECONDS) 
      ,'999999') AS "AVG 実行時間[s]"
      ,TO_CHAR(MIN(ELAPSED_SECONDS) 
      ,'999999') AS "MIN 実行時間[s]"
      ,TO_CHAR(MAX(ELAPSED_SECONDS) 
      ,'999999') AS "MAX 実行時間[s]"
      ,TO_CHAR(SUM(TOTALWORK) 
      ,'999999999') AS "SUM UNIT数"
      ,TO_CHAR(AVG(TOTALWORK) 
      ,'999999999') AS "AVG UNIT数"
      ,TO_CHAR(MIN(TOTALWORK) 
      ,'999999999') AS "MIN UNIT数"
      ,TO_CHAR(MAX(TOTALWORK) 
      ,'999999999') AS "MAX UNIT数"
      ,UNITS
  FROM V$SESSION_LONGOPS LONGOPS
  LEFT OUTER
  JOIN V$SQL VS ON LONGOPS.SQL_ID = VS.SQL_ID
 WHERE ELAPSED_SECONDS >= 600
   AND LONGOPS.START_TIME > SYSDATE -((1 / 24) * 6)
 GROUP BY TARGET
         ,OPNAME
         ,LONGOPS.SQL_ID
         ,VS.SQL_TEXT
         ,UNITS
 ORDER BY TARGET
         ,OPNAME
         ,LONGOPS.SQL_ID
         ,VS.SQL_TEXT
         ,UNITS 
;

--spool off
