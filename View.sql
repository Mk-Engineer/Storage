/* 视图 */
-- I.  对视图中的数据进行增加、删除和修改操作时，数据基表中的数据会相应地发生变化
-- II. 视图的本质：存储起来的的SELECT语句

USE dbtest;

/* 创建视图 */
-- 针对单表
/* I. 视图中的字段与基表中的字段存在一对一的关系 */
CREATE VIEW vw_emp
AS
SELECT employee_id,last_name,salary
FROM employees; 

SELECT * FROM vw_emp;
DROP VIEW IF EXISTS vw_emp;

/* 查询语句中字段的别名会作为视图中的字段出现 */
/* 方式1 */
CREATE VIEW vw_emp
AS
SELECT employee_id emp_id,last_name `name`,salary
FROM employees
WHERE salary > 8000;

SELECT * FROM vw_emp;
DROP VIEW IF EXISTS vw_emp;

/* 方式2 */
CREATE VIEW vw_emp(id,`name`,sal)/* ( )内的 别名 个数要与 SELECT中的 字段 个数相同 */
AS
SELECT employee_id,last_name,salary
FROM employees
WHERE salary > 8000;

SELECT * FROM vw_emp;
DROP VIEW IF EXISTS vw_emp;

/* II. 视图中的字段在基表中可能没有对应的字段 */
CREATE VIEW vw_dept_sal
AS
SELECT department_id,AVG(salary) avg_sal
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

SELECT * FROM vw_dept_sal;
DROP VIEW IF EXISTS vw_dept_sal;


-- 针对多表
CREATE VIEW vw_emp_dept
AS
SELECT e.employee_id,e.department_id,d.department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

SELECT * FROM vw_emp_dept;
DROP VIEW IF EXISTS vw_emp_dept;

/* 利用视图对数据进行格式化 */
CREATE VIEW vw_emp_dept
AS
SELECT CONCAT(e.last_name,'(',d.department_name,')') emp_info
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;
/* 不必再频繁操作SELECT，直接调用vw_emp_dept */

SELECT * FROM vw_emp_dept;
DROP VIEW IF EXISTS vw_emp_dept;

/* 基于视图创建视图 */
CREATE OR REPLACE VIEW vw_emp
AS
SELECT employee_id,last_name,salary
FROM employees; 

CREATE VIEW vw_emp_copy
AS
SELECT employee_id,last_name
FROM vw_emp;

SELECT * FROM vw_emp;
SELECT * FROM vw_emp_copy;
DROP VIEW IF EXISTS vw_emp_copy;
-- DROP VIEW IF EXISTS vw_emp;

/* 查看视图 */
-- 语法1：查看数据的表对象、视图对象
SHOW TABLES;
-- 语法2：查看视图的结构
DESCRIBE vw_emp;
-- 语法3：查看视图的属性信息
SHOW TABLE STATUS LIKE 'vw_emp';
SHOW TABLE STATUS LIKE 'vw_emp'\G;
-- 语法4：查看视图的详细定义信息
SHOW CREATE VIEW vw_emp;
SHOW CREATE VIEW vw_emp\G;

/* 增删改视图数据 */
/* 更新视图 */
SELECT * FROM vw_emp;

SELECT employee_id,last_name,salary
FROM employees;

/* 更新视图中的数据，会导致基表中的数据改变 */
UPDATE vw_emp
SET salary = 20000
WHERE employee_id = 101;/* salary = 17000 */

SELECT * FROM vw_emp;

SELECT employee_id,last_name,salary
FROM employees;

/* 更新基表中的数据，会导致视图中的数据改变 */
UPDATE employees
SET salary = 17000
WHERE employee_id = 101;

SELECT employee_id,last_name,salary
FROM employees;

SELECT * FROM vw_emp;

/* 视图数据 更新失败 的情况 */
/* 要视图可更新，视图中的行和基表中的行必须存在一对一的关系 */
-- UPDATE vw_dept_sal
-- SET avg_sal = 5000 /* 基表中不存在 avg_sal COLUMN */
-- WHERE department_id = 30;

/* 修改视图 */
DESC vw_emp;

-- 方式1
CREATE OR REPLACE VIEW vw_emp
AS
SELECT employee_id,last_name,salary,email
FROM employees
WHERE salary > 7000;

SELECT * FROM vw_emp;

-- 方式2
ALTER VIEW vw_emp
AS
SELECT employee_id,last_name,salary,email,hire_date
FROM employees;

SELECT * FROM vw_emp;

/* 删除视图 */
-- 基于视图a视图b创建了新的视图c，
-- 如果将视图a或者视图b删除，会导致视图c的查询失败。
-- 这样视图c需要手动删除或修改，否则影响使用。
SHOW TABLES;
DROP VIEW IF EXISTS vw_emp;
SHOW TABLES;

/* 视图的缺点 */
-- 如果我们在实际数据表的基础上创建了视图，如果实际数据表的结构变更了，我们就需要及时对相关的视图进行相应的维护。
-- 特别是嵌套的视图（就是在视图的基础上创建视图），维护会变得比较复杂，可读性不好，容易变成系统的潜在隐患。
-- 因为创建视图的 SQL 查询可能会对字段重命名，也可能包含复杂的逻辑，这些都会增加维护的成本。