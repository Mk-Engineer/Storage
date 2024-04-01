#事务
USE dbtest;

-- 事务：一组逻辑操作单元，使数据从一种状态变换到另一种状态。

-- 1 开启事务
-- 2 一些列DML操作
-- 3 提交事务(COMMIT) / 终止事务(ROLLBACK)

-- 显式事务
-- 开启关键字：
-- START TRANSACTION (READ ONLY / READ WRITE / WITH CONSISTENT SNAPSHOT)
-- BEGIN


-- 保存点（SAVEPOINT）
-- 在事务中间设置保存点
-- 设置：SAVEPOINT s1
-- 释放：RELEASE SAVEPOINT


-- 隐式事务
-- 关键字：autocommit
-- SET autocommit = FALSE;
SHOW VARIABLES LIKE 'autocommit';

-- 关闭自动提交
-- SET autocommit = FALSE;
-- COMMIT;

-- 即使在autocommit = TRUE的情况下，
-- 使用START TRANSACTION 或 BEGIN 开启事务，
-- 那么DML就不会自动提交数据


-- 隐式提交数据的情况

-- 1 数据定语言（Data definition language / DDL）
-- 当使用CREATE / ALTER / DROP 等语句去修改数据库对象时，回隐士提交【前边语句】所属的事务

-- 2 隐式使用或修改mysql数据库中的表
-- 当使用ALTER USER / CREATE USER / DROP USER / GRANT / RENAME USER / REVOKE / SET PASSWORD

-- 3 事务控制或关于锁定的语句
-- 在上一个事务还没提交或者回滚时，就再次使用START TRANSACTION / BEGIN 语句开启了另一个事务时，会隐式提交上一个事务
-- 当前的autocommit系统变量为OFF，当手动调为ON时，也会隐式提交前面的语句
-- 使用LOCK TABLES / UNLOCK TABLES 等关于锁定的语句也会隐式的提交前面语句所属的事务

-- 4 加载数据的语句
-- 使用LOAD DATA语句来批量向数据库中倒入数据时，也会隐式提交

-- 5 关于MySQL复制的一些语句
-- START SLAVE / STOP SLAVE / RESET SLAVE / CHANGE MASTER TO 等语句时也会触发隐式提交

-- 6 其他语句
-- 使用ANALYZE TABLE / CACHE INDEX / CHECK TABLE / FLUSH / LOAD INDEX INTO CACHE / OPTIMIZE TABLE / REPAIR TABLE / RESET 等也会触发隐式提交


-- 演示代码
-- 情况1
CREATE TABLE IF NOT EXISTS users(name VARCHAR(20), PRIMARY KEY(name)) ENGINE=InnoDB; 

BEGIN;
INSERT INTO users SELECT "ZhangSan";
COMMIT;

BEGIN;
INSERT INTO users SELECT 'LiSi';
INSERT INTO users SELECT 'LiSi';
ROLLBACK;

SELECT * FROM users;

-- 情况2
TRUNCATE TABLE users; #DDL操作会自动提交数据，不受autocommit影响
SELECT * FROM users;

BEGIN;
INSERT INTO users VALUES('ZHANG SAN');
COMMIT;

-- 没有BEGIN
INSERT INTO users VALUES('LI SI');#默认情况下DML操作也会自动提交数据，即autocommit为TRUE时
INSERT INTO users VALUES('LI SI');
ROLLBACK;

SELECT * FROM users;

-- 情况3
TRUNCATE TABLE users;
SELECT * FROM users;

SELECT @@completion_type;
SET @@completion_type = 1;

BEGIN;
INSERT INTO users VALUES('zhangsan');
COMMIT;

INSERT INTO users VALUES('lisi');
INSERT INTO users VALUES('lisi');
ROLLBACK;

SELECT * FROM users;

SET @@completion_type = 0;
SELECT @@completion_type;


-- InnoDB和MyISAM的区别
SELECT * FROM t_innodb;
SELECT * FROM t_myisam;

SHOW CREATE TABLE t_innodb;
SHOW CREATE TABLE t_myisam;

#InnoDB
BEGIN;
INSERT INTO t_innodb VALUES(1,'ONE');
ROLLBACK;

SELECT * FROM t_innodb;

#MyISAM
-- MyISAM不支持事务
BEGIN;
INSERT INTO t_myisam VALUES(2,'TWO');
ROLLBACK;

SELECT * FROM t_myisam;

#SAVEPOINT

CREATE TABLE IF NOT EXISTS person(name VARCHAR(15),balance DECIMAL(10,2));

BEGIN;
INSERT INTO person(name,balance) VALUES('ZHANG SAN',3000);
COMMIT;

SELECT * FROM person;

BEGIN;
UPDATE person SET balance = balance -100 WHERE NAME = 'ZHANG SAN'; 
UPDATE person SET balance = balance -100 WHERE NAME = 'ZHANG SAN'; 
SAVEPOINT s1;#设置保存点
UPDATE person SET balance = balance +1000 WHERE NAME = 'ZHANG SAN'; 
ROLLBACK TO s1;#回滚到保存点

SELECT * FROM person;

ROLLBACK;#事务结束

SELECT * FROM person;


#事务的隔离级别

-- 1 脏写
--	对于两个事务A、B，如果事务A修改了另一个未提交事务B修改过的数据，意味着发生了脏写

-- 2 脏读
--	对于两个事务A、B，A读取了已经被B更新但还没有提交的字段。之后若B回滚，A读取的内容就是临时且无效的

-- 3 不可重复读
--	对于两个事务A、B，A读取了一个字段，然后B更新了该字段，之后A再次读取同一字段，值不同了，意味着发生了不可重复读

-- 4 幻读
--	对于两个事务A、B，A从一个表中读取了一个字段，然后B在该表中插入了一些新的行。之后如果A再次读取同一个表，就会多处几行，意味着发生幻读


#SQL的四种隔离级别
-- 问题严重程度：脏写>脏读>不可重复读>幻读

-- READ UNCOMMITTED：读未提交
-- READ COMMITED：   读已提交
-- REPEATABLE TEAD： 可重复读
-- SERIALIZABLE：    可串行化
-- 越向下隔离级别越高，并发性越差

-- 四种隔离级别都解决了`脏写`


#MySQL的四种隔离级别
-- MySQL支持全部四种隔离级别
-- 默认隔离级别：REPETABLE(可重复读)，解决了脏读、不可重复读

-- 查看当前隔离级别
SHOW VARIABLES LIKE 'transaction_isolation';
SELECT @@transaction_isolation;

-- 设置隔离级别

-- 1:
-- SET [GLOBAL|SESSION] TRANSACTION ISOLATION LEVEL 隔离级别;
-- READ UNCOMMITTED
-- READ COMMITTED
-- REPEATABLE READ
-- SERIALIZABLE

-- 2:
-- SET [GLOBAL|SESSION] TRANSACTION_ISOLATION = '隔离级别';
-- READ-UNCOMMITTED
-- READ-COMMITTED
-- REPEATABLE-READ
-- SERIALIZABLE

-- 关于设置时使用GLOBAL或SESSION的影响
-- 1 GLOBAL
-- SET GLOBAL TRANSACTION_ISOLATION = 'SERIALIZABLE';
-- 当前已经存在的会话无效
-- 只对执行完该语句之后产生的会话起作用

-- 2 SESSION
-- SET GLOBAL TRANSACTION_ISOLATION = 'SERIALIZABLE';
-- 对当前会话的所有后续的事务有效
-- 如果在事务之间执行，则对后续事务有效
-- 该语句可以在已经开启的事务中间执行，但不会影响正在执行的事务


