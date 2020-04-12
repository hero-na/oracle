set linesize 200
set pagesize 0
set head off
set feedback off
set trimspool on
set echo off
set wrap off
set termout off
set serveroutput on
set verify off
set sqlcontinue off


SELECT 
	TO_CHAR(SYSDATE, 'yyyy/mm/dd,hh24:mi:ss') ||','|| 
	FREE_SPACE ||','|| 
	REQUESTS ||','|| 
	REQUEST_MISSES ||','|| 
	REQUEST_FAILURES ||','|| 
	LAST_FAILURE_SIZE "REQ,REQ_M,REQ_F,FAIL_SIZE"
  FROM V$SHARED_POOL_RESERVED;
