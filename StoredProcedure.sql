/* 存储过程 */
USE dbtest;

/* 创建存储过程 */
/* I.无参数，无返回值 */
-- 举例1：创建存储过程select_all_data(),查看employees表的所有数据
/* 分隔符 */
DELIMITER $

CREATE PROCEDURE select_all_data()
BEGIN
    SELECT * FROM employees;
END $

DELIMITER ;

/* 存储过程的调用 */
CALL select_all_data();

-- 举例2：创建存储过程avg_employee_salary()，返回所有员工的平均工资
DELIMITER //

CREATE PROCEDURE avg_employee_salary()
BEGIN
    SELECT AVG(salary) FROM employees;
END //

DELIMITER ;

CALL avg_employee_salary();

-- 举例3：创建存储过程show_max_salary(),用来查看“employees”的最高薪资
DELIMITER //

CREATE PROCEDURE show_max_salary()
BEGIN
    SELECT MAX(salary) FROM employees;
END //

DELIMITER ;

CALL show_max_salary();

/* II. 参数OUT */
-- 举例4：创建存储过程show_min_salary()，查看“emps”表的最低薪资值。并将最低薪资通过OUT参数“ms”输出
DESC employees;/* salary DOUBLE(8,2) */

DELIMITER //

CREATE PROCEDURE show_min_salary(OUT ms DOUBLE)
BEGIN
    SELECT MIN(salary) INTO ms
    FROM employees;
END //

DELIMITER ;

CALL show_min_salary(@ms);

SELECT @ms;

/* III. 参数IN */
-- 举例5：创建存储过程show_someone_salary()，查看“emps”表的某个员工的薪资，并用IN参数empname输入员工姓名。
DELIMITER //

CREATE PROCEDURE show_someone_salary(IN empname VARCHAR(20))
BEGIN
    SELECT salary FROM employees
    WHERE last_name = empname;
END //

DELIMITER ;

/* 方式1 */
CALL show_someone_salary('Abel');
/* 方式2 */
SET @empname = 'Abel';/* @empname := 'Abel' */
CALL show_someone_salary(@empname);

/* IV. 参数 IN 和 OUT */
-- 举例6：创建存储过程show_someone_sal()，查看“emps”表的某个员工的薪资，并用IN参数empname输入员工姓名，用OUT参数empsalary输出员工薪资。
DELIMITER //

CREATE PROCEDURE show_someone_sal(IN empname VARCHAR(20),OUT empsalary DECIMAL(10,2))
BEGIN
    SELECT salary INTO empsalary
    FROM employees
    WHERE last_name = empname;
END //

DELIMITER ;

SET @empname = 'Abel';/* @empname := 'Abel' */
CALL show_someone_sal(@empname,@empsalary);

SELECT @empsalary;

/* V. 参数INOUT */
-- 举例7：创建存储过程show_mgr_name()，查询某个员工领导的姓名，并用INOUT参数“empname”输入员工姓名，输出领导的姓名。
DELIMITER //

CREATE PROCEDURE show_mgr_name(INOUT empname VARCHAR(25))
BEGIN
    SELECT last_name INTO empname
    FROM employees
    WHERE employee_id = (
                        SELECT manager_id
                        FROM employees
                        WHERE last_name = empname 
                        );
END //

DELIMITER ;

SET @empname = 'Abel';/* @empname := 'Abel' */
CALL show_mgr_name(@empname);

SELECT @empname;