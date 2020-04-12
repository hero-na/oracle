col TRIGGER_NAME format a20
col STATUS format a20


select TRIGGER_NAME,STATUS from user_triggers where table_name='EMPLOYEES';

ALTER TRIGGER SECURE_EMPLOYEES DISABLE;

select TRIGGER_NAME,STATUS from user_triggers where table_name='EMPLOYEES';

