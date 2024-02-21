#数据库设计规范
USE dbtest;

-- 第一范式(1st NF)
-- 每个字段的值必须具有`原子性`，是`不可再次拆分`的最小数据单元

-- 第二范式(2nd NF)
-- 在满足第一范式的基础上
-- 满足数据表的每一条数据记录，都是可唯一标识的
-- 所有非主键字段，都必须完全依赖主键，不能只依赖主键的一部分

-- 第三范式(3rd NF)
-- 已经满足第一范式和第二范式
-- 确保每一个非主键字段都和主键字段`直接`相关
-- 即要求数据表中的所有`非主键字段`不能依赖于`其他非主键字段`
-- `非主键字段`之间不能有依赖关系，必须`相互独立`

-- 反范式化
CREATE TABLE IF NOT EXISTS students(
 stu_id INT PRIMARY KEY AUTO_INCREMENT,
 stu_name VARCHAR(25),
 create_time DATETIME
);

CREATE TABLE IF NOT EXISTS class_comment(
 comment_id INT PRIMARY KEY AUTO_INCREMENT,
 class_id INT,
 comment_text VARCHAR(35),
 comment_time DATETIME,
 stu_id INT
);

-- 随机生成100万学生的代码
DELIMITER //

CREATE PROCEDURE batch_insert_students(IN start INT(10), IN max_num INT(10))
BEGIN
 DECLARE i INT DEFAULT 0;
 DECLARE date_start DATETIME DEFAULT('2017-01-01 00:00:00');
 DECLARE date_temp DATETIME;
 SET date_temp = date_start;
 SET autocommit=0;
 
REPEAT
 SET i=i+1;
 SET date_temp = DATE_ADD(date_temp,INTERVAL RAND()*60 SECOND);
 INSERT INTO students(stu_id,stu_name,create_time)
 VALUES((START+i),CONCAT('stu_',i),date_temp);
 UNTIL i = max_num
END REPEAT;

COMMIT;
END //

DELIMITER ;

#CALL batch_insert_students(1000,1000000);

DELIMITER //

CREATE PROCEDURE batch_insert_class_comments(IN start INT(10),IN max_num INT(10))
BEGIN
 DECLARE i INT DEFAULT 0;
 DECLARE date_start DATETIME DEFAULT('2018-01-01 00:00:00');
 DECLARE date_temp DATETIME;
 DECLARE comment_text VARCHAR(25);
 DECLARE stu_id INT;
 SET date_temp = date_start;
 SET autocommit=0;
REPEAT
 SET i=i+1;
 SET date_temp = DATE_ADD(date_temp,INTERVAL RAND()*60 SECOND);
 SET comment_text = SUBSTR(MD5(RAND()),1,20);
 SET stu_id = FLOOR(RAND()*1000000);
 INSERT INTO class_comment(comment_id,class_id,comment_text,comment_time,stu_id)
 VALUES((start+i),10001,comment_text,date_temp,stu_id);
 UNTIL i = max_num 
END REPEAT;
COMMIT;
END//

DELIMITER ;

#CALL batch_insert_class_comments(10000,1000000);
