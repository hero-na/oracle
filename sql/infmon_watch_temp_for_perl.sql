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

select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') || ',' ||
       INS1MB                                   || ',' ||
       INS2MB                                   || ',' ||
       (INS1MB + INS2MB)                        || ',' ||
       INS1MBPER                                || ',' ||
       INS2MBPER                                || ',' ||
       to_char( INS1MBPER + INS2MBPER ,'990.0000')
from 
(    select 
           nvl(sum1 ,0) INS1MB
          ,to_char( nvl(sum1 ,0)  / &1 ,'990.0000') INS1MBPER
   from 
        (select '1' abc from dual ) a, 
        (select '1' abc, inst_id
         ,sum(blocks * 8 / 1024) sum1 
         from gv$tempseg_usage 
         where inst_id = 1
         group by inst_id ) b
   where a.abc = b.abc (+)
),
(    select
           nvl(sum2 ,0) INS2MB
          ,to_char( nvl(sum2 ,0)  / &1 ,'990.0000') INS2MBPER
   from 
        (select '1' abc from dual ) a, 
        (select '1' abc, inst_id
         ,sum(blocks * 8 / 1024) sum2
         from gv$tempseg_usage 
         where inst_id = 2
         group by inst_id ) b
   where a.abc = b.abc (+)
)
;

