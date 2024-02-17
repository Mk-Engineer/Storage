#索引优化与查询优化

USE dbtest;

SET GLOBAL log_bin_trust_function_creators=1; #不加global只当前窗口有效

#创建表
CREATE TABLE IF NOT EXISTS `class` (
 `id` INT(11) NOT NULL AUTO_INCREMENT,
 `className` VARCHAR(30) DEFAULT NULL,
 `address` VARCHAR(40) DEFAULT NULL,
 `monitor` INT NULL,
 PRIMARY KEY(`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `student` (
 `id` INT(11) NOT NULL AUTO_INCREMENT,
 `stuno` INT NOT NULL,
 `name` VARCHAR(20) DEFAULT NULL,
 `age` INT(3) DEFAULT NULL,
 `classId` INT(11) DEFAULT NULL,
 PRIMARY KEY (`ID`)
 
 #CONSTRANT `fk_class_id` FOREIGN KEY (`classId`) REFERENCES `t_class` (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


#创建函数
#随机产生字符串
#DROP FUNCTION rand_string;
DELIMITER //
CREATE FUNCTION rand_string(n INT)
    RETURNS VARCHAR(255) /* 该函数会返回一个字符串 */
BEGIN
    DECLARE chars_str VARCHAR(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    DECLARE return_str VARCHAR(255) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    WHILE i < n DO
        SET return_str =CONCAT(return_str,SUBSTRING(chars_str,FLOOR(1+RAND()*52),1));
        SET i = i + 1;
    END WHILE;
    RETURN return_str;
END //
DELIMITER ;


#随机产生班级编号
DROP FUNCTION rand_num;
DELIMITER //
CREATE FUNCTION rand_num(from_num INT,to_num INT) RETURNS INT(11)
BEGIN
DECLARE i INT DEFAULT 0;
SET i = FLOOR(from_num+RAND()*(to_num - from_num+1));
RETURN i;
END//
DELIMITER ;


#创建存储过程
#创建向stu表中插入数据的存储过程
DROP PROCEDURE insert_stu;
DELIMITER //

CREATE PROCEDURE insert_stu(START INT,max_num INT)
BEGIN
DECLARE i INT DEFAULT 0;
 SET AUTOCOMMIT = 0; #设置手动提交事务
 REPEAT
 SET i = i + 1;
 INSERT INTO student(stuno,name,age,classId) 
 VALUES((START+i),rand_string(6),rand_num(1,50),rand_num(1,1000));
 UNTIL i = max_num
 END REPEAT;
 COMMIT;
END//

DELIMITER ;


#创建向class表中插入数据的存储过程
DROP PROCEDURE insert_class;
DELIMITER //

CREATE PROCEDURE `insert_class`(max_num INT)
BEGIN
DECLARE i INT DEFAULT 0;
 SET autocommit = 0;
 REPEAT
 SET i = i + 1;
 INSERT INTO class(className,address,monitor)
 VALUES(rand_string(8),rand_string(10),rand_num(1,100000));
 UNTIL i = max_num
 END REPEAT;
 COMMIT;
END //

DELIMITER ;


#调用存储过程
#CALL insert_class(10000);
#CALL insert_stu(10000,500000);

SELECT COUNT(*) FROM class;
SELECT COUNT(*) FROM student;


#删除某表上的索引
#每个游标必须使用不同的declare continue handler for not found set done=1来控制游标的结束
#若没有数据返回，程序继续，并将变量done设为2
DELIMITER //
CREATE PROCEDURE `proc_drop_index`(dbname VARCHAR(200),tablename VARCHAR(200))
BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE ct INT DEFAULT 0;
	DECLARE _index VARCHAR(200) DEFAULT '';
	DECLARE _cur CURSOR FOR SELECT index_name FROM information_schema.STATISTICS WHERE table_schema=dbname AND table_name=tablename AND seq_in_index=1 AND index_name<>'PRIMARY';
	DECLARE CONTINUE HANDLER FOR NOT FOUND set done=2;
	OPEN _cur;
	FETCH _cur INTO _index;
	WHILE _index<>'' DO
		SET @str = CONCAT("drop index",_index,"on",tablename);
		PREPARE sql_str FROM @str;
		EXECUTE sql_str;
		DEALLOCATE PREPARE sql_str;
		SET _index='';
		FETCH _cur INTO _index;
	END WHILE;
 CLOSE _cur;
END //
DELIMITER ;


#索引失效的案例
-- 全值匹配
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age=30;
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age=30 AND classId = 4;
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age=30 AND classId = 4 AND NAME = 'abcd';

-- 执行时间
SELECT SQL_NO_CACHE * FROM student WHERE age=30 AND classId = 4 AND NAME = 'abcd';
-- 添加索引
CREATE INDEX idx_age ON student(age);
CREATE INDEX idx_age_classid ON student(age,classId);
CREATE INDEX idx_age_classid_name ON student(age,classId,name);#联合索引效率最高
-- 执行时间
SELECT SQL_NO_CACHE * FROM student WHERE age=30 AND classId = 4 AND NAME = 'abcd';


#最佳左前缀匹配规则
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE student.age=30 AND student.name='abcd';
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE student.classid=1 AND student.name='abcd';#age最左，没有成功使用索引
-- 索引idx_age_classid_name还能否正常使用？
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE classid=4 AND student.age=30 AND student.name='abcd';#成功使用索引

DROP INDEX idx_age ON student;
DROP INDEX idx_age_classid ON student;

-- 对于多列索引，过滤条件要使用索引必须按照索引建立时的顺序，依次满足，一旦跳过某个字段，索引后面的字段都无法被使用
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE student.age=30 AND student.name = 'abcd';#最左前缀原则：age -> classid -> name

-- 计算、函数、类型转化(手动或自动)导致索引失效
-- 函数
CREATE INDEX idx_name ON student(name);

EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE student.name LIKE 'abc%';
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE LEFT(student.name,3)='abc';
EXPLAIN SELECT id,stuno,name FROM student WHERE SUBSTRING(name,1,3)='abc';

-- 计算
CREATE INDEX idx_sno ON student(stuno);

EXPLAIN SELECT SQL_NO_CACHE id,stuno,name FROM student WHERE stuno+1 = 900001;
EXPLAIN SELECT SQL_NO_CACHE id,stuno,name FROM student WHERE stuno = 900000;

-- 类型转换
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE name=123;
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE name='123';

-- 范围条件右边的列索引失效
-- 准备工作
SHOW INDEX FROM student;

#CALL proc_drop_index('dbtest','student');
DROP INDEX idx_age_classid_name ON student;
DROP INDEX idx_name ON student;
DROP INDEX idx_sno ON student;

SHOW INDEX FROM student;

-- 索引失效
CREATE INDEX idx_age_classid_name ON student(age,classId,name);
SHOW INDEX FROM student;

EXPLAIN SELECT SQL_NO_CACHE * FROM student
WHERE student.age=30 AND student.classId>20 AND student.name='abc';#name的索引没有用上

-- 创建索引时先列等值关系，再列范围判断
CREATE INDEX idx_age_name_classId ON student(age,name,classId);
SHOW INDEX FROM student;

EXPLAIN SELECT SQL_NO_CACHE * FROM student
WHERE student.age=30 AND student.classId>20 AND student.name='abc';#name的索引没有用上


-- 不等于(!=或<>)索引失效
CREATE INDEX idx_name ON student(name);
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE student.name = 'abc';
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE student.name != 'abc';
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE student.name <> 'abc';

-- IS NULL可以使用索引，IS NOT NULL无法使用索引
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age IS NULL;
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age IS NOT NULL;
-- 说明：最好在设计数据表初就将字段设置为NOT NULL约束，必须有NULL的情况可以将INT默认设置为0，将字符串默认设置为‘’
-- 同理：NOT LIKE 也无法使用索引，导致全表扫描


-- LIKE以通配符%开头时，索引失效
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE name LIKE 'ab%';
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE name LIKE '%ab';
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE name LIKE '%ab%';
-- 强制：页面搜索严禁`左模糊`或`全模糊`，如果需要请走搜索引擎来解决


