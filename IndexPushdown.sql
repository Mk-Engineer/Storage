#索引下推
USE dbtest;

-- Example 1
EXPLAIN SELECT * FROM s1 WHERE key1 > 'z' AND key1 LIKE '%a';

-- Example 2
CREATE TABLE IF NOT EXISTS `people`(
 `id` INT NOT NULL AUTO_INCREMENT,
 `zipcode` VARCHAR(20) COLLATE utf8_bin DEFAULT NULL,
 `firstname` VARCHAR(20) COLLATE utf8_bin DEFAULT NULL,
 `lastname` VARCHAR(20) COLLATE utf8_bin DEFAULT NULL,
 `address` VARCHAR(50) COLLATE utf8_bin DEFAULT NULL,
 PRIMARY KEY(`id`),
 KEY `zip_last_first` (`zipcode`,`lastname`,`firstname`) 
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin; 

#INSERT INTO `people` VALUES
#('1','000001','III','Zhang','Beijing'),
#('2','000002','IV','Li','Nanjing'),
#('3','000003','V','Wang','Shanghai'),
#('4','000001','VI','Zhao','Tianjin');

-- Using index condition
-- 索引下推针对的是联合索引
EXPLAIN SELECT * FROM people
WHERE zipcode = '000001'
AND lastname LIKE '%Zhang%'
AND address LIKE 'Beijing';

-- Index Condition Pushdown的开启和关闭
SET optimizer_switch = 'index_condition_pushdown=off';
SET optimizer_switch = 'index_condition_pushdown=on';

-- 开启关闭Index Condition Pushdown的性能对比
DELIMITER //
CREATE PROCEDURE insert_people(max_num INT)
BEGIN
DECLARE i INT DEFAULT 0;
 SET autocommit = 0;
 
 REPEAT
 SET i = i + 1;
 INSERT INTO people(zipcode,firstname,lastname,address) VALUES('000005','X','Zhou','Hangzhou');
 UNTIL i = max_num
 END REPEAT;
 COMMIT;
END //
DELIMITER ;

#CALL insert_people(1000000);

SET profiling=1;

SELECT * FROM people WHERE zipcode='000005' AND lastname LIKE '%Zhou%';
SELECT /*+ no_icp (people) */ * FROM people WHERE zipcode='000005' AND lastname LIKE '%Zhou%';

SHOW profiles;

-- ICP适用于需要回表的前提下
-- 0 仅用于`二级索引`
-- 1 聚簇索引不支持ICP
-- 2 覆盖索引不支持ICP
-- 3 相关子查询的条件不能使用ICP
