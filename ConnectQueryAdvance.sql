#关联查询优化
USE dbtest;

-- 数据准备
-- 分类
CREATE TABLE IF NOT EXISTS `type`(
`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`card` INT(10) UNSIGNED NOT NULL,
PRIMARY KEY(`id`)
);
-- 图书
CREATE TABLE IF NOT EXISTS `book`(
`bookid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`card` INT(10) UNSIGNED NOT NULL,
PRIMARY KEY(`bookid`)
);
-- 向分类表中添加20条记录
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));

-- 向图书表中添加20条记录
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO book(card) VALUES(FLOOR(1 + (RAND() * 20)));

-- 左外连接
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` LEFT JOIN book ON type.card = book.card;
-- 添加索引
CREATE INDEX Y ON book(card);
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` LEFT JOIN book ON type.card = book.card;

CREATE INDEX X ON `type`(card);
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` LEFT JOIN book ON type.card = book.card;

DROP INDEX Y ON book;
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` LEFT JOIN book ON type.card = book.card;

DROP INDEX X ON `type`;


-- 内连接
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` INNER JOIN book ON type.card = book.card;
-- 添加索引
CREATE INDEX Y ON book(card);
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` INNER JOIN book ON type.card = book.card;

-- 对于内连接来说，查询优化其时可以决定谁作为驱动表，谁作为被驱动表
CREATE INDEX X ON `type`(card);
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` INNER JOIN book ON type.card = book.card;

-- 被驱动表有索引时，成本较低
DROP INDEX Y ON book;
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` INNER JOIN book ON type.card = book.card;

CREATE INDEX Y ON book(card);
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` INNER JOIN book ON type.card = book.card;

-- 向type表中添加20条数据
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));
#INSERT INTO type(card) VALUES(FLOOR(1 + (RAND() * 20)));

-- 对于内连接来说，在两个表的连接条件都存在索引的情况下，会选择数据两小的表作为驱动表：小表驱动大表
EXPLAIN SELECT SQL_NO_CACHE * FROM `type` INNER JOIN book ON type.card = book.card;

