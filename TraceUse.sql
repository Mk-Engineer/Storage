#分析优化其执行计划：trace

USE dbtest;

-- OPTIMIZER_TRACE是MySQL5.6引入的一项跟踪功能，它可以跟踪优化其作出的各种决策
--（比如访问表的方法、各种开销计算、各种转换等），并将跟踪结果记录到 INFORMATION_SCHEMA.OPTIMIZER_TRACE表中

-- 此功能默认关闭。开启trace，并设置格式为JSON，同时设置trace最大能够使用的内存大小，
-- 避免解析过程中因为默认内存过小，而不能够完整显示。

-- SET optimizer_trace="enabled=on",end_markers_in_json=on;
-- SET optimizer_trace_max_men_size=1000000;

SELECT * FROM student_info WHERE id < 10;

SELECT * FROM information_schema.optimizer_trace\G
