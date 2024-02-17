#排序优化
USE dbtest;

-- 建议在WHERE和ORDER BY中使用索引
-- 在WHERE中：避免全表扫描
-- 在ORDER BY中：避免使用FileSort排序

EXPLAIN SELECT SQL_NO_CACHE * FROM student ORDER BY age,classid;
EXPLAIN SELECT SQL_NO_CACHE * FROM student ORDER BY age,classid LIMIT 10;

-- 创建索引
CREATE INDEX idx_age_classid_name ON student(age,classid,name);

EXPLAIN SELECT SQL_NO_CACHE * FROM student ORDER BY age,classid;#不限制，索引失效
EXPLAIN SELECT SQL_NO_CACHE * FROM student ORDER BY age,classid;#没有回表，覆盖索引
EXPLAIN SELECT SQL_NO_CACHE * FROM student ORDER BY age,classid LIMIT 10;

-- ORDER BY时顺序错误，索引失效
CREATE INDEX idx_age_classid_stuno ON student(age,classid,stuno);

EXPLAIN SELECT * FROM student ORDER BY classid LIMIT 10;
EXPLAIN SELECT * FROM student ORDER BY classid,name LIMIT 10;
EXPLAIN SELECT * FROM student ORDER BY age,classid,stuno LIMIT 10;
EXPLAIN SELECT * FROM student ORDER BY age,classid LIMIT 10;
EXPLAIN SELECT * FROM student ORDER BY age LIMIT 10;

-- ORDER BY时规则不一致，索引失效（顺序错不索引，方相反不索引）
EXPLAIN SELECT * FROM student ORDER BY age DESC, classid ASC LIMIT 10;
EXPLAIN SELECT * FROM student ORDER BY classid DESC,name DESC LIMIT 10;
EXPLAIN SELECT * FROM student ORDER BY age ASC, classid DESC LIMIT 10;
EXPLAIN SELECT * FROM student ORDER BY age DESC, classid DESC LIMIT 10;

-- 无过滤，不索引
EXPLAIN SELECT * FROM student WHERE age=45 ORDER BY classid;
EXPLAIN SELECT * FROM student WHERE age=45 ORDER BY classid,name;
EXPLAIN SELECT * FROM student WHERE classid=45 ORDER BY age;
EXPLAIN SELECT * FROM student WHERE classid=45 ORDER BY age LIMIT 10;

CREATE INDEX idx_cid ON student(classid);
EXPLAIN SELECT * FROM student WHERE classid=45 ORDER BY age;


-- 具体案例:测试filesort和index排序
SHOW INDEX FROM student;

DROP INDEX idx_cid ON student;
DROP INDEX idx_age_classid_stuno ON student;
DROP INDEX idx_age_classid_name ON student;

SHOW INDEX FROM student;

-- 场景：查询年龄为30岁的，且学生编号小于10100的学生，按用户名排序
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age = 30 AND stuno < 10100 ORDER BY name;

-- 方案1
CREATE INDEX idx_age_name ON student(age,name);
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age = 30 AND stuno < 10100 ORDER BY name;

-- 方案2
CREATE INDEX idx_age_stuno_name ON student(age,stuno,name);
EXPLAIN SELECT SQL_NO_CACHE * FROM student WHERE age = 30 AND stuno < 10100 ORDER BY name;
-- 结论：当`范围条件`和`GROUP BY`或`ORDER BY`的字段出现二选一时，优先观察条件字段的过滤数量，如果过滤的数据足够多，而需要排序的数据不多时，优先把索引放在范围字段上。


-- filesort算法：双路排序和单路排序
-- 双路排序（慢）
-- 单路排序（快）
