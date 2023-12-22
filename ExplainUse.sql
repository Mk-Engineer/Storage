# Explain的使用
USE dbtest;

# 1 table：表名
-- 查询的每一行记录都对应着一个单表
EXPLAIN SELECT * FROM s1;

-- s1驱动表 s2被驱动表
EXPLAIN SELECT * FROM s1 INNER JOIN s2;

# 2 id：在一个大的查询语句中每个SELECT关键字都对应一个唯一的id
SELECT * FROM s1 WHERE key1 = 'a';

SELECT * FROM s1 INNER JOIN s2
ON s1.key1 = s2.key1
WHERE s1.common_field = 'a';

SELECT * FROM s1 UNION SELECT * FROM s2;

EXPLAIN SELECT * FROM s1 WHERE key1 = 'a';
EXPLAIN SELECT * FROM s1 INNER JOIN s2;
EXPLAIN SELECT * FROM s1 WHERE key1 IN (SELECT key1 FROM s2) OR key3 = 'a';# id值越大，代表语句优先级越高，语句越先执行

##### 查询优化器可能对涉及子查询的查询语句进行重写 #####
-- 优化器进行了重写，转变为一个多表查询的操作
EXPLAIN SELECT * FROM s1 WHERE key1 IN (SELECT key2 FROM s2 WHERE common_field = 'a');

# UNION去重
EXPLAIN SELECT * FROM s1 UNION SELECT * FROM s2;
EXPLAIN SELECT * FROM s1 UNION ALL SELECT * FROM s2;

# 3 select type:SELECT关键字对应的那个查询类型，确定小查询在整个大查询中扮演了一个什么样的角色
-- 查询语句中不包含‘UNION’或者子查询的都算是‘SIMPLE’类型
EXPLAIN SELECT * FROM s1;
-- 连接查询也算是SIMPLE类型
EXPLAIN SELECT * FROM s1 INNER JOIN s2;
-- 对于包含‘UNION’或者子查询的大查询来说，它是由几个小查询组成的，其中最左边的查询的‘select_type’就是‘PRIMARY’

-- 对于包含‘UNION’或者‘UNION ALL’的大查询来说，它是由几个小查询组成的，其中除了最左边的那个小查询以外，其余的小查询的‘select_type’值就是‘UNION’

-- MySQL选择使用临时表来完成‘UNION’查询的去重工作，针对该临时表的查询的‘select_type’就是‘UNION RESULT’

EXPLAIN SELECT * FROM s1 UNION SELECT * FROM s2;
EXPLAIN SELECT * FROM s1 UNION ALL SELECT * FROM s2;

# 子查询
-- 如果包含子查询的查询语句不能够转为对应的‘semi-join’的形式，并且该子查询是不相关子查询
-- 该子查询的第一个‘SELECT’关键字代表的那个子查询的‘select_type’是‘SUBQUERY’
EXPLAIN SELECT * FROM s1 WHERE key1 IN (SELECT key1 FROM s2) OR key3 = 'a';

-- 如果包含子查询的查询语句不能够转为对应的‘semi-join’的形式，并且该子查询是相关子查询
-- 该子查询的第一个‘SELECT’关键字代表的那个子查询的‘select_type’是‘DEPENDENT SUBQUERY’
EXPLAIN SELECT * FROM s1
WHERE key1 IN (SELECT key1 FROM s2 WHERE s1.key2 = s2.key2) OR key3 = 'a';
-- 注意的是，select_type为‘DEPENDENT SUBQUERY’的查询可能被执行多次

-- 在包含‘UNION’或者‘UNION ALL’的大查询中，如果各个小查询都依赖于外层查询的话，那除了最左边的那个小查询之外，其余小查询的‘select_type’就是‘DEPENDENT UNION’
EXPLAIN SELECT * FROM s1
WHERE key1 IN (SELECT key1 FROM s2 WHERE key1 = 'a' UNION SELECT key1 FROM s1 WHERE key1 = 'b');

-- 对于包含‘派生表’的查询，该派生表对应的子查询的‘select_type’是‘DERIVED’
EXPLAIN SELECT * 
FROM (SELECT key1,COUNT(*) AS c FROM s1 GROUP BY key1) AS derived_s1 WHERE c > 1; 

