-- *********************************************************************
-- * V$RESOURCE_LIMIT
-- *   一部のシステム・リソースでのグローバル・リソースの使用状況に
-- *   関する情報
-- *********************************************************************
select
    sysdate             || ',' ||
    RESOURCE_NAME       || ',' ||
    CURRENT_UTILIZATION || ',' ||
    MAX_UTILIZATION     || ',' ||
    INITIAL_ALLOCATION  || ',' ||
    LIMIT_VALUE
  from
    V$RESOURCE_LIMIT
;
