connect system/manager
col username format a12
col priv_used format a30
col ses_actions format a20
select username, priv_used, ses_actions from dba_audit_object;

