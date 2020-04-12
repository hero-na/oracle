/*****************************************************************************
【スクリプト名】
infmon_check_invalid.sql
*****************************************************************************/

select * from global_name;
show user
select owner,object_name,object_type,status from dba_objects
where owner in ('SWBAPPS','FALLOC') and status != 'VALID';

