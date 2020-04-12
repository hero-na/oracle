SQL> elect dbms_metadata.get_ddl('TABLE','DEPT','SCOTT') from dual;
SP2-0734: unknown command beginning "elect dbms..." - rest of line ignored.
SQL> select dbms_metadata.get_ddl('TABLE','DEPT','SCOTT') from dual;

                                                                                                                                                                                                        
  CREATE TABLE "SCOTT"."DEPT"                                                                                                                                                                           
   (	"DEPTNO" NUMBER(2,0),                                                                                                                                                                              
	"DNAME" VARCHAR2(14),                                                                                                                                                                                  
	"LOC" VARCHAR2(13),                                                                                                                                                                                    
	 CONSTRAINT "PK_DEPT" PRIMARY KEY ("DEPTNO")                                                                                                                                                           
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255                                                                                                                                                        
 COMPUTE STATISTICS                                                                                                                                                                                     
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENT                                                                                                                                             
S 2147483645                                                                                                                                                                                            
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1                                                                                                                                                           
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT                                                                                                                                                               
 CELL_FLASH_CACHE DEFAULT)                                                                                                                                                                              
  TABLESPACE "USERS"  ENABLE                                                                                                                                                                            
   ) SEGMENT CREATION IMMEDIATE                                                                                                                                                                         
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255                                                                                                                                                         
 NOCOMPRESS LOGGING                                                                                                                                                                                     
  STORAGE(INITIAL 65536 NEXT 1048576 MINEX                                                                                                                                                              
TENTS 1 MAXEXTENTS 2147483645                                                                                                                                                                           
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1                                                                                                                                                           
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CE                                                                                                                                                            
LL_FLASH_CACHE DEFAULT)                                                                                                                                                                                 
  TABLESPACE "USERS"                                                                                                                                                                                    
                                                                                                                                                                                                        

SQL> 
SQL> 
SQL> 
SQL> !vi get_DDL_table.sql

SQL> 
SQL> 
SQL> !ls -lrt

SQL> @get_DDL_table.sql
