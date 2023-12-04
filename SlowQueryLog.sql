# 慢查询日志
SHOW variables LIKE '%slow_query_log%';
SHOW variables LIKE '%long_query_time%';/* 10 sec */

SET GLOBAL long_query_time = 1;
SET long_query_time = 1;
SHOW variables LIKE '%long_query_time%';/* 10 sec */
/* 重启mysqld，long_query_time会被重置为10 */
-- SET GLOBAL long_query_time = 10;
-- SET long_query_time = 10;

SHOW GLOBAL STATUS LIKE '%Slow_queries%';

/* 慢查询日志分析工具 mysqldumpslow  */
-- Linux
-- cd /var/lib/mysql

-- mysqldumpslow -s t -t 5 /var/lib/mysql/mk-linux-slow.log 
-- 此时字符串类型用S抽象表示，数值类型用N抽象表示

-- mysqldumpslow -a -s t -t 5 /var/lib/mysql/mk-linux-slow.log 
-- 取消抽象表示

/* 关闭慢查询日志 */
/* 不做分析时，开启影响性能 */
SET GLOBAL slow_query_log = OFF;
SHOW variables LIKE '%slow_query_log%';

/* 重新生成慢查询日志文件 */
-- mysqladmin -uroot -p flush-logs slow

/* 查看SQL执行成本：SHOW PROFILE */
set profiling = 'ON';
SHOW variables LIKE 'profiling';

SHOW PROFILES;
SHOW PROFILE;

SHOW PROFILE cpu,block io FOR query 3;