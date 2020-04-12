--##############################################################################
--##  ì¡íËèàóù  >=30  
--##############################################################################
--
SET HEAD   OFF
SET PAGES 1000
SET LINES 1500
SET TRIMS   ON
SET TRIM    ON
--
--##############################################################################
--##  é¿çsíÜSQL
--##############################################################################
--
PROMPT SYSDATE|SID|SERIAL#|USERNAME|OSUSER|MACHINE|TERMINAL|PROGRAM|LOGON_TIME|STATUS|SQL_ADDRESS|SQL_TEXT|APPLICATION_WAIT_TIME|CONCURRENCY_WAIT_TIME|CLUSTER_WAIT_TIME|USER_IO_WAIT_TIME|PLSQL_EXEC_TIME|JAVA_EXEC_TIME
--
SELECT
      trim(SYSDATE)                  || '|' ||
      trim(SS.SID)                   || '|' ||
      trim(SS.SERIAL#)               || '|' ||
      trim(SS.USERNAME)              || '|' ||
      trim(SS.OSUSER)                || '|' ||
      trim(SS.MACHINE)               || '|' ||
      trim(SS.TERMINAL)              || '|' ||
      trim(SS.PROGRAM)               || '|' ||
      trim(SS.LOGON_TIME)            || '|' ||
      trim(SS.STATUS)                || '|' ||
      trim(SS.SQL_ADDRESS)           || '|' ||
      trim(SA.SQL_TEXT)              || '|' ||
      trim(SA.APPLICATION_WAIT_TIME) || '|' ||
      trim(SA.CONCURRENCY_WAIT_TIME) || '|' ||
      trim(SA.CLUSTER_WAIT_TIME)     || '|' ||
      trim(SA.USER_IO_WAIT_TIME)     || '|' ||
      trim(SA.PLSQL_EXEC_TIME)       || '|' ||
      trim(SA.JAVA_EXEC_TIME)
  FROM  V$SESSION  SS
      , V$SQLAREA  SA
  WHERE TYPE = 'USER'
    AND SS.STATUS = 'ACTIVE'
    AND SS.SQL_ADDRESS = SA.ADDRESS
  ORDER BY   SS.SID
           , SS.SERIAL#
;

