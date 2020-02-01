connect oe/oe
desc customers
ALTER TABLE customers
RENAME COLUMN credit_limit TO credit_amount;

desc customers
ALTER TABLE customers
RENAME COLUMN credit_amount TO credit_limit;



