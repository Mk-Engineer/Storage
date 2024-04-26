#锁
USE dbtest;

#Dead-Lock

-- Tx1
-- begin
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 101;
UPDATE employees SET salary = salary - 1000 WHERE employee_id = 102;

-- Tx2
-- begin
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 102;
UPDATE employees SET salary = salary - 1000 WHERE employee_id = 101;

