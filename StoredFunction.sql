/* 存储函数 */
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