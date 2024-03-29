# 20 流程控制函数

#IF(VALUE,VALUE1,VALUE2)
/* VALUE为TRUE输出VALUE1,VALUE为FALSE输出VALUE2 */
SELECT last_name,salary,IF(salary >= 6000,'High Salary','Low Salary')
FROM employees;

SELECT last_name,commission_pct,IF(commission_pct IS NOT NULL,commission_pct,0) "details",
salary * 12 * (1 + IF(commission_pct IS NOT NULL,commission_pct,0)) "annual_sal"
FROM employees;


#IFNULL(VALUE1,VALUE2)
/* VALUE1为NULL输出VALUE2,否则输出VALUE1 */
SELECT last_name,commission_pct,IFNULL(commission_pct,0) "details"
FROM employees;


#CASE WHEN .. THEN .. WHEN .. THEN .. ELSE .. END
SELECT last_name,salary,CASE WHEN salary >= 15000 THEN 'A'
                             WHEN salary >= 10000 THEN 'B'
                             WHEN salary >= 8000 THEN 'C'
                             ELSE 'D' END "details"
FROM employees;                             

SELECT last_name,salary,CASE WHEN salary >= 15000 THEN 'A'
                             WHEN salary >= 10000 THEN 'B'
                             WHEN salary >= 8000 THEN 'C'
                             END "details"
FROM employees;  


#CASE 表达式 WHEN .. THEN .. WHEN .. THEN .. ELSE .. END
/* 
#练习1
查询部门号为10，20，30的员工信息，若部门号为10，则打印其工资的1.1倍。
                                    20号部门，则打印其工资的1.2倍。
                                    30号部门，则打印其工资的1.3倍
                                    其他部门，则打印其工资的1.4倍。

#练习2
查询部门号为10，20，30的员工信息，若部门号为10，则打印其工资的1.1倍。
                                    20号部门，则打印其工资的1.2倍。
                                    30号部门，则打印其工资的1.3倍。
*/
SELECT employee_id,last_name,department_id,salary,
CASE department_id WHEN 10 THEN salary * 1.1
                   WHEN 20 THEN salary * 1.2
                   WHEN 30 THEN salary * 1.3
                   ELSE salary * 1.4 END "details"
FROM employees;                   

SELECT employee_id,last_name,department_id,salary,
CASE department_id WHEN 10 THEN salary * 1.1
                   WHEN 20 THEN salary * 1.2
                   WHEN 30 THEN salary * 1.3
                   END "details"
FROM employees
WHERE department_id IN(10,20,30);



# 21 加密与解密
/* SELECT PASSWORD('mysql') */ /* 在MySQL8.0中被弃用 */
SELECT MD5('mysql'),SHA('mysql')
FROM DUAL;

/* SELECT ENCODE('password','key') */
/* SELECT DECODE(ENCODE('password','key'),'key') */
/* 在MySQL8.0中被弃用 */



# 22 MySQL信息函数
SELECT VERSION(),CONNECTION_ID(),DATABASE(),SCHEMA(),USER(),CURRENT_USER(),CHARSET('English'),COLLATION('English')
FROM DUAL;



# 23 其他函数
/* FORMAT(value,n)：对数字value进行格式化，n表示四舍五入后保留到小数点后n位，当n <= 0时，只保留整数部分。 */
SELECT FORMAT(3.1415926,5),
FROM DUAL;

/* CONV(value,from,to)：将value从from进制转化为to进制 */
SELECT CONV(16,10,2), CONV(8888,10,16), CONV(NULL,10,2)
FROM DUAL;

SELECT INET_ATON('192.168.1.100'),INET_NTOA(3232235876)
FROM DUAL;

/* BENCHMARK(n,表达式)：将表达式重复执行n次，用于测试MySQL处理表示所耗费的时间 */
SELECT BENCHMARK(100000,MD5('mysql'))
FROM DUAL;

SELECT CHARSET('English'),CHARSET(CONVERT('English' USING 'utf8mb4'))
FROM DUAL;


/*
#练习
    查询公司各员工工作的年数、工作的天数，并按工作年数降序排列
*/
SELECT employee_id,DATEDIFF(CURDATE(),hire_date) / 365 "worked_years",DATEDIFF(CURDATE(),hire_date) "worked_days"
FROM employees
ORDER BY worked_years DESC;



# 24 聚合函数

#24.1 常见的聚合函数
/* AVG/SUM */
/* 适用于数值类型，不计算NULL值 */
SELECT AVG(salary),SUM(salary),AVG(salary) * COUNT(salary)/* AVG = SUM x COUNT */
FROM employees;

/* MAX/MIN */
/* 适用于数值类型、字符串类型、日期时间类型，不计算NULL值 */
SELECT MAX(salary),MIN(salary)
FROM employees;

SELECT MAX(last_name),MIN(last_name)
FROM employees;

SELECT MAX(hire_date),MIN(hire_date)
FROM employees;

/* COUNT */
/* 计算指定字段在查询结构中出现的个数，不计算NULL值 */
SELECT COUNT(employee_id),COUNT(salary),COUNT(commission_pct),COUNT(1)/* COUNT(1)：用 1 来充当每条数据。计算表中有多少条记录，column不确定时，可以用此方法代替。 */
FROM employees;

SELECT AVG(commission_pct),SUM(commission_pct)/COUNT(commission_pct),SUM(commission_pct)/107
FROM employees;

/* #需求：查询公司中的平均奖金率 */
/* 错误的 */
SELECT AVG(commission_pct)
FROM employees;

/* 正确的 */
SELECT SUM(commission_pct) / COUNT(IFNULL(commission_pct,0)), AVG(IFNULL(commission_pct,0))
FROM employees;

/* 
    #统计表中的记录数
        1.COUNT(*)
        2.COUNT(1)
        3.COUMT(具体字段)
        
        Q:哪种效率更高?

        A:如果使用MyISAM存储引擎，则三者效率相同，都是O(1)
          如果使用InnoDB存储引擎，则COUNT(*) = COUNT(1) > COUNT(具体字段)
*/



#24.2 GROUP BY 的使用
/* #需求：查询各个部门的平均工资，最高工资 */
SELECT department_id,AVG(salary),MAX(salary)
FROM employees
GROUP BY department_id;

/* #需求：查询各个department_id、job_id的平均工资 */
SELECT department_id, job_id, AVG(salary)
FROM employees
GROUP BY department_id,job_id;

/* 错误 */
-- SELECT department_id, job_id, AVG(salary)
-- FROM employees
-- GROUP BY department_id;
/* 结论1：SELECT中出现的非组函数的字段必须声明在GROUP BY中，GROUP BY中声明的字段可以不出现在SELECT中。 */
/* 结论2：GROUP BY 声明在FROM后面、WHERE后面，ORDER BY前面，LIMIT前面 */
/* 结论3：GOURP BY 中使用 WITH ROLLUP，会将所有的组再次看成一个组，算一个最终的总平均值*/
SELECT department_id,AVG(salary)
FROM employees
GROUP BY department_id WITH ROLLUP;/* WITH ROLLUP 不能与 ORDER BY 同时使用 */



#24.3 HAVING 的使用
/* 用来过滤数据 */
/* #练习：查询各个部门中最高工资比10000高的部门信息 */
SELECT department_id,MAX(salary)
FROM employees
/* WHERE MAX(salary) > 10000 */
GROUP BY department_id
HAVING MAX(salary) > 10000;

/* 要求1：如果过滤条件中使用了聚合函数，则必须使用 HAVING 来替换 WHERE */
/* 要求2：HAVING 必须声明在 GROUP BY 的后面 */
/* 要求3：开发中使用 HAVING 的前提是SQL中使用了 GROUP BY */

/* #练习：查询部门id为10、20、30、40中最高工资比10000高的部门信息 */
-- 方式一：
SELECT department_id,MAX(salary)
FROM employees
WHERE department_id IN(10,20,30,40)
GROUP BY department_id
HAVING MAX(salary) > 10000;
/* 推荐：使用方式一，方式一的执行效率高于方式二 */

-- 方式二：
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000 AND department_id IN(10,20,30,40);

/* 结论1：当过滤条件中有聚合函数时，此过滤条件必须声明在HAVING中 */
/* 结论2：当过滤条件中无聚合函数时，此过滤条件声明在WHERE和HAVING中均可，但建议声明在HAVING中 */

/* 
    # WHERE 与 HAVING 对比
        1.HAVING适用范围更广
        2.如果过滤条件中无聚合函数，此时WHERE的效率更高 
*/

#25 SQL底层执行原理

#25.1 SELECT 语句的完整结构
/* 
    #sql92语法
        SELECT .., .., .. (存在聚合函数)
        FROM .., .., ..
        WHERE 多表连接条件 AND 不含聚合函数的过滤条件
        GROUP BY .., ..
        HAVING 含聚合函数的过滤条件
        ORDER BY .., ..(ASC/DESC)
        LIMIT .., ..
    
    #sql99语法   
        SELECT .., .., .. (存在聚合函数)
        FROM .. (LEFT / RIGHT) JOIN.. ON 多表的连接条件
        WHERE 不含聚合函数的过滤条件
        GROUP BY .., ..
        HAVING 含聚合函数的过滤条件
        ORDER BY .., ..(ASC/DESC)
        LIMIT .., ..
*/



#25.2 SQL 语句的执行过程
/*
    #sql99语法   
        SELECT .., .., .. (存在聚合函数)                [5]

        FROM .. (LEFT / RIGHT) JOIN.. ON 多表的连接条件 [1]
        WHERE 不含聚合函数的过滤条件                     [2]
        GROUP BY .., ..                                [3]
        HAVING 含聚合函数的过滤条件                      [4]

        ORDER BY .., ..(ASC/DESC)                      [6]
        LIMIT .., ..                                   [7]
*/
/* 注意：SELECT 中起的别名，只能在 [6]、[7] 中使用 */