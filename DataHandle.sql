# 数据处理-增删改
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

SELECT * FROM emp;