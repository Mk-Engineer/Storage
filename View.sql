/* 视图 */
-- I.  对视图中的数据进行增加、删除和修改操作时，数据基表中的数据会相应地发生变化
-- II. 视图的本质：存储起来的的SELECT语句

USE dbtest;

/* 创建视图 */
-- 针对单表
/* I. 视图中的字段与基表中的字段一一对应 */
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
CREATE VIEW vw_emp
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

DROP VIEW IF EXISTS vw_emp;
SHOW TABLES;