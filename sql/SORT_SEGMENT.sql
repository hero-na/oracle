-- *********************************************************************
-- * V$SORT_SEGMENT
-- *   特定のインスタンスの各ソート・セグメントの情報
-- *********************************************************************
select
    sysdate         || ',' ||
--    INST_ID         || ',' ||
    TABLESPACE_NAME || ',' ||
    SEGMENT_FILE    || ',' ||
    SEGMENT_BLOCK   || ',' ||
    EXTENT_SIZE     || ',' ||
    CURRENT_USERS   || ',' ||
    TOTAL_EXTENTS   || ',' ||
    TOTAL_BLOCKS    || ',' ||
    USED_EXTENTS    || ',' ||
    USED_BLOCKS     || ',' ||
    FREE_EXTENTS    || ',' ||
    FREE_BLOCKS     || ',' ||
    ADDED_EXTENTS   || ',' ||
    EXTENT_HITS     || ',' ||
    FREED_EXTENTS   || ',' ||
    FREE_REQUESTS   || ',' ||
    MAX_SIZE        || ',' ||
    MAX_BLOCKS      || ',' ||
    MAX_USED_SIZE   || ',' ||
    MAX_USED_BLOCKS || ',' ||
    MAX_SORT_SIZE   || ',' ||
    MAX_SORT_BLOCKS || ',' ||
    RELATIVE_FNO
  from
    V$SORT_SEGMENT
;
