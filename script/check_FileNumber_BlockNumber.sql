set serveroutput on;
DECLARE
	dba_num   	NUMBER := TO_NUMBER ('018000dd','XXXXXXXX');
	file_num  	NUMBER := DBMS_UTILITY.DATA_BLOCK_ADDRESS_FILE (dba_num);
	block_num	NUMBER := DBMS_UTILITY.DATA_BLOCK_ADDRESS_BLOCK (dba_num);
BEGIN
	DBMS_OUTPUT.PUT_LINE ('File Number : '||file_num);
	DBMS_OUTPUT.PUT_LINE ('Block Number : '||block_num);
END;
/

