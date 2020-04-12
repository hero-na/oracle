--##############################################################################
--##  “Á’èˆ—  >=30  
--##############################################################################
--
SET HEAD   OFF
SET PAGES 1000
SET LINES 1500
SET TRIMS   ON
SET TRIM    ON
--
PROMPT SYSDATE,INST_ID,SID,SERIAL#,OPNAME,TARGET,TARGET_DESC,SOFAR,TOTALWORK,UNITS,START_TIME,LAST_UPDATE_TIME,TIME_REMAINING,ELAPSED_SECONDS,CONTEXT,MESSAGE,USERNAME,SQL_ADDRESS,SQL_HASH_VALUE,SQL_ID,SQL_PLAN_HASH_VALUE,SQL_EXEC_START,SQL_EXEC_ID,SQL_PLAN_LINE_ID,SQL_PLAN_OPERATION,SQL_PLAN_OPTIONS,QCSID
--
SELECT
      trim(SYSDATE)               || ',' ||
--      trim(INST_ID)               || ',' ||
      trim(SID)                   || ',' ||
      trim(SERIAL#)               || ',' ||
      trim(OPNAME)                || ',' ||
      trim(TARGET)                || ',' ||
      trim(TARGET_DESC)           || ',' ||
      trim(SOFAR)                 || ',' ||
      trim(TOTALWORK)             || ',' ||
      trim(UNITS)                 || ',' ||
      trim(START_TIME)            || ',' ||
      trim(LAST_UPDATE_TIME)      || ',' ||
      trim(TIME_REMAINING)        || ',' ||
      trim(ELAPSED_SECONDS)       || ',' ||
      trim(CONTEXT)               || ',' ||
      trim(MESSAGE)               || ',' ||
      trim(USERNAME)              || ',' ||
      trim(SQL_ADDRESS)           || ',' ||
      trim(SQL_HASH_VALUE)        || ',' ||
      trim(SQL_ID)                || ',' ||
      trim(SQL_PLAN_HASH_VALUE)   || ',' ||
      trim(SQL_EXEC_START)        || ',' ||
      trim(SQL_EXEC_ID)           || ',' ||
      trim(SQL_PLAN_LINE_ID)      || ',' ||
      trim(SQL_PLAN_OPERATION)    || ',' ||
      trim(SQL_PLAN_OPTIONS)      || ',' ||
      trim(QCSID)
  FROM
       V$SESSION_LONGOPS
  WHERE
        START_TIME       >= TRUNC( SYSDATE - 1 )
--    AND INST_ID = 1
--    AND LAST_UPDATE_TIME <= TRUNC(SYSDATE)
    AND ELAPSED_SECONDS >= 30
ORDER BY
        ELAPSED_SECONDS  DESC,
        START_TIME
;

