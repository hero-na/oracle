set serveroutput on
set feedback off
set verify off
set wrap off
set sqlcontinue off
set echo off
set pagesize 0
set linesize 600
set heading off
set trimspool on

select
	to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') || ',' ||
	vs.inst_id || ',' ||
	vs.serial# || ',' ||
	vs.username  || ',' ||
	vs.status  || ',' ||
	vs.osuser  || ',' ||
	vs.machine  || ',' ||
	vs.program  || ',' ||
	tpu.sql_id  || ',' ||
	sql_exec_start  || ',' ||
	vs.client_info  || ',' ||
	vs.logon_time  || ',' ||
	tpu.contents  || ',' ||
	tpu.segtype || ',' ||
	tpu.blocks  || ',' ||
	(tpu.blocks * 8 / 1024)
from
	 gv$tempseg_usage tpu, gv$session vs
where
	tpu.session_num = vs.serial# and 
	tpu.session_addr = vs.saddr
;

