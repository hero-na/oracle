set termout off
set serveroutput on
set feedback off
set verify off
set wrap off
set sqlcontinue off
set echo off
set pagesize 0
set linesize 1000
set heading off
set trimspool on
set colsep ','

col GET_TIME             for a19 
col TABLESPACE_NAME      for a12
col TUNED_UNDORETENTION  for 999999999  
col TXNCOUNT             for 99999  
col MAXQUERYLEN          for 999999  
col MAXCONCURRENCY       for 9999  
col ACTIVE_MB            for 999999.99  
col UNEXPIRED_MB         for 999999.99  
col EXPIRED_MB           for 999999.99  
col FREE_MB              for 999999.99  
col TOTAL_MB             for 999999.99  

SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd hh24:mi:ss') GET_TIME
      ,nvl(UNDS.TUNED_UNDORETENTION,0) TUNED_UNDORETENTION 
      ,UNDS.TXNCOUNT
      ,UNDS.MAXQUERYLEN
      ,UNDS.MAXQUERYID
      ,UNDS.MAXCONCURRENCY
      ,PVT.TABLESPACE_NAME TABLESPACE_NAME
      ,nvl(PVT.ACTIVE    / (1024 * 1024 ),0)  ACTIVE_MB
      ,nvl(PVT.UNEXPIRED / (1024 * 1024 ),0)  UNEXPIRED_MB
      ,nvl(PVT.EXPIRED   / (1024 * 1024 ),0)  EXPIRED_MB
      ,(nvl(DAT.TOTAL,0) -  nvl(PVT.ACTIVE,0) 
                         -  nvl(PVT.UNEXPIRED,0) 
                         -  nvl(PVT.EXPIRED,0)  
                   )     / (1024 * 1024 )  FREE_MB
      ,nvl(DAT.TOTAL     / (1024 * 1024 ),0)  TOTAL_MB
  FROM 
      ( SELECT TABLESPACE_NAME
              ,nvl(SUM(DECODE(STATUS, 'ACTIVE', BYTES,NULL)),0) "ACTIVE"
              ,nvl(SUM(DECODE(STATUS, 'UNEXPIRED', BYTES,NULL)),0) "UNEXPIRED"
              ,nvl(SUM(DECODE(STATUS, 'EXPIRED', BYTES,NULL)),0) "EXPIRED"
        FROM DBA_UNDO_EXTENTS
        GROUP BY TABLESPACE_NAME
      ) PVT,
      (
         SELECT TUNED_UNDORETENTION
               ,TXNCOUNT
               ,MAXQUERYLEN
               ,MAXQUERYID
               ,MAXCONCURRENCY
               ,TBS.NAME TABLESPACE_NAME
         FROM   V$UNDOSTAT UND
               ,V$TABLESPACE TBS
         WHERE BEGIN_TIME =
               ( SELECT MAX(BEGIN_TIME) 
                 FROM V$UNDOSTAT 
               ) 
         AND UND.UNDOTSN = TBS.TS#
       ) UNDS , 
       (
         SELECT VALUE TABLESPACE_NAME
         FROM V$PARAMETER
         WHERE NAME = 'undo_tablespace'
       ) PARA , 
       (
         SELECT TABLESPACE_NAME
               ,SUM(BYTES) TOTAL
         FROM DBA_DATA_FILES
         GROUP BY TABLESPACE_NAME
       ) DAT
WHERE  PARA.TABLESPACE_NAME = PVT.TABLESPACE_NAME
   AND PARA.TABLESPACE_NAME = UNDS.TABLESPACE_NAME
   AND PARA.TABLESPACE_NAME = DAT.TABLESPACE_NAME
;
