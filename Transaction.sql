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
