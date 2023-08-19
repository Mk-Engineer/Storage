# 13 多表查询
SELECT 'COMMENT #1'
FROM DUAL;

SELECT * FROM employees;

/*
笛卡尔积错误产生的条件：
    省略多表连接的条件，或连接条件无效
    为避免，可以通过WHERE加入有效的连接条件
*/

/* 注意：从SQL 优化 的角度，建议在多表查询时，每个字段前都指明其所在的表 */
SELECT employee_id,department_name,employees.department_id /* 注意：如果查询语句中出现了多个表中都存在的字段，必须指明该字段所在的表 */
FROM employees,departments
/* 两个表连接的条件 */
WHERE employees.`department_id` = departments.`department_id`;

/* 对表起别名，在SELECT和WHERE中使用表的别名 */
SELECT emp.employee_id,dept.department_name,emp.department_id 
FROM employees emp,departments dept
WHERE emp.`department_id` = dept.`department_id`;/* 注意：如果给表起了别名，以但在SELECT或WHERE使用表明的话，必须使用表的别名，不能再使用表的原名 */

/* 如果有N个表实现多表查询，则需要(至少)有N-1个连接条件，连接符为 AND*/
SELECT employee_id,last_name,department_name,city
FROM employees e,departments d,locations l
WHERE e.`department_id` = d.`department_id` AND d.`location_id` = l.`location_id`;

# 14 多表查询的分类
/*
    1：等值连接 vs 非等值连接
    2：自连接 vs 非自连接
    3：内连接 vs 外连接
*/

# 14.1 等值连接 vs 非等值连接
/* 非等值连接 */
SELECT * 
FROM job_grades;

SELECT last_name,salary,grade_level
FROM employees e,job_grades j
WHERE e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`;

# 14.2 自连接 vs 非自连接
/* 自连接 */
SELECT emp.employee_id,emp.last_name,mgr.employee_id,mgr.last_name
FROM employees emp,employees mgr
WHERE emp.`manager_id` = mgr.`employee_id`;

/* 验证 */
SELECT * 
FROM employees
WHERE last_name = 'Mavris';

SELECT * 
FROM employees
WHERE employee_id = 101; #'Kochhar'

# 14.3 内连接 vs 外连接
/* 内连接： 结果集中只包含了 左右表 中 满足连接条件 的数据，其他数据均舍弃 */
SELECT employee_id,department_name
FROM employees e,departments d  /*其他数据：有的员工没部门，有的部门没员工*/
WHERE e.`department_id` = d.`department_id`;

/* 外连接：结果集中除了包含 左右表 中 满足连接条件 的数据之外，还查询到了左表 或 右表中 不匹配 的行*/
/* 外连接分类：左外连接、右外连接、满外连接 */

/* 练习：查询所有员工的last_name,department_name信息 */
/* SQL92语法实现内连接 */
SELECT last_name,department_name
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`;
/* SQL92语法实现外连接：使用 + */
/* MySQL 不支持SQL92的外连接写法 */
/* WHERE e.`department_id` = d.`department_id`(+); */ 
/* WHERE e.`department_id`(+) = d.`department_id`; */

/* SQL99语法实现内连接：使用 JOIN ON */
SELECT last_name,department_name/*,city*/
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;
/*JOIN locations l
ON d.`location_id` = l.`location_id`;*/

/* SQL99语法实现外连接：使用 JOIN ON */
/* 左外连接 */
SELECT last_name,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* 右外连接 */
SELECT last_name,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* 满外连接 */
SELECT last_name,department_name
FROM employees e JOIN departments d /*见：#6 满外连接 line136 */
/* FROM employees e FULL JOIN departments d */ /* MySQL 不支持SQL99 FULL JOIN 的满外连接的语法 */
ON e.`department_id` = d.`department_id`;

/* UNION 合并查询结果 */
/* UNION ALL 合并查询结果,交集重复计算一次 */
/* UNION ALL 效率更高，推荐使用 */
/* UNION 会执行去重的操作，UNION ALL 不会执行去重的操作 */

# 15 七种 JOIN 的实现
/* #1 内连接 */
SELECT employee_id,department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

/* #2 左外连接 */
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* #3 右外连接 */
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* #4 左外连接，去掉交集 */
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL;

/* #5 右外连接，去掉交集 */
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

/* #6 满外连接 */
/* 方式一：左外连接 UNION ALL 右外连接，去掉交集*/
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`

UNION ALL

SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

/* 方式二：右外连接 UNION ALL 左外连接，去掉交集*/
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`

UNION ALL

SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL;

/* #7 满外连接,去掉交集 */
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL

UNION ALL

SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;


# 16 SQL99 新特性 NATURAL JOIN
SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
AND e.`manager_id` = d.`manager_id`;

/* 等价 */

SELECT employee_id,last_name,department_name
FROM employees e NATURAL JOIN departments d;


# 17 SQL99 新特性 USING
SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
USING (department_id);/* 注意：不适用于自连接, USING()内必须填写同名的字段 */

/* 可以查看employees表的所有Field */

/* 注意：起别名用 "name" 符号修饰 */
SELECT emp.last_name "employees",emp.employee_id "Emp#",mgr.last_name "manager",mgr.employee_id "Mgr#"
FROM employees emp LEFT JOIN employees mgr /* FROM 后的别名吗，不能用 "name" 符号修饰 */
ON emp.manager_id = mgr.employee_id;

DESC employees;
DESC departments;
DESC locations;

/* 练习：查询哪些城市没有部门 */
SELECT d.department_name,l.city
FROM departments d RIGHT JOIN locations l
ON l.`location_id` = d.`location_id`
WHERE d.department_id IS NULL; /* 存在NULL 的集合是较小集合 */

/* 练习：查询哪些部门没有员工 */
SELECT d.department_name,e.employee_id
FROM departments d LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`department_id` IS NULL;