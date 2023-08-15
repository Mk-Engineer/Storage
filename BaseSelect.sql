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