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
USE dbtest;
/* 1. 如何查看表中的约束: */
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'employees';

/* 2. NOT NULL 非空约束的使用 */
/* 在CREATE TABLE时添加约束 */
DROP TABLE ConstraintTest;

CREATE TABLE IF NOT EXISTS ConstraintTest (
id INT NOT NULL,/* 列级约束 */
last_name VARCHAR(15) NOT NULL,
email VARCHAR(25),
salary DECIMAL(10,2),    

CONSTRAINT uni_ConstraintTest_email UNIQUE(email)/* 表级约束 */
);

TRUNCATE TABLE ConstraintTest;

INSERT INTO ConstraintTest(id,last_name,email,salary)
VALUES (1,'Tom','tom@126.com',3400);

INSERT INTO ConstraintTest(id,last_name,email,salary)
VALUES (2,'Jerry','jerry@126.com',4300);

INSERT INTO ConstraintTest(id,last_name,email,salary)
VALUES (3,'Jack','jack@126.com',5000);

-- UPDATE ConstraintTest
-- SET last_name = NULL
-- WHERE id = 1;

ALTER TABLE ConstraintTest
MODIFY email VARCHAR(25) NOT NULL;

DESC ConstraintTest;

ALTER TABLE ConstraintTest
MODIFY email VARCHAR(25) NULL;

DESC ConstraintTest;

SELECT * FROM ConstraintTest;


/* 3. UNIQUE 唯一性约束 */
DESC ConstraintTest;

/* 在ALTER TABLE时添加约束 */
ALTER TABLE ConstraintTest
ADD CONSTRAINT uni_ConstraintTest_sal UNIQUE(salary);

ALTER TABLE ConstraintTest
MODIFY id INT UNIQUE;

DESC ConstraintTest;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'ConstraintTest';
/* 在创建唯一约束时，如果不给唯一约束命名，就默认和列名相同 */


/* 4. 复合唯一性约束 */
DROP TABLE UserTest;
CREATE TABLE IF NOT EXISTS UserTest(
id INT,
`name` VARCHAR(15),
`password` VARCHAR(25),

CONSTRAINT uni_user_name_pwd UNIQUE(`name`,`password`)
);

INSERT INTO UserTest
VALUES(1,'Tom','abc');

INSERT INTO UserTest
VALUES(2,'Jerry','abc');

-- INSERT INTO UserTest
-- VALUES(3,'Tom','abc');
/* 复合唯一性约束 UNIQUE 作用于 name 和 password 完全相同的情况 */

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'UserTest';

DESC UserTest;

/* 复合性约束的案例 */
/* 学生表 */
DROP TABLE student;
CREATE TABLE IF NOT EXISTS student(
	sid INT,	/* 学号 */
    sname VARCHAR(20),		  /* #姓名 */
    tel CHAR(11) UNIQUE KEY,  /* 电话 */
    cardid CHAR(18) UNIQUE KEY /* 身份证号 */
);

/* 课程表 */
DROP TABLE course;
CREATE TABLE IF NOT EXISTS course(
	cid INT,              /* 课程编号 */
    cname VARCHAR(20)     /* 课程名称 */
);

/* 选课表 */
DROP TABLE student_course;
CREATE TABLE IF NOT EXISTS student_course(
    id INT,
	sid INT,
    cid INT,
    score INT,
    UNIQUE KEY(sid,cid)  /* 复合唯一 */
);

INSERT INTO student VALUES(1,'ZHANG SAN','13710011002','101223199012015623');/* 成功 */
INSERT INTO student VALUES(2,'LI SI','13710011003','101223199012015624');/* 成功 */
INSERT INTO course VALUES(1001,'Java'),(1002,'MySQL');/* 成功 */

SELECT * FROM student;
SELECT * FROM course;

INSERT INTO student_course VALUES
(1, 1, 1001, 89),
(2, 1, 1002, 90),
(3, 2, 1001, 88),
(4, 2, 1002, 56);/* 成功 */

SELECT * FROM student_course;

-- INSERT INTO student_course VALUES (5, 1, 1001, 88);/* 失败 */


/* 5. 删除唯一性约束 */
/* 
- 添加唯一性约束的列上也会自动创建唯一索引。
- 删除唯一约束只能通过删除唯一索引的方式删除。
- 删除时需要指定唯一索引名，唯一索引名就和唯一约束名一样。
- 如果创建唯一约束时未指定名称，如果是单列，就默认和列名相同；如果是组合列，那么默认和()中排在第一个的列名相同。也可以自定义唯一性约束名。 
*/

/* 查询唯一性约束 */
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'ConstraintTest';

/* 删除唯一性约束 */
ALTER TABLE ConstraintTest
DROP INDEX uni_ConstraintTest_sal;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'ConstraintTest';

