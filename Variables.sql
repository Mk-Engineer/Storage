# 变量
USE dbtest;
-- 系统变量：全局系统变量、会话系统变量
-- 用户自定义变量：

/* 查看系统变量 */
-- SHOW GLOBAL VARIABLES;
-- SHOW SESSION VARIABLES;
-- SHOW VARIABLES;/* 默认查询SESSION系统变量 */

/* 查询部分变量 */
SHOW GLOBAL VARIABLES LIKE 'admin_%';

/* 查询指定系统变量 */
SELECT @@global.max_connections;
SELECT @@global.character_set_client;

SELECT @@session.character_set_client;
SELECT @@session.pseudo_thread_id;

/* 修改系统变量的值 */
/* 方式1：修改配置文件my.ini，修改后需要重启MySQL服务 */
/* 方式2：在MySQL运行期间修改，只针对当前数据库实例时有效的，重启后变量失效，恢复默认值 */
-- I.
SET @@global.max_connections=161;
SELECT @@global.max_connections;

-- II.
SET GLOBAL max_connections=151;
SELECT @@global.max_connections;


/* 修改会话系统变量的值 */
/* 针对当前会话是有效的，一旦结束会话，重新建立起新的会话，变量失效恢复默认值 */
-- I.
SET @@session.character_set_client = 'utf8mb4';
SELECT @@session.character_set_client;

-- II.
SET SESSION character_set_client = 'gbk';
SELECT @@session.character_set_client;