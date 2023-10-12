# 变量
USE dbtest;
-- 系统变量：全局系统变量、会话系统变量
-- 用户变量：会话用户变量、局部变量

/* # 系统变量 */
/* 查看系统变量 */
-- SHOW GLOBAL VARIABLES;
-- SHOW SESSION VARIABLES;
-- SHOW VARIABLES;/* 默认查询SESSION系统变量 */

/* 查询部分变量 */
SHOW GLOBAL VARIABLES LIKE 'admin_%';

/* 查询指定系统变量 */
SELECT @@global.max_connections;
SELECT @@global.character_set_client;

SELECT @@session.character_set_client;
SELECT @@session.pseudo_thread_id;

/* 修改系统变量的值 */
/* 方式1：修改配置文件my.ini，修改后需要重启MySQL服务 */
/* 方式2：在MySQL运行期间修改，只针对当前数据库实例时有效的，重启后变量失效，恢复默认值 */
-- I.
SET @@global.max_connections=161;
SELECT @@global.max_connections;

-- II.
SET GLOBAL max_connections=151;
SELECT @@global.max_connections;


/* 修改会话系统变量的值 */
/* 针对当前会话是有效的，一旦结束会话，重新建立起新的会话，变量失效恢复默认值 */
-- I.
SET @@session.character_set_client = 'utf8mb4';
SELECT @@session.character_set_client;

-- II.
SET SESSION character_set_client = 'gbk';
SELECT @@session.character_set_client;


/* # 用户变量 */
-- 会话用户变量：使用`@`开头，作用域为当前会话，只对`当前连接`会话有效。
-- 局部变量：只在 BEGIN 和 END 语句块中有效。局部变量只能在`存储过程和函数`中使用。

/* 会话用户变量 */
/* I.变量声明、赋值 */
-- 方式1：“=”或“:=”
-- SET @用户变量 = 值;
-- SET @用户变量 := 值;
SET @m1 = 1;
SET @m2 := 2;
SET @sum := @m1 + @m2;

SELECT @sum;

-- 方式2：“:=” 或 INTO关键字
-- SELECT @用户变量 := 表达式 [FROM 等子句];
-- SELECT 表达式 INTO @用户变量  [FROM 等子句];
SELECT @count := COUNT(*) FROM employees;
SELECT @count;

SELECT AVG(salary) INTO @avg_sal FROM employees;
SELECT @avg_sal;

/* II.变量使用 */
-- SELECT @用户变量;


/* 局部变量 */
-- 使用DECLARE声明
-- 只能放在 BEGIN-END 中，而且只能放在`首行`

/* I.声明 */
-- DECLARE 变量名 类型 [default 值]; /* 如果没有DEFAULT子句，初始值为NULL */

/* II.赋值 */
-- 方式1
-- SET 变量名=值;
-- SET 变量名:=值;

-- 方式2
-- SELECT 字段名或表达式 INTO 变量名 FROM 表;

/* III.使用 */
-- SELECT 局部变量名;
DELIMITER //

CREATE PROCEDURE test_var()
BEGIN
    /* 声明 */
    DECLARE a INT DEFAULT 0;
    DECLARE b INT;
    -- DECLARE a,b INT DEFAULT 0;/* 合并声明 */
    DECLARE emp_name VARCHAR(25);

    /* 赋值 */
    SET a = 1;
    SET b := 2;

    SELECT last_name INTO emp_name FROM employees WHERE employee_id = 101;

    /* 使用 */
    SELECT a,b,emp_name;

END //

DELIMITER ;

CALL test_var();