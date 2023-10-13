# 程序出错的处理机制
USE dbtest;
/* 定义条件和处理程序 */
# 案例1解决
DROP PROCEDURE IF EXISTS UpdateDataNoCondition;
DELIMITER //

CREATE PROCEDURE UpdateDataNoCondition()
	BEGIN
        /* 声明处理程序 */
        -- 方式1
        DECLARE CONTINUE HANDLER FOR 1048 SET@prc_value = -1;
        -- 方式2
        -- DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET@prc_value = -1;

		SET @x = 1;
		UPDATE employees SET email = NULL WHERE last_name = 'Abel';
		SET @x = 2;
		UPDATE employees SET email = 'aabbel' WHERE last_name = 'Abel';
		SET @x = 3;
	END //

DELIMITER ;

CALL UpdateDataNoCondition();
SELECT @x,@prc_value;/* 根据`@x`的值判断语句执行到了哪一条 */

/* 定义条件 */
-- 举例1：定义“Field_Not_Be_Null”错误名与MySQL中违反非空约束的错误类型
--       对应：ERROR 1048 (23000)

/* 方式1：使用MySQL_error_code */
-- DECLARE Field_Not_Be_Null CONDITION FOR 1048;
/* 方式2：使用sqlstate_value */
-- DECLARE Field_Not_Be_Null CONDITION FOR SQLSTATE '23000';


-- 举例2：定义"ERROR 1148(42000)"错误，名称为command_not_allowed

/* 方式1：使用MySQL_error_code */
-- DECLARE command_not_allowed CONDITION FOR 1148;
/* 方式2：使用sqlstate_value */
-- DECLARE command_not_allowed CONDITION FOR SQLSTATE '42000';


/* 定义处理程序 */
-- 格式：DECLARE 处理方式 HANDLER FOR 错误类型 处理语句

/* 方法1：捕获sqlstate_value */
-- DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @info = 'NO_SUCH_TABLE';

/* 方法2：捕获mysql_error_value */
-- DECLARE CONTINUE HANDLER FOR 1146 SET @info = 'NO_SUCH_TABLE';

/* 方法3：先定义条件，再调用 */
-- DECLARE no_such_table CONDITION FOR 1146;
-- DECLARE CONTINUE HANDLER FOR NO_SUCH_TABLE SET @info = 'NO_SUCH_TABLE';

/* 方法4：使用SQLWARNING */
-- DECLARE EXIT HANDLER FOR SQLWARNING SET @info = 'ERROR';

/* 方法5：使用NOT FOUND */
-- DECLARE EXIT HANDLER FOR NOT FOUND SET @info = 'NO_SUCH_TABLE';

/* 方法6：使用SQLEXCEPTION */
-- DECLARE EXIT HANDLER FOR SQLEXCEPTION SET @info = 'ERROR';

# 案例2解决
DROP PROCEDURE IF EXISTS InsertDataWithCondition;

DELIMITER //

CREATE PROCEDURE InsertDataWithCondition()
	BEGIN
        /* 错误成因：唯一性约束 */
        /* 方式1 */
        -- DECLARE EXIT HANDLER FOR 1062 SET @proc_value = -1;
        /* 方式2 */
        -- DECLARE EXIT HANDLER FOR SQLSTATE '23000' SET @proc_value = -1;
        /* 方式3 */
		DECLARE duplicate_entry CONDITION FOR SQLSTATE '23000' ;
		DECLARE EXIT HANDLER FOR duplicate_entry SET @proc_value = -1;
		
		SET @x = 1;
		INSERT INTO departments(department_name) VALUES('test');
		SET @x = 2;
		INSERT INTO departments(department_name) VALUES('test');
		SET @x = 3;
	END //

DELIMITER ;

CALL InsertDataWithCondition();
SELECT @x,@proc_value;

/* 恢复departments表 */
SELECT * FROM departments;

DELETE FROM departments
WHERE department_name = 'test';

SELECT * FROM departments;