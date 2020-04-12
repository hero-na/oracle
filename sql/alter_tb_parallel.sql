connect oe/oe
select degree from user_tables 
where table_name='CUSTOMERS';

ALTER TABLE customers PARALLEL;

select degree from user_tables 
where table_name='CUSTOMERS';

ALTER TABLE customers PARALLEL 4;

select degree from user_tables 
where table_name='CUSTOMERS';

ALTER TABLE customers NOPARALLEL;

select degree from user_tables
where table_name='CUSTOMERS';


