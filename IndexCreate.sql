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

SHOW TABLES;
DROP TABLE emp_index;
DROP TABLE dept_index;
DROP TABLE book;
DROP TABLE book_bkup;
DROP TABLE book_auto;
DROP TABLE book_single;
DROP TABLE book_union;
DROP TABLE emp_full;
DROP TABLE book_finish;
DROP TABLE book_exist;
SHOW TABLES;