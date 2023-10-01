# 数据处理-增删改
/* DML(增删改查)*/
USE dbtest;

CREATE TABLE IF NOT EXISTS emp(
id INT,
`name` VARCHAR(15),
hire_date DATE,
salary DOUBLE(10,2)
);

DESC emp;


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
INSERT INTO emp(id,`name`,salary,hire_date)
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE department_id IN (50,60);


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
CREATE TABLE test(
a INT,
b INT,
c INT GENERATED ALWAYS AS (a + b) VIRTUAL   
);

INSERT INTO test(a,b)
VALUES (10,20);

SELECT * FROM test;

UPDATE test
SET a = 100;

SELECT * FROM test;

SHOW TABLES;

