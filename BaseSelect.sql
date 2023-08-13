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

# SELECT 列 FROM 表;

USE dbtest;

SELECT * FROM employees;

INSERT INTO employees VALUES(1003,'Jack');