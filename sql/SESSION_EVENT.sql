-- *********************************************************************
-- * V$SESSION_EVENT
-- *   セッションによるイベントの待機情報
-- *********************************************************************
select
    sysdate           || ',' ||
    SID               || ',' ||
    EVENT             || ',' ||
    TOTAL_WAITS       || ',' ||
    TOTAL_TIMEOUTS    || ',' ||
    TIME_WAITED       || ',' ||
    AVERAGE_WAIT      || ',' ||
    MAX_WAIT          || ',' ||
    TIME_WAITED_MICRO || ',' ||
    EVENT_ID          || ',' ||
    WAIT_CLASS_ID     || ',' ||
    WAIT_CLASS#       || ',' ||
    WAIT_CLASS
  from
    V$SESSION_EVENT
;
