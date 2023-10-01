# 数据处理-增删改
/* DDL(创建数据库、创建表) */
/* DML(增删改查)*/
USE dbtest;

CREATE TABLE IF NOT EXISTS emp(
id INT,
`name` VARCHAR(15),
hire_date DATE,
salary DOUBLE(10,2)
);

DESC emp;

TRUNCATE TABLE emp;

# 1.添加数据
/* 方式1：逐条添加 */
/* I.没有指明添加字段 */
INSERT INTO emp
VALUES(1,'Tom','2000-12-21',3400);

/* II.指明添加的字段 */
INSERT INTO emp(id,hire_date,salary,`name`)
VALUES(2,'1999-09-09',4000,'Jerry');

/* III.同时插入多条记录 */
INSERT INTO emp(id,`name`,salary)
VALUES
(3,'Jim',5000),
(4,'ZhangJin',5500);


/* 方式2：将查询结果插入表中 */
/* I */
INSERT INTO emp(id,`name`,salary,hire_date)
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE department_id IN (50,60);
/* II */
INSERT INTO emp(id,`name`,salary,hire_date)
SELECT 5,'Mike',3500,'1997-09-09' UNION ALL
SELECT 6,'Mark',6500,'1993-12-05';

SELECT * FROM emp;

# 2.更新数据
SHOW TABLES;

UPDATE emp
SET hire_date = CURDATE()
WHERE id = 4;


/* 同时修改一条数据的多个字段 */
UPDATE emp
SET hire_date = CURDATE(),salary = 6000
WHERE id = 3;

/* 将表中姓名中包含字符a的提薪 20% */
UPDATE emp
SET salary = salary * 1.2
WHERE name LIKE '%a%';

/* 修改不成功: 由于约束的影响造成的 */
-- UPDATE employees
-- SELECT department_id = 10000
-- WHERE employee_id = 102;


# 3.删除数据
DELETE FROM emp
WHERE id = 1;

/* 删除失败: 由于约束的影响造成的 */
-- DELETE FROM departments
-- WHERE department_id = 50;

SELECT * FROM emp;

/* 小结：DML操作默认情况下，执行完以后都会自动commit */
/*      如果希望执行完后不自动提交数据，需要使用 SET autocommit = FALSE */

# 4. MySQL8新特性：计算列
/* 某一列的值是通过别的列的计算得来的 */
USE dbtest
CREATE TABLE IF NOT EXISTS test(
a INT,
b INT,
c INT GENERATED ALWAYS AS (a + b) VIRTUAL   
);

TRUNCATE TABLE test;

INSERT INTO test(a,b)
VALUES (10,20);

SELECT * FROM test;

UPDATE test
SET a = 100;

SELECT * FROM test;

SHOW TABLES;

# 5.综合案例
/* 1 创建数据库test_library */
CREATE DATABASE IF NOT EXISTS test_library CHARACTER SET 'utf8';
USE test_library;

SHOW DATABASES;

/* 2 创建表 books， 表结构如下： */
CREATE TABLE IF NOT EXISTS books(
id INT,
`name` VARCHAR(50),
`authors` VARCHAR(100),
price FLOAT,
pubdate YEAR,
note VARCHAR(100),
num INT    
);

DESC books;

SHOW TABLES;

/* 3 向books表中插入记录 */
/*   1) 不指定字段名称，插入第一条记录 */
TRUNCATE TABLE books;

INSERT INTO books
VALUES(1,'Tal of AAA','Dickes',23,'1995','novel',11);
/*   2) 指定所有字段名称，插入第二条记录 */
INSERT INTO books(id,`name`,`authors`,price,pubdate,note,num)
VALUES(2,'EmmaT','Jane lura',35,'1993','joke',22);
/*   3) 同时插入多条记录 (剩下的所有记录) */
INSERT INTO books(id,`name`,`authors`,price,pubdate,note,num)
VALUES
(3,'Story of Jane','Jane Tim',40,'2001','novel',0),
(4,'Lovey Day','George Byron',20,'2005','novel',30),
(5,'Old land','Honore Blade',30,'2010','law',0),
(6,'The Battle','Upton Sara',30,'1999','medicine',40),
(7,'Rose Hood','Richard haggard',28,'2008','cartoon',28);

SELECT * FROM books;
/* 4 将小说类型(novel)的书的价格都增加15 */
UPDATE books
SET price = price + 15
WHERE note = 'novel';

SELECT * FROM books;
/* 5 将名称为EmmaT的书的价格改为40，并将说明改为drama */
UPDATE books
SET price = 40,note = 'drama'
WHERE `name` = 'EmmaT';

SELECT * FROM books;

/* 6 删除库存为0的记录 */
-- DELETE FROM books
-- WHERE num = 0;

SELECT * FROM books;

/* 7 统计书名中包含 a 字母的书 */
SELECT NAME 
FROM books
WHERE `name` LIKE '%a%';

/* 8 统计书名中包含a字母的书的数量和库存总量 */
SELECT COUNT(*),SUM(num)
FROM books
WHERE `name` LIKE '%a%';

/* 9 找出‘novel’类型的书，并按照价格降序排列 */
SELECT `name`,note,price
FROM books
WHERE note = 'novel'
ORDER BY price DESC;

/* 10 查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列 */
SELECT *
FROM books
ORDER BY num DESC,note ASC;

/* 11 按照note分类统计数的数量 */
SELECT note,COUNT(*)
FROM books
GROUP BY note;

/* 12 按照note分类统计数的库存量，显示库存量超过30本的 */
SELECT note,SUM(num)
FROM books
GROUP BY note
HAVING SUM(num) > 30;

/* 13 查询所有图书，每页显示5本，显示第2页 */
SELECT *
FROM books
LIMIT 5,5;

/* 14 按照note分类统计书的库存量，显示库存量最多的 */
SELECT note,SUM(num) sum_num
FROM books
GROUP BY note
ORDER BY sum_num DESC
LIMIT 0,1;

/* 15 查询书名达到6个字符的书，不包括里面的空格 */
SELECT *
FROM books
WHERE CHAR_LENGTH(REPLACE(`name`,' ','')) >= 6;

/* 16 查询书名和类型，其中note值为novel显示小说，law显示法律，medicine显示医药，cartoon显示卡通，joke显示笑话 */
SELECT `name`,note,CASE note WHEN 'novel' THEN 'XIAO SHUO'
                             WHEN 'law' THEN 'FA LV'
                             WHEN 'medicine' THEN 'YI YAO'
                             WHEN 'cartoon' THEN 'KA TONG'
                             WHEN 'joke' THEN 'XIAO HUA'
                             ELSE 'OTHERS'
                             END "type"
FROM books;

/* 17 查询书名、库存，其中num值超过30本，显示滞销，大于0并低于10的，显示畅销，为0的显示需要无货 */
SELECT `name`,num,CASE WHEN num > 30 THEN 'ZHI XIAO'
                       WHEN num > 0 AND num < 10 THEN 'CHANG XIAO'
                       WHEN num = 0 THEN 'WU HUO'
                       ELSE 'NORMAL'
                       END "sales"
FROM books;

/* 18 统计每一种note的库存量，并合计总量 */
SELECT IFNULL(note,'SUM') AS note,SUM(num)
FROM books
GROUP BY note WITH ROLLUP;

/* 19 统计每一种note的数量，并合计总量 */
SELECT IFNULL(note,'SUM') AS note,COUNT(*)
FROM books
GROUP BY note WITH ROLLUP;

/* 20 统计库存量前三名的图书 */
SELECT * 
FROM books
ORDER BY num DESC
LIMIT 0,3;

/* 21 找出最早出版的一本书 */
SELECT *
FROM books
ORDER BY pubdate
LIMIT 0,1;

/* 22 找出novel中价格最高的一本书 */
SELECT *
FROM books
WHERE note = 'novel'
ORDER BY price DESC
LIMIT 0,1;

/* 23 找出书名字中字数最多的一本书，不包含空格 */
SELECT *
FROM books
ORDER BY CHAR_LENGTH(REPLACE(`name`,' ','')) DESC
LIMIT 0,1;