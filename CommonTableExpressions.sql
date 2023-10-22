# 公用表达式
use dbtest;
/* 普通公用表达式 */
-- 查询员工所在部门的详细信息
SELECT * FROM departments
WHERE department_id IN (
                        SELECT DISTINCT department_id
                        FROM employees
                        );

/* CTE实现 */
/* 封装子查询 */
WITH cte_emp
AS (SELECT DISTINCT department_id FROM employees)

SELECT * FROM departments d JOIN cte_emp e
ON d.department_id = e.department_id;

/* 递归公用表达式 */
-- 案例：针对于我们常用的employees表，包含employee_id，last_name和manager_id三个字段。
--      如果a是b的管理者，那么，我们可以把b叫做a的下属，如果同时b又是c的管理者，那么c就是b的下属，是a的下下属。
--      下面我们尝试用查询语句列出所有具有下下属身份的人员信息。
WITH RECURSIVE cte_rec
AS
(
/* 种子查询，找到第一代领导 */
SELECT employee_id,last_name,manager_id,1 AS n 
FROM employees 
WHERE employee_id = 100

UNION All

/* 递归查询，找出以 递归公用表达式的人 为领导的人 */
SELECT a.employee_id,a.last_name,a.manager_id,n+1 
FROM employees 
AS a JOIN cte_rec ON (a.manager_id = cte_rec.employee_id) 
)

SELECT employee_id,last_name FROM cte_rec WHERE n >= 3;