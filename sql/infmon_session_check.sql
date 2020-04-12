set feedback off
set pagesize 0
set linesize 1000
set heading off
set trimspool on
set colsep ','

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') GET_TIMES
      ,VS.USER_CNT
      ,VS.BG_CNT
      ,VL.SESSIONS_HIGHWATER
  FROM (
SELECT TYPE
  FROM V$SESSION) PIVOT ( COUNT(*)
   FOR TYPE IN ('USER' AS USER_CNT, 'BACKGROUND' AS BG_CNT) ) VS
      ,(
SELECT SESSIONS_HIGHWATER
  FROM V$LICENSE) VL
;


