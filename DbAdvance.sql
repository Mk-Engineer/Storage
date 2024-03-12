#优化数据库结构
USE dbtest;

-- 1 拆分表：冷热数据分离
CREATE TABLE IF NOT EXISTS members(
 id INT(11) NOT NULL AUTO_INCREMENT,
 username VARCHAR(50) DEFAULT NULL,
 password VARCHAR(50) DEFAULT NULL,
 last_login_time DATETIME DEFAULT NULL,
 last_login_ip VARCHAR(100) DEFAULT NULL,
 
 PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS members_detail(
 Member_id INT(11) NOT NULL DEFAULT 0,
 address VARCHAR(255) DEFAULT NULL,
 telephone VARCHAR(255) DEFAULT NULL,
 description TEXT
);

SELECT * FROM members LEFT JOIN members_detail ON members.id = members_detail.member_id;

-- 2 增加中间表
-- 把经常需要联合查询的数据插入中间表中，然后将原来的联合查询改为对中间表的查询，以此来提高效率

-- 3 增加冗余字段

-- 4 优化数据类型
-- 优先选择符合存储需要的最小的数据类型
-- I   对非负数的数据，优先使用UNSIGNED
-- II  既可以使用文本也可以使用整数类型的字段，选择使用整数类型
-- III 避免使用TEXT、BLOB数据类型
-- IV  避免使用ENUM类型
--     修改ENUM值需要使用ALTER语句
--     ENUM类型的ORDER BY操作效率低，需要额外操作
--     使用TINYINT来代替ENUM类型
-- V   使用TIMESTAMP存储时间
--     TIMSTAMP使用4字节，DATETIME使用8字节
-- VI 用DECIMAL代替FLOAT和DOUBLE存储精确浮点数

-- 5 优化插入记录的速度



