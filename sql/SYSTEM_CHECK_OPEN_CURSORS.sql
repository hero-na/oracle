set linesize 200
set pagesize 0
set head off
set feedback off
set trimspool on
set echo off
set wrap off
set termout off
set serveroutput on
set verify off
set sqlcontinue off


SELECT
        TO_CHAR(SYSDATE, 'yyyy/mm/dd,hh24:mi:ss') ||','||
        S.USERNAME ||','||
        E.SID ||','||
        S.OSUSER ||','||
        S.MACHINE ||','||
        S.PROGRAM ||','||
        E.VALUE
  FROM V$SESSTAT E
      ,V$STATNAME B
      ,V$SESSION S
 WHERE E.STATISTIC# = B.STATISTIC#
   AND B.NAME = 'opened cursors current'
   AND E.SID = S.SID
   AND E.VALUE >= 10
   AND USERNAME IS NOT NULL
 ORDER BY E.VALUE DESC;
