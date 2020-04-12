-- **********************************************************************
-- * Show locked object and lock session
-- **********************************************************************
    --
    --
    column SID            format 999    Heading "SID"
    column SERIAL#        format 99999  Heading "Ser#"
    column STATUS         format A8     Heading "Status"
    column MACHINE        format A12    Heading "Machine"
    column TERMINAL       format A12    Heading "Terminal"
    column PROGRAM        format A35    Heading "Program"
    column PROCESS        format A10    Heading "Proc"
    column SPID           format A6     Heading "SPID"
    column OBJECT_NAME    format A35    Heading  "Locked Object"
    --
    prompt SYSDATE,SID,Ser#,Status,Machine,Terminal,Program,Proc,SPID,Locked Object,Ctime
    --
    select SYSDATE
--         , L.INST_ID
         , S.SID
         , S.SERIAL#
         , S.STATUS
         , S.MACHINE
         , S.TERMINAL
         , S.PROGRAM
         , S.PROCESS
         , P.SPID
         , substr(S.SCHEMANAME || '.' || O.OBJECT_NAME, 1, 25) OBJECT_NAME
         , L.CTIME
      from V$SESSION    S
         , V$PROCESS    P
         , DBA_OBJECTS  O
         , V$LOCK       L
      where S.PADDR = P.ADDR(+)
       and  S.SID   = L.SID
       and  L.ID1   = O.OBJECT_ID
       and  S.SERIAL# != 1
    ;
