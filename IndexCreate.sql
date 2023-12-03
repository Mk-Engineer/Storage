# 索引的创建
-- (隐式方式) 创建表时自动创建索引
-- 在声明有主键约束、唯一性约束、外键约束的字段上，会自动创建相关索引
CREATE TABLE IF NOT EXISTS dept_index(
dept_id INT PRIMARY KEY AUTO_INCREMENT,/* 主键索引 */
dept_name VARCHAR(20)    
);

CREATE TABLE IF NOT EXISTS emp_index(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(20) UNIQUE, /* 唯一性索引 */
dept_id INT,
CONSTRAINT emp_dept_id_fk FOREIGN KEY(dept_id) REFERENCES dept_index(dept_id) /* 外键索引 */
);


-- (显示方式) 创建索引
--  CREATE TABLE IF NOT EXISTS table_name [col_name data_type] 
--  [UNIQUE | FULLTEXT | SPATIAL] [INDEX | KEY] [index_name] (col_name [length]) [ASC | DESC]

-- 创建普通索引
CREATE TABLE IF NOT EXISTS book( 
    book_id INT , 
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100) , 
    comment VARCHAR(100), 
    year_publication YEAR, 
    INDEX idx_bname(book_name) /* 声明索引 */
);

-- 命令行查看索引
-- 方式1
SHOW CREATE TABLE book\G;
-- 方式2
SHOW INDEX FROM book\G;
-- 索引作用：提高SELECT查询效率
-- EXPLAIN 性能分析工具
EXPLAIN SELECT * FROM book WHERE book_name = 'mysqlsenior';


-- 创建唯一索引
CREATE TABLE IF NOT EXISTS book_bkup( 
    book_id INT , 
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100) , 
    comment VARCHAR(100), 
    year_publication YEAR, 
    UNIQUE INDEX uk_idx_cmt(COMMENT) /* 声明索引 */
);

SHOW INDEX FROM book_bkup\G;

/* 声明有唯一索引的字段，在添加数据时，不可重复，但是可以多次添加NULL值 */
INSERT INTO book_bkup(book_id,book_name,COMMENT)
VALUES(1,'MySQLSenior','SeniorPrograming');

SELECT * FROM book_bkup;

/* ERROR 1062 (23000): Duplicate entry 'SeniorPrograming' for key 'book_bkup.uk_idx_cmt' */
INSERT INTO book_bkup(book_id,book_name,COMMENT)
VALUES(1,'MySQLSenior','SeniorPrograming');


-- 主键索引
-- 通过定义主键约束的方式定义主键索引
DROP TABLE book_auto;
CREATE TABLE IF NOT EXISTS book_auto( 
    book_id INT PRIMARY KEY, /* 主键索引 */
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100), 
    comment VARCHAR(100), 
    year_publication YEAR
);

SHOW INDEX FROM book_auto\G;

-- 通过删除主键约束的方式删除主键索引
ALTER TABLE book_auto
DROP PRIMARY KEY;

SHOW INDEX FROM book_auto\G;


-- 创建单列索引
CREATE TABLE IF NOT EXISTS book_single( 
    book_id INT,
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100), 
    comment VARCHAR(100), 
    year_publication YEAR,
    UNIQUE INDEX idx_bname(book_name)/* 单列索引 */
);

SHOW INDEX FROM book_single\G;

-- 创建联合索引
CREATE TABLE IF NOT EXISTS book_union( 
    book_id INT,
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100), 
    comment VARCHAR(100), 
    year_publication YEAR,
    /* 将常用字段放在最左侧 */
    INDEX mult_bid_bname_info(book_id,book_name,info)/* 单列索引 */
);

SHOW INDEX FROM book_union\G;
SHOW INDEX FROM book_union;/* 联合索引有序号 */

/* 最左前缀原则 */
EXPLAIN SELECT * FROM book_union WHERE book_id = 1001 AND book_name = 'mysql';


-- 创建全文索引
-- 注意：只能为CHAR\VARCHAR\TEXT列创建全文索引
CREATE TABLE IF NOT EXISTS emp_full(
id INT NOT NULL,
name CHAR(30) NOT NULL,
age INT NOT NULL,
info VARCHAR(255),
FULLTEXT INDEX futxt_idx_info(info(50))/* 全文索引 */    
);

SHOW INDEX FROM emp_full\G;

-- 全文索引查询方式
/* 如果需要全文索引大量数据，建议先添加数据，再创建索引 */
-- SELECT * FROM emp_full WHERE MATCH(info) AGAINST (‘%SearchString%’);


-- 在已经创建的表上添加索引
CREATE TABLE IF NOT EXISTS book_finish( 
    book_id INT,
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100), 
    comment VARCHAR(100), 
    year_publication YEAR
);
/* 方式1 */
ALTER TABLE book_finish ADD INDEX idx_cmt(comment);
ALTER TABLE book_finish ADD UNIQUE uk_idx_bname(book_name);
ALTER TABLE book_finish ADD INDEX mult_bid_bname_info(book_id,book_name,info);

SHOW INDEX FROM book_finish\G;
SHOW INDEX FROM book_finish;
/* 方式2 */
CREATE TABLE IF NOT EXISTS book_exist( 
    book_id INT,
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100), 
    comment VARCHAR(100), 
    year_publication YEAR
);
CREATE INDEX idx_cmt ON book_exist(comment);
CREATE UNIQUE INDEX uk_idx_bname ON book_exist(book_name);
CREATE INDEX mult_bid_bname_info ON book_exist(book_id,book_name,info);
SHOW INDEX FROM book_exist\G;


-- 索引的删除
SHOW INDEX FROM book_finish\G;
/* 方式1 */
ALTER TABLE book_finish
DROP INDEX idx_cmt;
SHOW INDEX FROM book_finish\G;/* 唯一性索引不能删除 */

/* 方式2 */
DROP INDEX uk_idx_bname ON book_finish;
SHOW INDEX FROM book_finish\G;

/* 删除联合索引 */
ALTER TABLE book_finish
DROP COLUMN book_name;/* 联合索引的中间字段 */
SHOW INDEX FROM book_finish\G;



-- 创建升序降序索引
CREATE TABLE IF NOT EXISTS ts1(a INT,b INT,INDEX idx_a_b(a ASC,b DESC));
SHOW CREATE TABLE ts1;

DELIMITER //
CREATE PROCEDURE ts_insert()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i < 800
    DO
        INSERT INTO ts1 SELECT RAND()*80000,RAND()*80000;
        SET i = i + 1;
    END WHILE;
    COMMIT;
END //        
DELIMITER ;

CALL ts_insert();

SELECT COUNT(*) FROM ts1;

EXPLAIN SELECT * FROM ts1 ORDER BY a,b DESC LIMIT 5;
EXPLAIN SELECT * FROM ts1 ORDER BY a DESC,b DESC LIMIT 5;/* Using filesort 不推荐*/



-- 隐藏索引
-- 作用：删除前先隐藏索引以便恢复，或测试隐藏索引前后的性能
/* 创建表时，隐藏索引 */
CREATE TABLE IF NOT EXISTS book_hide( 
    book_id INT,
    book_name VARCHAR(100), 
    authors VARCHAR(100), 
    info VARCHAR(100), 
    comment VARCHAR(100), 
    year_publication YEAR,
    /* 创建隐藏索引 */
    INDEX idx_cmt(comment) INVISIBLE
);

SHOW INDEX FROM book_hide\G;
EXPLAIN SELECT * FROM book_hide WHERE comment = 'mysql';

/* 创建表以后，创建隐藏索引 */
ALTER TABLE book_hide
ADD UNIQUE INDEX uk_idx_bname(book_name) INVISIBLE;

CREATE INDEX idx_year_pub ON book_hide(year_publication) /* INVISIBLE */;
EXPLAIN SELECT * FROM book_hide WHERE year_publication = '2023';

/* 修改索引的可见性 */
ALTER TABLE book_hide ALTER INDEX idx_year_pub INVISIBLE;
EXPLAIN SELECT * FROM book_hide WHERE year_publication = '2023';

ALTER TABLE book_hide ALTER INDEX idx_cmt VISIBLE;
SHOW INDEX FROM book_hide\G;
EXPLAIN SELECT * FROM book_hide WHERE comment = 'mysql';



-- 使隐藏索引对优化器可见(了解)
SELECT @@optimizer_switch\G;
SET SESSION optimizer_switch='use_invisible_indexes=on';
SELECT @@optimizer_switch\G;
EXPLAIN SELECT * FROM book_hide WHERE year_publication = '2023';

SET SESSION optimizer_switch='use_invisible_indexes=off';
SELECT @@optimizer_switch\G;



# 索引的设计原则

CREATE TABLE IF NOT EXISTS `student_info`(
`id` INT(11) NOT NULL AUTO_INCREMENT,
`student_id` INT NOT NULL,
`name` VARCHAR(20) DEFAULT NULL,
`course_id` INT NOT NULL,
`class_id` INT(11) DEFAULT NULL,
`create_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(`ID`)    
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `course`(
`id` INT(11) NOT NULL AUTO_INCREMENT,
`course_id` INT NOT NULL,
`course_name` VARCHAR(40) DEFAULT NULL,
PRIMARY KEY(`id`)    
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SELECT @@log_bin_trust_function_creators;/* 0 */
SET GLOBAL log_bin_trust_function_creators = 1;
SELECT @@log_bin_trust_function_creators;/* 1 */

/* 函数1：创建随机产生字符串函数 */
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

/* 函数2：创建随机数函数 */
DELIMITER //
CREATE FUNCTION rand_num(from_num INT,to_num INT) RETURNS INT(11)
BEGIN
    DECLARE i INT DEFAULT 0;
    SET i = FLOOR(from_num+RAND()*(to_num - from_num+1));
    RETURN i;
END //
DELIMITER ;

/* 创建插入数据的存储过程 */
DELIMITER //
CREATE PROCEDURE insert_course(max_num INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit = 0; /* 设置手动提交事务 */
    
    REPEAT
        SET i = i + 1;
        INSERT INTO course (course_id,course_name) VALUES (rand_num(10000,10100),rand_string(6));
        UNTIL i = max_num
    END REPEAT;

    COMMIT;/* 提交事务 */
END //
DELIMITER ;

/* 创建插入学生信息表存储过程 */
DROP PROCEDURE insert_stu;
DELIMITER //
CREATE PROCEDURE insert_stu(max_num INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit = 0;

    REPEAT
        SET i = i + 1;
        INSERT INTO student_info(course_id,class_id,student_id,`name`)
        VALUES(rand_num(10000,10100),rand_num(10000,10200),rand_num(1,200000),rand_string(6));
        UNTIL i = max_num
    END REPEAT;

    COMMIT;
END //
DELIMITER ;

-- TRUNCATE TABLE course;
-- CALL insert_course(100);
-- TRUNCATE TABLE student_info;
-- CALL insert_stu(1000000);

SELECT COUNT(*) FROM course;
SELECT COUNT(*) FROM student_info;

/* 哪些情况适合创建索引 */
-- 1 字段有唯一性限制
-- 2 频繁作为WHERE查询条件的字段

-- SHOW INDEX FROM student_info;

-- student_id字段上无索引
SELECT course_id,class_id,`name`,create_time,student_id
FROM student_info
WHERE student_id = 123110;/* 360ms */

-- 为student_id字段添加索引
ALTER TABLE student_info
ADD INDEX idx_sid(student_id);

SELECT course_id,class_id,`name`,create_time,student_id
FROM student_info
WHERE student_id = 123110;/* 0ms */


-- 3 经常GROUP BY / ORDER BY 的列
/* 有索引 */
SELECT student_id,COUNT(*) AS num 
FROM student_info GROUP BY student_id LIMIT 100;/* 0ms */

/* 无索引 */
DROP INDEX idx_sid ON student_info;

SELECT student_id,COUNT(*) AS num 
FROM student_info GROUP BY student_id LIMIT 100;/* 810ms */

/* 分别创建索引 */
/* 修改sql_mode */
-- SELECT @@sql_mode;
-- SET @@sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
/* 添加单列索引 */
-- ALTER TABLE student_info
-- ADD INDEX idx_sid(student_id);

-- ALTER TABLE student_info
-- ADD INDEX idx_ct(create_time);

-- SELECT student_id,COUNT(*) AS num FROM student_info
-- GROUP BY student_id/* 根据查询顺序，仅使用了idx_sid索引 */
-- ORDER BY create_time DESC
-- LIMIT 100;/* 1 min 53.05 sec */

/* 创建联合索引 */
/* 1 */
ALTER TABLE student_info
ADD INDEX idx_sid_ct(student_id,create_time DESC);

SELECT student_id,COUNT(*) AS num FROM student_info
GROUP BY student_id
ORDER BY create_time DESC
LIMIT 100;/* 0.34 sec */

/* 2 */
DROP INDEX idx_sid_ct ON student_info;

ALTER TABLE student_info
ADD INDEX idx_ct_sid(create_time DESC,student_id);/* 建议：先写GROUP BY,后写ORDER BY */

SELECT student_id,COUNT(*) AS num FROM student_info
GROUP BY student_id /* 优先用了idx_sid索引，最左前缀原则 */
ORDER BY create_time DESC
LIMIT 100;/* 0.77 sec */



-- 4 UPDATE、DELETE、的WHERE条件列
UPDATE student_info SET student_id = 10002
WHERE `name` = 'uwXBNkk';/* 1.00 sec */

/* 添加索引 */
ALTER TABLE student_info
ADD INDEX idx_name(`name`);

UPDATE student_info SET student_id = 10002
WHERE `name` = 'uwXBNkk';/* 0.00 sec */



-- 5 DISTINCT字段需要创建索引

-- 6 多表JOIN连接操作时，创建索引注意事项:
-- 首先，连接表的数量尽量不要超过 3 张，因为每增加一张表就相当于增加了一次嵌套的循环，数量级增长会非常快，严重影响查询的效率。
-- 其次，对 WHERE 条件创建索引，因为 WHERE 才是对数据条件的过滤。如果在数据量非常大的情况下，没有 WHERE 条件过滤是非常可怕的。
-- 最后，对用于连接的字段创建索引，并且该字段在多张表中的类型必须一致。
EXPLAIN SELECT s.course_id,s.`name`,s.student_id,c.course_name
FROM student_info s JOIN course c
ON s.course_id = c.course_id
WHERE `name` = 'uwXBNkk';

-- 7 使用小类型列的的创建索引(TINYINT/MEDIUMINT/INT/BIGINT)

-- 8 使用字符串前缀创建索引
-- CREATE TABLE shop(address varchar(20) NOT NULL);
-- ALTER TABLE shop ADD INDEX(ADDRESS(12));
/* 如何计算截取长度 */
-- SELECT COUNT(DISTINCT address) / count(*) FROM shop;/* 结果越接近 1 区分度越大，截取范围越小 */

/* 截取后的计算结果比 1 小，距离 1 越远，截取范围越大 */
-- SELECT COUNT(DISTINCT LEFT(address,10)) / count(*) AS sub10,/* 截取前10个字符 */
-- COUNT(DISTINCT LEFT(address,15)) / count(*) AS sub15,/* 截取前15个字符 */
-- COUNT(DISTINCT LEFT(address,20)) / count(*) AS sub20,/* 截取前20个字符 */ /* 默认 */
-- COUNT(DISTINCT LEFT(address,25)) / count(*) AS sub25/* 截取前25个字符 */
-- FROM shop;
/* 通常截取长度达到20时，区分度会高达 90% 以上 */


-- 9 区分度高散列性高的适合作为索引
/* 列的基数指的是某一列中不重复数据的个数，列的基数越大，该列中的值越分散；列的基数越小，该列的值越集中。 */

-- 10 使用频繁的列放在联合索引的左侧
/* 最左前缀原则 */

-- 11 在多个字段都要创建索引的情况下，联合索引由于单值索引

/* 限制索引的数目：单表不要超过6个 */



-- SHOW TABLES;
-- DROP TABLE emp_index;
-- DROP TABLE dept_index;
-- DROP TABLE book;
-- DROP TABLE book_bkup;
-- DROP TABLE book_auto;
-- DROP TABLE book_single;
-- DROP TABLE book_union;
-- DROP TABLE emp_full;
-- DROP TABLE book_finish;
-- DROP TABLE book_exist;
-- DROP TABLE ts1;
-- DROP TABLE book_hide;
-- SHOW TABLES;