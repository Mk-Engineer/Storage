#覆盖索引
USE dbtest;

-- 一个索引包含了满足查询结果的数据就叫做覆盖索引
#DROP INDEX idx_age_name ON student;
#DROP INDEX idx_age_stuno_name ON student;

-- 举例1：
-- 并非所有`不等于`都一定导致`不使用索引`，而是基于成本的考虑视情况而定
#CREATE INDEX idx_age_name ON student(age,name);

EXPLAIN SELECT * FROM student WHERE age <> 20;

EXPLAIN SELECT id,age,name FROM student WHERE age <> 20;

-- 举例2：
-- 并非所有`%前通配符`都一定导致`不使用索引`，而是基于成本的考虑视情况而定
EXPLAIN SELECT * FROM student WHERE name LIKE '%abc';

EXPLAIN SELECT id,age,name FROM student WHERE name LIKE '%abc';

-- 覆盖索引的利弊：
-- 优点：
-- 1 避免Innodb表进行索引的二次查询（避免回表）
-- 2 可以把随机IO变成顺序IO加快查询效率
-- 由于`覆盖索引`可以减少树的搜索次数，显著提升查询性能，所以使用`覆盖索引`时一个常用的性能优化手段
-- 缺点：
-- `索引字段维护`总是有代价的。因此，在建立`冗余索引`来`支持覆盖索引`时需要权衡考虑。
