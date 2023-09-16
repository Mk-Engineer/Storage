# 创建表
/* 方式1 */
CREATE TABLE IF NOT EXISTS myemp(
id INT,
emp_name VARCHAR(15),
hire_date DATE
);

/* 方式2 */
CREATE TABLE IF NOT EXISTS employees_copy
AS
SELECT * FROM employees;

/* 复制一个表，只保留表结构 */
CREATE TABLE IF NOT EXISTS employees_struct
AS
SELECT * FROM employees
WHERE 1 = 2;

SELECT * FROM employees_struct;
DESC employees_struct;

SHOW TABLES;



# 修改表: ALTER TABLE
DESC myemp;
/* 添加一个字段 */
ALTER TABLE myemp
ADD salary DOUBLE(10,2);/* 默认添加到表中末尾字段的位置 */

DESC myemp;

ALTER TABLE myemp
ADD phone_number VARCHAR(20) FIRST;

DESC myemp;

ALTER TABLE myemp
ADD email VARCHAR(45) AFTER emp_name;

DESC myemp;

/* 修改一个字段：数据类型、长度、默认值 */
ALTER TABLE myemp
MODIFY emp_name VARCHAR(25);

DESC myemp;

ALTER TABLE myemp
MODIFY emp_name VARCHAR(35) DEFAULT 'hekt';

DESC myemp;

/* 重命名一个字段 */
ALTER TABLE myemp
CHANGE salary monthly_salary DOUBLE(10,2);

DESC myemp;

ALTER TABLE myemp
CHANGE email my_email VARCHAR(50);/* 修改名称的同时,可以修改字段长度 */

DESC myemp;
/* 删除一个字段 */
ALTER TABLE myemp
DROP COLUMN my_email;

DESC myemp;


# 重命名表
/* 方式1 */
RENAME TABLE myemp
TO myempy;

SHOW TABLES;

/* 方式2 */
ALTER TABLE myempy
RENAME TO myemp;

SHOW TABLES;


# 删除表
/* 同时删除表结构和表数据，释放表空间 */
DROP TABLE IF EXISTS employees_struct;

SHOW TABLES;


# 清空表
/* 清空表数据，保留表结构 */
SELECT * FROM employees_copy;

TRUNCATE TABLE employees_copy;

SELECT * FROM employees_copy;

DESC employees_copy;


# COMMIT & ROLLBACK
/* COMMIT：提交数据。一旦执行COMMIT，则数据就被永久的保存在了数据库中，意味着数据不可以回滚。 */

/* ROLLBACK：回滚数据。一旦执行ROLLBACK，可以实现数据的回滚，回滚到最近的一次COMMIT之后 */


# 对比 TRUNCATE TABLE 和 DELETE FROM
/* 相同点：都可以实现对表中所有数据的删除，同时保留表结构 */

/* 不同点： */
/*      TRUNCATE TABLE：一旦执行此操作，表数据全部清除。同时，数据不可以回滚。 */
/*      DELETE FROM：一旦执行此操作，表数据可以全部清除。同时，数据可以回滚。 */

/* 
    # DDL 和 DML 的说明：
    1.DDL操作一旦执行，不可回滚。
    2.DML操作默认情况，一旦执行，也不可回滚。
      但是如果在执行 DML 之前，执行了 SET autocommit = FALSE ，则执行的 DML操作 可以实现回滚。
*/

/* 演示：DELETE FROM */
CREATE TABLE IF NOT EXISTS employees_bkup
AS
SELECT * FROM employees;

SHOW TABLES;

COMMIT;
SELECT * FROM employees_bkup;
SET autocommit = FALSE;

DELETE FROM employees_bkup;
SELECT * FROM employees_bkup;

ROLLBACK;
SELECT * FROM employees_bkup;