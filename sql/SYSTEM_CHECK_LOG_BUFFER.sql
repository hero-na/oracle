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


-- 最終カラムの値（redo buffer allocation retries/redo entries)*100 
-- が1以上なら log buffer サイズ見直しを検討する

select 
TO_CHAR(SYSDATE, 'yyyy/mm/dd,hh24:mi:ss') ||','|| 
redo_ent.NAME||','||
redo_ent.VALUE ||','|| 
buf_allocat.NAME||','||
buf_allocat.VALUE ||','|| 
TO_CHAR(trunc(((buf_allocat.VALUE/redo_ent.VALUE)*100),2),990.99) from
(select NAME,VALUE from v$SYSSTAT where NAME in ('redo entries')) redo_ent,
(select NAME,VALUE from v$SYSSTAT where NAME in ('redo buffer allocation retries')) buf_allocat;
