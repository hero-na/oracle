connect system/manager
col OPTION# format 9999
col name format a40
col property format 9999
select * from stmt_audit_option_map;
select * from stmt_audit_option_map
where name like '%TABLE%';
