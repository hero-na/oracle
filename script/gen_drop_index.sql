


accept TABLE_NAME  prompt "     on which table: "

set    termout off
store  set saved_settings replace
set    heading off verify off autotrace off feedback off
spool  drop_index.sql

select 'DROP INDEX '||ui.index_name||';'
from   user_indexes ui
where  table_name like upper('&TABLE_NAME.%')
/
spool  off
set    termout on
@drop_index.sql
