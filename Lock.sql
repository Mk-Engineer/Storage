#锁
USE dbtest;

#Dead-Lock

-- Tx1
-- begin
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 101;#1
UPDATE employees SET salary = salary - 1000 WHERE employee_id = 102;#3

-- Tx2
-- begin
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 102;#2
UPDATE employees SET salary = salary - 1000 WHERE employee_id = 101;#4

