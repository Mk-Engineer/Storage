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


/* 循环结构 */
-- 循环结构的4要素：
-- 1. 初始化条件
-- 2. 循环条件
-- 3. 循环体
-- 4. 迭代条件

/* LOOP */
DELIMITER //

CREATE PROCEDURE test_loop()
BEGIN
    DECLARE num INT DEFAULT 1;

    loop_label:LOOP
                SET num = num + 1;
                IF num >= 10 THEN LEAVE loop_label;
                END IF;
    END LOOP loop_label;

    SELECT num;
END //

DELIMITER ;

CALL test_loop();

DROP PROCEDURE test_loop;

-- 举例：当市场环境变好时，公司为了奖励大家，决定给大家涨工资。
--       声明存储过程“update_salary_loop()”，声明OUT参数num，输出循环次数。
--       存储过程中实现循环给大家涨薪，薪资涨为原来的1.1倍。直到全公司的平均薪资达到12000结束。并统计循环次数。
SELECT AVG(salary) FROM employees;

DELIMITER //

CREATE PROCEDURE update_salary_loop(OUT num INT)
BEGIN
    DECLARE avg_sal DOUBLE;
    DECLARE count INT DEFAULT 0;

    /* 初始化条件 */
    SELECT AVG(salary) INTO avg_sal FROM employees;

    loop_label:LOOP
                /* (结束)循环条件 */
                IF avg_sal >= 12000 /* 先判断！ */
                    THEN LEAVE loop_label;/* 如果循环中添加了循环控制语句（LEAVE或ITERATE）则必须添加名称 */
                END IF;

                /* 循环体 */
                UPDATE employees SET salary = salary * 1.1;
                /* 迭代条件 */
                SELECT AVG(salary) INTO avg_sal FROM employees;/* 注意：更新 avg_sal ！ */

                SET count = count + 1;
    END LOOP loop_label;

    SET num = count;/* 防止num传入的初始值不是0 */
END //

DELIMITER ;

SET @result = 0;
CALL update_salary_loop(@result);
SELECT @result;

DROP PROCEDURE update_salary_loop;

SELECT AVG(salary) FROM employees;

/* 复原 */
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
SELECT AVG(salary) FROM employees;


/* WHILE */
DELIMITER //

CREATE PROCEDURE test_while()
BEGIN
    DECLARE num INT DEFAULT 1;

    WHILE num <= 10 DO 
        SELECT 'WHILE RUNNING';
        SET num = num + 1;
    END WHILE;    
END //

DELIMITER ;

CALL test_while();
DROP PROCEDURE test_while;

-- 举例：市场环境不好时，公司为了渡过难关，决定暂时降低大家的薪资。
--       声明存储过程“update_salary_while()”，声明OUT参数num，输出循环次数。
--       存储过程中实现循环给大家降薪，薪资降为原来的90%。直到全公司的平均薪资达到5000结束。并统计循环次数。
DELIMITER //

CREATE PROCEDURE update_salary_while(OUT num INT)
BEGIN
    DECLARE count INT DEFAULT 0;
    DECLARE avg_sal DOUBLE;

    SELECT AVG(salary) INTO avg_sal FROM employees;

    WHILE avg_sal >= 5000 DO 
        UPDATE employees SET salary = salary * 0.9;
        SELECT AVG(salary) INTO avg_sal FROM employees;
        SET count = count + 1;
    END WHILE;    

    SET num = COUNT;
END //

DELIMITER ;

SELECT AVG(salary) FROM employees;

SET @result = 0;
CALL update_salary_while(@result);
SELECT @result;

SELECT AVG(salary) FROM employees;
DROP PROCEDURE update_salary_while;

/* 复原 */
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
SELECT AVG(salary) FROM employees;


/* REPEAT */
DELIMITER //

CREATE PROCEDURE test_repeat()
BEGIN
    DECLARE num INT DEFAULT 1;

    REPEAT
        SET num = num + 1;
        SELECT 'REPEAT RUNNING';
        UNTIL num >= 5/* UNTIL后无 `;` */
    END REPEAT;    

END //

DELIMITER ;

CALL test_repeat();
DROP PROCEDURE test_repeat;

-- 举例：当市场环境变好时，公司为了奖励大家，决定给大家涨工资。
--       声明存储过程“update_salary_repeat()”，声明OUT参数num，输出循环次数。
--       存储过程中实现循环给大家涨薪，薪资涨为原来的1.15倍。直到全公司的平均薪资达到13000结束。并统计循环次数。

DELIMITER //

CREATE PROCEDURE update_salary_repeat(OUT num INT)
BEGIN
    DECLARE count INT DEFAULT 0;
    DECLARE avg_sal DOUBLE;

    SELECT AVG(salary) INTO avg_sal FROM employees;

    REPEAT 
        UPDATE employees SET salary = salary * 1.15;
        SELECT AVG(salary) INTO avg_sal FROM employees;
        SET count = count + 1;
        UNTIL avg_sal >= 13000
    END REPEAT;    

    SET num = count;
END //

DELIMITER ;

SELECT AVG(salary) FROM employees;

SET @result = 0;
CALL update_salary_repeat(@result);
SELECT @result;

SELECT AVG(salary) FROM employees;
DROP PROCEDURE update_salary_repeat;

/* 复原 */
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
SELECT AVG(salary) FROM employees;


/* 对比三种循环结构： */

-- 1：这三种循环都可以省略名称，但如果循环中添加了循环控制语句（LEAVE或ITERATE）则必须添加名称。
-- 2：
-- LOOP：一般用于实现简单的"死"循环
-- WHILE：先判断后执行
-- REPEAT：先执行后判断，无条件至少执行一次


/* LEAVE */
/* break */
-- 除循环结构外，在BEGIN-END结构中也可以使用 LEAVE / ITERATE
-- 如果循环中添加了循环控制语句（LEAVE或ITERATE）则必须添加名称

-- 举例：创建存储过程 “leave_begin()”，声明INT类型的IN参数num。
--      给BEGIN...END加标记名，并在BEGIN...END中使用IF语句判断num参数的值。
--      如果num<=0，则使用LEAVE语句退出BEGIN...END；
--      如果num=1，则查询“employees”表的平均薪资；
--      如果num=2，则查询“employees”表的最低薪资；
--      如果num>2，则查询“employees”表的最高薪资。
--      IF语句结束后查询“employees”表的总人数。

DELIMITER //

CREATE PROCEDURE leave_begin(IN num INT)
begin_label:BEGIN
    IF num <= 0 
        THEN LEAVE begin_label;
    ELSEIF num = 1
        THEN SELECT AVG(salary) FROM employees;
    ELSEIF num = 2        
        THEN SELECT MIN(salary) FROM employees;
    ELSE        
        SELECT MAX(salary) FROM employees;
    END IF;

    SELECT COUNT(*) FROM employees;        

END //

DELIMITER ;

CALL leave_begin(0);
CALL leave_begin(1);
CALL leave_begin(2);
CALL leave_begin(3);

DROP PROCEDURE leave_begin;

-- 举例：当市场环境不好时，公司为了渡过难关，决定暂时降低大家的薪资。
--      声明存储过程“leave_while()”，声明OUT参数num，输出循环次数，
--      存储过程中使用WHILE循环给大家降低薪资为原来薪资的90%，直到全公司的平均薪资小于等于10000，并统计循环次数。
DELIMITER //

CREATE PROCEDURE leave_while(OUT num INT)
BEGIN
    DECLARE avg_sal DOUBLE;
    DECLARE count INT DEFAULT 0;
    SELECT AVG(salary) INTO avg_sal FROM employees;

    while_label:WHILE TRUE
                DO
                    IF avg_sal <= 5000/* 10000 */ 
                        THEN LEAVE while_label;
                    END IF;

                    UPDATE employees SET salary = salary * 0.9;
                    SELECT AVG(salary) INTO avg_sal FROM employees;
                    SET count = count + 1;
                END WHILE;

    SET num = count; 

END //

DELIMITER ;

SELECT AVG(salary) FROM employees;

SET @result = 0;
CALL leave_while(@result);
SELECT @result;

SELECT AVG(salary) FROM employees;
DROP PROCEDURE leave_while;

/* 复原 */
SOURCE C:\Users\User\Documents\Storage\MutiTable.sql
SELECT AVG(salary) FROM employees;


/* ITERATE */
/* continue */
-- 举例：定义局部变量num，初始值为0。循环结构中执行num + 1操作。
--      如果num < 10，则继续执行循环；
--      如果num > 15，则退出循环结构；
DELIMITER //

CREATE PROCEDURE test_iterate()
BEGIN
    DECLARE num INT DEFAULT 0;
    loop_label:LOOP
                    SET num = num + 1;
                    IF num < 10
                        THEN ITERATE loop_label;
                    END IF;
                    
                    IF num > 15
                        THEN LEAVE loop_label;
                    END IF;
                END LOOP;

    SELECT num;            
END //

DELIMITER ;

CALL test_iterate();
DROP PROCEDURE test_iterate;


/* CURSOR */
-- 创建存储过程“get_count_by_limit_total_salary()”，声明IN参数 limit_total_salary，DOUBLE类型；声明OUT参数total_count，INT类型。
-- 函数的功能可以实现累加薪资最高的几个员工的薪资值，直到薪资总和达到limit_total_salary参数的值，返回累加的人数给total_count。
DELIMITER //

CREATE PROCEDURE get_count_by_limit_total_salary(IN limit_total_salary DOUBLE,OUT total_count INT)

BEGIN
    DECLARE sum_sal DOUBLE DEFAULT 0;
    DECLARE cur_sal DOUBLE DEFAULT 0;
    DECLARE emp_count INT DEFAULT 0;

    /* 定义游标 */
    /* 游标声明 需要在 变量声明 的 后面 */
    DECLARE emp_cursor CURSOR FOR SELECT salary FROM employees ORDER BY salary DESC;
    /* 打开游标 */
    OPEN emp_cursor;

    REPEAT
        /* 使用游标 */
        FETCH emp_cursor INTO cur_sal;/* INTO 前后变量的数量要 逐一对应 */

        SET sum_sal = sum_sal + cur_sal;
        SET emp_count = emp_count + 1;

        UNTIL sum_sal >= limit_total_salary
    END REPEAT;

    SET total_count = emp_count;

    /* 关闭游标 */
    CLOSE emp_cursor;   

    SELECT 'My Cursor Running'; 
     
END //

DELIMITER ;

SET @limit = 50000;
SET @count;

CALL get_count_by_limit_total_salary(@limit,@count);

SELECT @count;
SELECT salary FROM employees ORDER BY salary DESC;

DROP PROCEDURE get_count_by_limit_total_salary;