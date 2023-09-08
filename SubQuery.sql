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