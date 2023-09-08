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
# 26.1 单行子查询
/* 符号：= >= <= > < <> */
SELECT last_name,salary
FROM employees
WHERE salary > (
                SELECT salary
                FROM employees
                WHERE last_name = 'Abel'
                );

/* 外查询(主查询) / 内查询(子查询) */         
/* 
    - 子查询在主查询之前一次执行完成
    - 子查询的结果被主查询使用

    注意：
        - 子查询要包含在括号内
        - 将子查询放在比较条件的右侧
        - 单行操作符对应单行子查询，多行操作符对应多行子查询
*/       
/* 
    #子查询的分类
        角度1：从内查询返回结果的条目数  -> 单行子查询/多行子查询
        角度2：内查询是否被执行多次      -> 相关子查询/不相关子查询 
               WHERE a > (
                          b
                         );
               a 和 b 相关 / 不相关
*/



# 26.2 多行子查询
/* 符号：IN ANY ALL SOME */
/* IN */
/* 题目：求所有管理者的姓名 */
SELECT last_name
FROM employees
WHERE employee_id IN (
                    SELECT manager_id
                    FROM employees
                    );    

/* 空值问题 */
-- SELECT last_name
-- FROM employees
-- WHERE employee_id NOT IN (
--                     SELECT manager_id /* 存在NULL值，会造成无查询结果 */
--                     FROM employees
--                     ); 

/* 题目：求所有非管理者的姓名 */
SELECT last_name
FROM employees
WHERE employee_id NOT IN (
                    SELECT manager_id
                    FROM employees
                    WHERE manager_id IS NOT NULL
                    );    

/* ANY / ALL */
SELECT salary
FROM employees
WHERE job_id = 'IT_PROG';

/* 题目：返回其他job_id中比job_id为‘IT_PROG’部门 任一 工资低的员工的员工号、姓名、job_id以及salary */
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ANY (
                SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG'
                );

/* 题目：返回其他job_id中比job_id为‘IT_PROG’部门 所有 工资低的员工的员工号、姓名、job_id以及salary */                
SELECT employee_id,last_name,job_id,salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ALL (
                SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG'
                );

/* 题目：查询平均工资最低的部门id */
/* 方式1 */
-- 1
SELECT department_id,AVG(salary) "avg_sal"
FROM employees
GROUP BY department_id;

-- 2
SELECT MIN(avg_sal)
FROM (
    SELECT department_id,AVG(salary) "avg_sal"
    FROM employees
    GROUP BY department_id
    )t_dept_avg_sal; /* ERROR 1248 (42000): Every derived table must have its own alias */ /* FROM 后的表要有确切名字 */

-- 3
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
                    SELECT MIN(avg_sal)
                    FROM (
                        SELECT department_id,AVG(salary) "avg_sal"
                        FROM employees
                        GROUP BY department_id
                        )t_dept_avg_sal
                    );    

/* 方式2 */   
-- 优化                 
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= ALL (
                            SELECT AVG(salary) "avg_sal"
                            FROM employees
                            GROUP BY department_id
                            );

/* 注意：单行函数可以嵌套，聚合函数不可以嵌套使用 */

 
                