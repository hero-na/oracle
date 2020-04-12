-- **********************************************************************
-- * Show locked object and lock session
-- **********************************************************************
    --
    --
    column XIDUSN          format 99999  Heading  "XIDUSN"
    column XIDSLOT         format 99999  Heading  "XIDSLOT"
    column XIDSQN          format 99999  Heading  "XIDSQN"
    column OBJECT_NAME     format A40    Heading  "Locked Object"
    column SESSION_ID      format 99999  Heading  "SessID"
    column ORACLE_USERNAME format A12    Heading  "OracleUser"
    column OS_USER_NAME    format A12    Heading  "OS User"
    column PROCESS         format A10    Heading  "Process"
    column LOCKED_MODE     format A16    Heading  "Locked Mode"
    column TYPE            format A4     Heading  "Type"
    --
    prompt SYSDATE,XIDUSN,XIDSLOT,XIDSQN,Locked Object,SessID,OracleUser,OS User,Process,Locked Mode,Type,Ctime
    --
    select SYSDATE
    --      ,LK.INST_ID
          ,LO.XIDUSN
          ,LO.XIDSLOT
          ,LO.XIDSQN
          ,DO.OWNER || '.' || DO.OBJECT_NAME   OBJECT_NAME
          ,LO.SESSION_ID
          ,LO.ORACLE_USERNAME
          ,LO.OS_USER_NAME
          ,LO.PROCESS
          ,decode(LK.LMODE, 1, 'NULL'
                          , 2, 'LineShare'
                          , 3, 'LineExclusive'
                          , 4, 'Share'
                          , 5, 'ShareExclusive'
                          , 6, 'AllLineExclusive'
                          ,    'Unknown[' || LK.LMODE || ']' )  LOCKED_MODE
          ,LK.TYPE
          ,LK.CTIME
      from DBA_OBJECTS      DO
          ,V$LOCK           LK
          ,V$LOCKED_OBJECT  LO
      where LO.OBJECT_ID  = DO.OBJECT_ID
       and  LO.SESSION_ID = LK.SID
       and  LK.ID1        = DO.OBJECT_ID
    ;
