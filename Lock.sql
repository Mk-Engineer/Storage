#锁
USE dbtest;

#Dead-Lock

-- Tx1
-- begin
update employees set salary = salary + 1000 WHERE employee_id = 101;
update employees set salary = salary - 1000 WHERE employee_id = 102;

-- Tx2
-- begin
update employees set salary = salary + 1000 WHERE employee_id = 102;
update employees set salary = salary - 1000 WHERE employee_id = 101;

