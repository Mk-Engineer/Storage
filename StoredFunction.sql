# 存储函数
USE dbtest;
-- SET GLOBAL log_bin_trust_function_creators = 1;/* 代替DETERMINISTIC */

-- 举例1：创建存储函数，名称为email_by_name()，参数定义为空，该函数查询Abel的email，并返回，数据类型为字符串型。
DELIMITER //

CREATE FUNCTION email_by_name()
RETURNS VARCHAR(25)
    DETERMINISTIC
    CONTAINS SQL
    READS SQL DATA
BEGIN
    RETURN (SELECT email FROM employees WHERE last_name = 'Abel');
END //

DELIMITER ;

SELECT email_by_name();

-- 举例2：创建存储函数，名称为email_by_id()，参数传入emp_id，该函数查询emp_id的email，并返回，数据类型为字符串型。
DELIMITER //

CREATE FUNCTION email_by_id(emp_id INT)
RETURNS VARCHAR(25)
    DETERMINISTIC
    CONTAINS SQL
    READS SQL DATA
BEGIN
    RETURN (SELECT email FROM employees WHERE employee_id = emp_id);
END //

DELIMITER ;

SELECT email_by_id(100);

SET @emp_id = 102; /* SET @emp_id := 102 */
SELECT email_by_id(@emp_id);

-- 举例3：创建存储函数count_by_id()，参数传入dept_id，该函数查询dept_id部门的员工人数，并返回，数据类型为整型。
DELIMITER //

CREATE FUNCTION count_by_id(dept_id INT)
RETURNS INT
    DETERMINISTIC
    CONTAINS SQL
    READS SQL DATA
BEGIN
    RETURN (SELECT COUNT(*) FROM employees WHERE department_id = dept_id);
END //

DELIMITER ;

SET @dept_id = 30; /* SET @dept_id := 30 */
SELECT count_by_id(@dept_id);


# 存储过程和函数的查看、修改、删除
/* 创建 */
/* I.查看 存储过程、存储函数的 创建信息 */
-- SHOW CREATE PROCEDURE show_mgr_name;
-- SHOW CREATE FUNCTION count_by_id;
SHOW CREATE PROCEDURE show_mgr_name\G;
SHOW CREATE FUNCTION count_by_id\G;

/* II.查看 存储过程、存储函数的 状态信息 */
-- SHOW PROCEDURE STATUS;/* 全部信息 */
-- SHOW PROCEDURE STATUS LIKE 'show_max_salary';
SHOW PROCEDURE STATUS LIKE 'show_max_salary'\G;
-- SHOW FUNCTION STATUS LIKE 'email_by_id';
SHOW FUNCTION STATUS LIKE 'email_by_id'\G;

/* III.从information_schema.Routines表中查看存储过程和函数的信息 */
-- SELECT * FROM information_schema.Routines
-- WHERE ROUTINE_NAME='email_by_id' AND ROUTINE_TYPE = 'FUNCTION';
SELECT * FROM information_schema.Routines
WHERE ROUTINE_NAME='email_by_id' AND ROUTINE_TYPE = 'FUNCTION'\G;/* AND ROUTINE_TYPE = 'FUNCTION' :用于 存储过程 和 存储函数 重名 */


/* 修改 */
-- 只修改相关的特性: [characteristic]
SHOW PROCEDURE STATUS LIKE 'show_max_salary'\G;

ALTER PROCEDURE show_max_salary
SQL SECURITY INVOKER
COMMENT 'Query Max Salary';

SHOW PROCEDURE STATUS LIKE 'show_max_salary'\G;

/* 删除 */
DROP FUNCTION IF EXISTS count_by_id;
DROP PROCEDURE IF EXISTS show_min_salary;