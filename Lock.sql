#锁
USE dbtest;

#死锁

-- Tx1
-- begin
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 101;#1
UPDATE employees SET salary = salary - 1000 WHERE employee_id = 102;#3

-- Tx2
-- begin
UPDATE employees SET salary = salary + 1000 WHERE employee_id = 102;#2
UPDATE employees SET salary = salary - 1000 WHERE employee_id = 101;#4

#解决死锁
-- 1 超时

-- 2 死锁检测
--   一旦检测到死锁，InnoDB会选择回滚undo量最小的事务
