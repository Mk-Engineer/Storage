# 触发器
use dbtest;

CREATE TABLE IF NOT EXISTS  test_trigger (
id INT PRIMARY KEY AUTO_INCREMENT,
t_note VARCHAR(30)
);


CREATE TABLE IF NOT EXISTS test_trigger_log (
id INT PRIMARY KEY AUTO_INCREMENT,
t_log VARCHAR(30)
);

-- 创建触发器：创建名称为before_insert_test_tri的触发器，向test_trigger数据表插入数据之前，
--            向test_trigger_log数据表中插入before_insert的日志信息。
DELIMITER //

CREATE TRIGGER before_insert_test_tri
BEFORE INSERT ON test_trigger
FOR EACH ROW
BEGIN
    INSERT INTO test_trigger_log(t_log)
    VALUES('before insert');
END //

DELIMITER ;

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

INSERT INTO test_trigger(t_note)
VALUES('Tom');

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

TRUNCATE TABLE test_trigger;
TRUNCATE TABLE test_trigger_log;


-- 创建名称为after_insert_test_tri的触发器，向test_trigger数据表插入数据之后，
-- 向test_trigger_log数据表中插入after_insert的日志信息。
DELIMITER //

CREATE TRIGGER after_insert_test_tri
AFTER INSERT ON test_trigger
FOR EACH ROW
BEGIN
    INSERT INTO test_trigger_log(t_log)
    VALUES('after insert');
END //

DELIMITER ;

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

INSERT INTO test_trigger(t_note)
VALUES('Jerry');

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

TRUNCATE TABLE test_trigger;
TRUNCATE TABLE test_trigger_log;


-- 定义触发器“salary_check_trigger”，基于员工表“employees”的INSERT事件，
-- 在INSERT之前检查将要添加的新员工薪资是否大于他领导的薪资，
-- 如果大于领导薪资，则报sqlstate_value为'HY000'的错误，从而使得添加失败。
CREATE TABLE IF NOT EXISTS employees_copy
AS
SELECT * FROM dbtest.`employees`; 

-- CREATE TABLE departments_copy
-- AS
-- SELECT * FROM dbtest.`departments`; 

DELIMITER //

CREATE TRIGGER salary_check_trigger
BEFORE INSERT ON employees_copy
FOR EACH ROW
BEGIN
    DECLARE mgr_sal DOUBLE;

    SELECT salary INTO mgr_sal FROM employees WHERE employee_id = NEW.manager_id;

    IF NEW.salary > mgr_sal
        THEN SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = 'Salary > Mgr Salary !';
    END IF;    
END //

DELIMITER ;
INSERT INTO employees_copy(employee_id,last_name,email,hire_date,job_id,salary,manager_id)
VALUES(300,'Tom','tom@126.com',CURDATE(),'AD_VP',8000,103);

SELECT * FROM employees_copy;

INSERT INTO employees_copy(employee_id,last_name,email,hire_date,job_id,salary,manager_id)
VALUES(301,'Jerry','jerry@126.com',CURDATE(),'AD_VP',10000,103);

SELECT * FROM employees_copy;

DELETE FROM employees_copy WHERE employee_id = 300;
SELECT * FROM employees_copy;

DROP TABLE employees_copy;


/* 查看触发器 */
-- 查看当前数据库的所有触发器
SHOW TRIGGERS\G

/* 查看当前数据库中某个触发器的定义 */
SHOW CREATE TRIGGER  before_insert_test_tri\G

/* 从系统库information_schema的TRIGGERS表中查看 */
SELECT * FROM information_schema.TRIGGERS\G

/* 删除触发器 */
DROP TRIGGER before_insert_test_tri;
DROP TRIGGER after_insert_test_tri;
SELECT * FROM information_schema.TRIGGERS\G
