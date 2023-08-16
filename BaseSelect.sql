# 基本的SELECT语句

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
