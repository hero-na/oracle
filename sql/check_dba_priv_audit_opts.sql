connect system/manager
col user_name format a7
col proxy_name format a10
col privilege format a20
col success format a10
col failure format a10
select * from sys.dba_priv_audit_opts;

