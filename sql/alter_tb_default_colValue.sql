connect scott/tiger

DROP TABLE product_information PURGE;
CREATE TABLE product_information
(product_id number(10),
 product_name varchar2(30),
list_price number(8,2),
min_price number(8,2));

col product_id format 99999
col product_name format a20
col list_price 99999.99
col min_price 99999.99
INSERT INTO product_information (product_id, product_name,
   list_price, min_price)
   VALUES (300, 'left-handed mouse', 40.50, 30.99); 

select * from product_information;

ALTER TABLE product_information
  MODIFY (min_price DEFAULT 10); 

INSERT INTO product_information (product_id, product_name, 
   list_price)
   VALUES (400, 'right-handed mouse', 40.50); 

SELECT * 
    FROM product_information
    WHERE product_id in (300,400);

ALTER TABLE product_information
   MODIFY (min_price DEFAULT NULL); 
