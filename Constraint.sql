# 约束
/* 概念：对表中字段的限制 */
/* 作用：保持数据的完整性 */

/* 
    约束的分类：
    角度一：约束的字段个数 -> 单列约束 & 多列约束
    角度二：约束的作用范围 -> 列级约束 & 表级约束 
        列级约束：将约束声明在对应字段的后面
        表级约束：在表中所有字段都声明完，在所有字段后声明的约束
    角度三：约束的功能
        ① NOT NULL 非空约束
        ② UNIQUE 唯一性约束
        ③ PRIMARY KEY 主键约束
        ④ FOREIGN KEY 外键约束
        ⑤ CHECK 检查约束
        ⑥ DEFAULT 默认值约束
*/

/* 
    如何添加约束：
        CREATE TABLE时添加约束
        ALTER TABLE时添加约束 / 删除约束
*/

/* 1. 如何查看表中的约束: */
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'employees';

/* 2. NOT NULL 非空约束的使用 */
/*  I 在CREATE TABLE时添加约束 */
CREATE TABLE IF NOT EXISTS ConstraintTest (
id INT NOT NULL,
last_name VARCHAR(15) NOT NULL,
email VARCHAR(25),
salary DECIMAL(10,2)    
);

TRUNCATE TABLE ConstraintTest;

INSERT INTO ConstraintTest(id,last_name,email,salary)
VALUES (1,'Tom','tom@126.com',3400);

INSERT INTO ConstraintTest(id,last_name,email,salary)
VALUES (2,'Jerry','jerry@126.com',4300);

UPDATE ConstraintTest
SET last_name = NULL
WHERE id = 1;

ALTER TABLE ConstraintTest
MODIFY email VARCHAR(25) NOT NULL;

DESC ConstraintTest;

SELECT * FROM ConstraintTest;

