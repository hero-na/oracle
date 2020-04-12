-- *********************************************************************
-- * V$SYSTEM_EVENT
-- *   イベントの待機の合計の情報
-- *********************************************************************
--ALTER SESSION TIMED_STATISTICS = TRUE ;
--
select
    sysdate              || ',' ||
    EVENT                || ',' ||
    TOTAL_WAITS          || ',' ||
    TOTAL_TIMEOUTS       || ',' ||
    TIME_WAITED          || ',' ||
    AVERAGE_WAIT         || ',' ||
    TIME_WAITED_MICRO    || ',' ||
    TOTAL_WAITS_FG       || ',' ||
    TOTAL_TIMEOUTS_FG    || ',' ||
    TIME_WAITED_FG       || ',' ||
    AVERAGE_WAIT_FG      || ',' ||
    TIME_WAITED_MICRO_FG || ',' ||
    EVENT_ID             || ',' ||
    WAIT_CLASS_ID        || ',' ||
    WAIT_CLASS#          || ',' ||
    WAIT_CLASS
  from
    V$SYSTEM_EVENT
;
--
--ALTER SESSION TIMED_STATISTICS = FALSE ;
