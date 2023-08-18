# 基本的SELECT语句
/* 多行注释（块注释）：' Alt+Shift+A ' */
# 1.SQL的分类
/*
DDL:数据定义语言
    CREATE \ ALTER \ DROP \ RENAME \ TRUNCATE 

DML:数据操作语言
    INSERT \ DELETE \ UPDATE \ SELECT

DCL:数据控制语言
    COMMIT \ ROLLBACK \ SAVEPOINT \ GRANT \ REVOKE

*/
USE dbtest;

SELECT * FROM employees;

/*INSERT INTO employees VALUES(1003,'Jack');*/


# 2. 列的别名
# SELECT 列1 列的别名1,列2 AS 列的别名2,列3 "列的别名3" FROM 表;

# 2.1 去重的情况
# SELECT DISTINCT 列 FROM 表;


# 3. 空值(null)参与运算
# 结果也为 null


# 4. 着重号 ``
# SELECT * FROM `关键字`


# 5. 查询常数
# SELECT 常数,列 FROM 表


# 6. 显示表结构
DESCRIBE employees; /* 显示表中 字段 的 详细信息 */
DESC employees;


# 7. 过滤数据
SELECT *
FROM employees
WHERE id = 1003;


# 8. 算数运算符
SELECT 100, 100 + 0, 100 - 0, 100 + 50, 100 + 50 * 30, 100 + 35.5, 100 - 35.5
FROM DUAL; /* DUAL是伪表 */

SELECT 100 + '1'
FROM DUAL;

SELECT 100 + 'a'
FROM DUAL;

SELECT 100 + NULL
FROM DUAL;

SELECT 100, 100 * 1, 100 * 1.0, 100 / 1.0, 100 / 2, 100 + 2 * 5 / 2, 100 / 3, 100 DIV 0
FROM DUAL; /* 默认除法的结果都是浮点型 */

SELECT 12 % 3, 12 % 5, 12 MOD -5, -12 % 5, -12 % -5
FROM DUAL; /* 结果的正负号只与 % 前的数字有关 */

SELECT name
FROM employees
WHERE id % 2 = 0;


# 9. 比较运算符
# 9.1 符号比较
# 等于 =
SELECT 1 = 2, 1 != 2, 1 = '1', 1 = 'a', 0 = 'a' /* 字符串存在隐式转换，如果转换数值不成功，则看作0 */
FROM DUAL;

SELECT 'a' = 'a', 'ab' = 'ab', 'a' = 'b' /* 纯粹字符串比较，是按照ANSI编码进行比较 */
FROM DUAL;

SELECT 1 = NULL, NULL = NULL /* 只要有NULL参与判断，结果就为NULL */
FROM DUAL;

SELECT id, name
FROM employees
WHERE name = NULL; /* 此时执行不会有任何结果，即便存在name = NULL的数据条目 */


# 安全等于 <=>
SELECT 1 <=> 2, 1 <=> '1', 1 <=> 'a', 0 <=> 'a' /* 在NULL不参与运算的情况下，效果和 = 是一样的 */
FROM DUAL;

SELECT 1 <=> NULL, NULL <=> NULL /* 此时 NULL <=> NULL 为 1，<=> 主要用于 NULL 参与的运算 */
FROM DUAL;

SELECT id, name
FROM employees
WHERE name <=> NULL;


# 安全不等于<>
SELECT 3 <> 2,1 <> NULL ,'4' <> NULL, '' != NULL, NULL != NULL, NULL <> NULL /* 只要有NULL参与判断，结果就为NULL */
FROM DUAL;


# 9.2 关键字比较
#IS NULL \ IS NOT NULL \ ISNULL()
SELECT id, name
FROM employees
WHERE name IS NULL; 

/* 判断表中name不为NULL的2种方法 */
SELECT id, name
FROM employees
WHERE name IS NOT NULL; 

SELECT id, name
FROM employees
WHERE NOT name <=> NULL; 

SELECT id, name
FROM employees
WHERE ISNULL(name); 


#LEAST() \ GREATEST()
SELECT LEAST('g','b','t','m'),GREATEST('g','b','t','m')
FROM DUAL;


#BETWEEN 条件1 AND 条件2
SELECT id, name
FROM employees
WHERE id BETWEEN 1002 AND 1003;
/*WHERE id >= 1002 && id <= 1003*/
/* 查询条件1和条件2范围内的数据，包含边界 */
/* 条件1必须是下限，条件2必须是上界，不能交换 */

SELECT id, name
FROM employees
WHERE id NOT BETWEEN 1002 AND 1003;
/*WHERE id < 1002 OR id > 1003*/


#IN \ NOT IN
SELECT id, name
FROM employees
WHERE id IN (1001,1002,1003);
/*WHERE id = 10 OR id = 20 OR id = 30;*/

SELECT id, name
FROM employees
WHERE id NOT IN (1002,1003);


#LIKE 模糊查询
SELECT name
FROM employees
WHERE name LIKE '%J%'; /* % 代表不确定个数的字符(0个或多个) */

SELECT name
FROM employees
WHERE name LIKE 'J%'; /* 查询以字符'J'开头的name */

SELECT name
FROM employees
WHERE name LIKE '%e%' AND name LIKE '%r%';
/*WHERE name LIKE '%a%e%' OR name LIKE '%e%a%'*/

SELECT name
FROM employees
WHERE name LIKE '_e%';

SELECT name
FROM employees
WHERE name LIKE '_\_e%';/* 转义字符 \ */
/*WHERE name LIKE '_$_e%' ESCAPE '$';*/


#REGEXP \ RLIKE 正则表达式
/*
(1)''匹配以该字符后面的字符开头的字符串。
(2)'$'匹配以该字符前面的字符结尾的字符串。
(3)''匹配任何一个单字符。
(4)“[...]"匹配在方括号内的任何字符。例如，“[abc]"匹配“a”或“b”或“c”。为了命名字符的范围，使用一个''。“[a- z]"匹配任何字母，而“[0-9]"匹配任何数字。
(5)'*'匹配零个或多个在它前面的字符。例如，“x*"匹配任何数量的'x'字符， “[0-9]*"匹配任何数量的数字，而“*”匹配任何数量的任何字符。
*/
SELECT 'shkstart' REGEXP '^s', 'shkstart' REGEXP 't$', 'shkstart' REGEXP 'hk'
FROM DUAL;

SELECT 'atguigu' REGEXP 'gu.gu', 'atguigu' REGEXP 'gu', 'atguigu' REGEXP '[ab]'
FROM DUAL;


# 10. 逻辑运算符 'OR ||' / 'AND &&' / 'NOT !' / 'XOR'
/* 注意：AND 的优先级 高于 OR */
/* 异或 XOR ：
    两侧的true false一致，结果为true
    两侧的true false不一致，结果为false    
*/
SELECT id, name
FROM employees
WHERE id < 1008 XOR name LIKE '%e%';



# 11. 位运算符
/*
    &   按位与
    |   按位或
    ^   按位异或
    ~   按位取反
    >>  按位右移
    <<  按位左移
*/ 

# 12. 排序与分页
# 12.1 排序
/* 默认是按照 添加顺序 显示的 */
/* SELECT * FROM employees; */

/* 
ORDER BY
ASC  (ascend)  升序
DESC (descend) 降序
*/

SELECT id,name 
FROM employees
ORDER BY id DESC;/* 默认以ASC排序 */

/* 使用列的别名，进行排序 */
SELECT id,name,id * 10 pid
FROM employees
ORDER BY pid;

/* 注意：列的别名只能在 ORDER BY 中使用，不能在 WHERE 中使用 */

SELECT id,name
FROM employees
WHERE id IN(1003,1004,1005) /* WHERE 必须声明在 FROM 之后，ORDER BY 之前 */
ORDER BY id DESC;

# 12.2 二级排序
/* 只有一级排序数值相同，才会触发二级排序 */
/* 按照id降序排列，name升序排列 */
SELECT id,name 
FROM employees
ORDER BY name ASC, id DESC;

# 12.3 分页 LIMIT
/* LIMIT 偏移量，每页条数 */
/* LIMIT 条目数 */
/* 每页显示3条记录，此时显示第1页 */
SELECT id, name
FROM employees
ORDER BY id
LIMIT 0,3;

/* 每页显示3条记录，此时显示第2页 */
SELECT id, name
FROM employees
ORDER BY id
LIMIT 3,3;

/* 公式：LIMIT (pageNum - 1) * pageSize, pageSize*/

# 12.4 \ WHERE \ ORDER BY \ LIMIT \ 的声明顺序
SELECT id, name
FROM employees
WHERE id > 1003
ORDER BY id
LIMIT 0,5;
/* 注意：LIMIT 必须放在整个SELECT语句的最后 */

/* MySQL8.0新特性 */
SELECT id, name
FROM employees
WHERE id > 1003
ORDER BY id
LIMIT 5 OFFSET 0;
/* LIMIT 条目数 OFFSET 偏移量 */