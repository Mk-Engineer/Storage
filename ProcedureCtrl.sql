# 流程控制
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
use dbtest;
-- SELECT * FROM employees;

/* IF */
DROP PROCEDURE IF EXISTS test_if;
DELIMITER //

CREATE PROCEDURE test_if()

BEGIN
    DECLARE stu_name VARCHAR(15);
    DECLARE email VARCHAR(25) DEFAULT 'Abel@126.com';
    DECLARE age INT DEFAULT 20;

    IF stu_name IS NULL
        THEN SELECT 'stu_name is null';
    END IF;    

    IF email IS NULL
        THEN SELECT 'email is null';
    ELSE
        SELECT 'email is not null';
    END IF;        

    IF age > 40
        THEN SELECT 'old';
    ELSEIF age > 18
        THEN SELECT 'young';
    ELSEIF age > 8 
        THEN SELECT 'child';
    ELSE 
        SELECT 'baby';
    END IF;                
END //

DELIMITER ;

CALL test_if();

-- 举例：声明存储过程“update_salary_by_eid”，定义IN参数emp_id，输入员工编号。
--       判断该员工薪资如果低于8000元并且入职时间超过5年，就涨薪500元；否则就不变。

SELECT employee_id,salary,DATEDIFF(CURDATE(),hire_date)/365
FROM employees
WHERE salary < 8000 AND DATEDIFF(CURDATE(),hire_date)/365 >= 5;

DELIMITER //

CREATE PROCEDURE update_salary_by_eid(IN emp_id INT)

BEGIN
      DECLARE emp_sal DOUBLE;
      DECLARE stay_year DOUBLE;/* 年数 */

      SELECT salary INTO emp_sal FROM employees WHERE employee_id = emp_id;   
      SELECT DATEDIFF(CURDATE(),hire_date)/365 INTO stay_year FROM employees WHERE employee_id = emp_id;   

      IF (emp_sal < 8000) AND stay_year >= 5
        THEN UPDATE employees SET salary = salary + 500 WHERE employee_id = emp_id;
      END IF;       
END //

DELIMITER ;

SELECT employee_id,salary FROM employees WHERE employee_id = 104;
CALL update_salary_by_eid(104);
SELECT employee_id,salary FROM employees WHERE employee_id = 104;

/* 还原 */
-- UPDATE employees SET salary = 6000 WHERE employee_id = 104;
-- SELECT employee_id,salary FROM employees WHERE employee_id = 104;
DROP PROCEDURE IF EXISTS update_salary_by_eid;

-- 举例：声明存储过程“update_salary_by_eid”，定义IN参数emp_id，输入员工编号。
--       判断该员工薪资如果低于9000元并且入职时间超过5年，就涨薪500元；否则就涨薪100元。
SELECT employee_id,salary,DATEDIFF(CURDATE(),hire_date)/365
FROM employees
WHERE salary < 9000 AND DATEDIFF(CURDATE(),hire_date)/365 >= 5;
DELIMITER //

CREATE PROCEDURE update_salary_by_eid(IN emp_id INT)

BEGIN
      DECLARE emp_sal DOUBLE;
      DECLARE stay_year DOUBLE;/* 年数 */

      SELECT salary INTO emp_sal FROM employees WHERE employee_id = emp_id;   
      SELECT DATEDIFF(CURDATE(),hire_date)/365 INTO stay_year FROM employees WHERE employee_id = emp_id;   

      IF (emp_sal < 9000) AND stay_year >= 5
        THEN UPDATE employees SET salary = salary + 500 WHERE employee_id = emp_id;
      ELSE
        UPDATE employees SET salary = salary + 100 WHERE employee_id = emp_id;  
      END IF;       
END //

DELIMITER ;

/* CALL 1 */
SELECT employee_id,salary FROM employees WHERE employee_id = 105;
CALL update_salary_by_eid(105);
SELECT employee_id,salary FROM employees WHERE employee_id = 105;

/* CALL 2 */
SELECT employee_id,salary FROM employees WHERE employee_id = 103;
CALL update_salary_by_eid(103);
SELECT employee_id,salary FROM employees WHERE employee_id = 103;

/* 还原 */
-- UPDATE employees SET salary = 4800 WHERE employee_id = 105;
-- SELECT employee_id,salary FROM employees WHERE employee_id = 105;
-- UPDATE employees SET salary = 9000 WHERE employee_id = 103;
-- SELECT employee_id,salary FROM employees WHERE employee_id = 103;
DROP PROCEDURE IF EXISTS update_salary_by_eid;


-- 举例：声明存储过程“update_salary_by_eid”，定义IN参数emp_id，输入员工编号。
--       判断该员工薪资如果低于9000元，就更新薪资为9000元；
--       薪资如果大于等于9000元且低于10000的，但是奖金比例为NULL的，就更新奖金比例为0.01；其他的涨薪100元。
SELECT employee_id,salary,commission_pct
FROM employees
WHERE salary >= 9000 AND salary < 10000;

DELIMITER //

CREATE PROCEDURE update_salary_by_eid(IN emp_id INT)

BEGIN
      DECLARE emp_sal DOUBLE;
      DECLARE bonus DOUBLE;

      SELECT salary INTO emp_sal FROM employees WHERE employee_id = emp_id;   
      SELECT commission_pct INTO bonus FROM employees WHERE employee_id = emp_id;   
      
      -- 条件判断 用 DECLARE 的变量 (bonus)
      -- 判断后的操作 用 COLUMN 的定义字 (commission_pct)
      IF emp_sal < 9000
        THEN UPDATE employees SET salary = 9000 WHERE employee_id = emp_id;
      ELSEIF emp_sal >= 9000 AND emp_sal < 10000 AND bonus IS NULL
        THEN UPDATE employees SET commission_pct = 0.01 WHERE employee_id = emp_id;
      ELSE
        UPDATE employees SET salary = salary + 100 WHERE employee_id = emp_id;  
      END IF;       
END //

DELIMITER ;

/* < 9000 */
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 105;/* 4800 */
CALL update_salary_by_eid(105);
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 105;

/* 9000-10000 */
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 103;
CALL update_salary_by_eid(103);
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 103;

/* others */
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 150;
SELECT employee_id,salary,commission_pct FROM employees WHERE salary >= 10000;
CALL update_salary_by_eid(150);
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 150;
SELECT employee_id,salary,commission_pct FROM employees WHERE salary >= 10000;

/* 复原 */
DROP PROCEDURE IF EXISTS update_salary_by_eid;

SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 105;

SELECT employee_id,salary,commission_pct
FROM employees
WHERE salary >= 9000 AND salary < 10000;

SELECT employee_id,salary,commission_pct FROM employees WHERE salary >= 10000;
-- SELECT employee_id,salary,commission_pct FROM employees;


/* CASE */
DELIMITER //

CREATE PROCEDURE test_case()
BEGIN
    /* 演示1 */
    /* CASE var WHEN val1 THEN action1; WHEN val2 THEN action2; ELSE action; END CASE; */
    -- DECLARE var INT DEFAULT 2;

    -- CASE var
    --     WHEN 1 THEN SELECT 'var = 1';
    --     WHEN 2 THEN SELECT 'var = 2'; 
    --     WHEN 3 THEN SELECT 'var = 3';
    --     ELSE SELECT 'other value';
    -- END CASE;   

    /* 演示2 */
    /* CASE WHEN condition1 THEN action1; WHEN condition2 THEN action2; ELSE action; END CASE; */  
    DECLARE var INT DEFAULT 10;
    CASE
        WHEN var >= 100 THEN SELECT '3 nums';
        WHEN var >= 10 THEN SELECT '2 nums';
        ELSE select '1 nums';
    END CASE;

END //

DELIMITER ;

CALL test_case();
DROP PROCEDURE IF EXISTS test_case;

-- 举例：声明存储过程“update_salary_by_eid”，定义IN参数emp_id，输入员工编号。
--       判断该员工薪资如果低于9000元，就更新薪资为9000元；
--       薪资大于等于9000元且低于10000的，但是奖金比例为NULL的，就更新奖金比例为0.01；其他的涨薪100元。
/* 原始数据 */
SELECT employee_id,salary
FROM employees
WHERE salary < 9000;

SELECT employee_id,salary,commission_pct
FROM employees
WHERE salary >= 9000 AND salary < 10000 AND commission_pct IS NULL;

SELECT employee_id,salary,commission_pct
FROM employees
WHERE salary >= 10000 OR commission_pct IS NOT NULL;

/* 定义存储过程 */
DELIMITER //

CREATE PROCEDURE update_salary_by_eid(IN emp_id INT)
BEGIN
    DECLARE emp_sal DOUBLE;
    DECLARE bonus DOUBLE;

    SELECT salary INTO emp_sal FROM employees WHERE employee_id = emp_id;
    SELECT commission_pct INTO bonus FROM employees WHERE employee_id = emp_id;

    CASE
        WHEN emp_sal < 9000 THEN UPDATE employees SET salary = 9000 WHERE employee_id = emp_id;
        WHEN emp_sal >= 9000 AND emp_sal < 10000 AND bonus IS NULL THEN UPDATE employees SET commission_pct = 0.1 WHERE employee_id = emp_id;
        ELSE UPDATE employees SET salary = salary + 100 WHERE employee_id = emp_id;
    END CASE;
END //

DELIMITER ;

/* < 9000 */
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 105;/* 4800 */
CALL update_salary_by_eid(105);
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 105;

/* 9000-10000 */
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 103;
CALL update_salary_by_eid(103);
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 103;

/* others */
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 150;
-- SELECT employee_id,salary,commission_pct FROM employees WHERE salary >= 10000 OR commission_pct IS NOT NULL;
CALL update_salary_by_eid(150);
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 150;
-- SELECT employee_id,salary,commission_pct FROM employees WHERE salary >= 10000 OR commission_pct IS NOT NULL;

/* 复原 */
DROP PROCEDURE IF EXISTS update_salary_by_eid;

-- 举例：声明存储过程update_salary_by_eid，定义IN参数emp_id，输入员工编号。
--      判断该员工的入职年限，如果是0年，薪资涨50；如果是1年，薪资涨100；
--      如果是2年，薪资涨200；如果是3年，薪资涨300；如果是4年，薪资涨400；其他的涨薪500。
/* 原始数据 */
SELECT employee_id,salary,ROUND(DATEDIFF(CURDATE(),hire_date)/365)
FROM employees
ORDER BY ROUND(DATEDIFF(CURDATE(),hire_date)/365) DESC;

/* 创建存储过程 */
DELIMITER //

CREATE PROCEDURE update_salary_by_eid(IN emp_id INT)
BEGIN
    DECLARE stay_year DOUBLE;
    SELECT ROUND(DATEDIFF(CURDATE(),hire_date)/365) INTO stay_year FROM employees WHERE employee_id = emp_id;

    CASE stay_year
        WHEN 24 THEN UPDATE employees SET salary = salary + 50 WHERE employee_id = emp_id;
        WHEN 25 THEN UPDATE employees SET salary = salary + 100 WHERE employee_id = emp_id;
        WHEN 26 THEN UPDATE employees SET salary = salary + 200 WHERE employee_id = emp_id;
        WHEN 27 THEN UPDATE employees SET salary = salary + 300 WHERE employee_id = emp_id;
        WHEN 28 THEN UPDATE employees SET salary = salary + 400 WHERE employee_id = emp_id;
        ELSE UPDATE employees SET salary = salary + 500 WHERE employee_id = emp_id;
    END CASE;
END //

DELIMITER ;

CALL update_salary_by_eid(199);/* 24-2600 */
CALL update_salary_by_eid(197);/* 25-3000 */
CALL update_salary_by_eid(202);/* 26-6000 */
CALL update_salary_by_eid(193);/* 27-3900 */
CALL update_salary_by_eid(201);/* 28-13000 */
CALL update_salary_by_eid(100);/* 36-24000 */

SELECT employee_id,salary,ROUND(DATEDIFF(CURDATE(),hire_date)/365)
FROM employees
ORDER BY ROUND(DATEDIFF(CURDATE(),hire_date)/365) DESC;

/* 复原 */
DROP PROCEDURE IF EXISTS update_salary_by_eid;
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql