#Join语句的原理
USE dbtest;

CREATE TABLE a(f1 INT,f2 INT,INDEX(f1))ENGINE=INNODB;
CREATE TABLE b(f1 INT,f2 INT)ENGINE=INNODB;

INSERT INTO a VALUES(1,1),(2,2),(3,3),(4,4),(5,5),(6,6);
INSERT INTO b VALUES(3,3),(4,4),(5,5),(6,6),(7,7),(8,8);

EXPLAIN SELECT * FROM a LEFT JOIN b ON(a.f1=b.f1) WHERE(a.f2=b.f2);

EXPLAIN SELECT * FROM a LEFT JOIN b ON(a.f1=b.f1) AND (a.f2=b.f2);

EXPLAIN SELECT * FROM a JOIN b ON(a.f1=b.f1) WHERE(a.f2=b.f2);


-- SIMPLE NESTED-LOOP JOIN 简单循环嵌套连接
-- 全表扫描

-- INDEX NESTED-LOOP JOIN 索引嵌套循环连接
-- 减少内层表数据的遍历次数i

-- BLOCK NESTED-LOOP JOIN 块嵌套循环连接
-- 减少内层表的加载次数

-- HASH JOIN (MySQL8.0)

