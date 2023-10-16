# 流程控制
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
use dbtest;
SELECT * FROM employees;

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
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
SELECT employee_id,salary,commission_pct FROM employees WHERE employee_id = 105;

SELECT employee_id,salary,commission_pct
FROM employees
WHERE salary >= 9000 AND salary < 10000;

SELECT employee_id,salary,commission_pct FROM employees WHERE salary >= 10000;
-- SELECT employee_id,salary,commission_pct FROM employees;