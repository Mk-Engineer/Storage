#MVCC
USE dbtest;

-- MVCC
-- 为了查询一些正在被另一个事务更新的行，并且可以看到它们被更新之前的值，这样在做查询的时候就不必等待锁的释放。

-- 隔离级别为“读已提交Read Committed”时，一个事务中的每一次SELECT查询都会重新获取以此Read View。

-- [Y]
