# 26 子查询
/* 需求：查询谁的工资比Abel高 */
/* 方式1：*/
SELECT salary
FROM employees
WHERE last_name = 'Abel';

SELECT last_name,salary
FROM employees
WHERE salary > 11000;

/* 方式2：自连接 */
SELECT e2.last_name,e2.salary
FROM employees e1,employees e2
WHERE e2.`salary` > e1.`salary` /* 多表的连接条件 */
AND e1.last_name = 'Abel';

/* 方式3：子查询 */
SELECT last_name,salary
FROM employees
WHERE salary > (
                SELECT salary
                FROM employees
                WHERE last_name = 'Abel'
                );