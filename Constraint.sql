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
id INT PRIMARY KEY AUTO_INCREMENT,/* 列级约束 */
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

INSERT INTO ConstraintTest(last_name,email)
VALUES ('Mary','mary@126.com');/* 主键约束PRIMARY KEY / 自增长列AUTO_INCREMENT */

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

-- 添加唯一性约束的列上也会自动创建唯一索引。
-- 删除唯一约束只能通过删除唯一索引的方式删除。
-- 删除时需要指定唯一索引名，唯一索引名就和唯一约束名一样。
-- 如果创建唯一约束时未指定名称，如果是单列，就默认和列名相同；如果是组合列，那么默认和()中排在第一个的列名相同。也可以自定义唯一性约束名。 


/* 查询唯一性约束 */
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'ConstraintTest';

/* 删除唯一性约束 */
ALTER TABLE ConstraintTest
DROP INDEX uni_ConstraintTest_sal;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'ConstraintTest';


/* 6. 主键约束 */
/* 相当于唯一约束 UNIQUE + 非空约束 NOT NULL：不允许重复，也不允许出现NULL */

/* 7. AUTO_INCREMENT */
/* 自增长列，主要用于主键 */
/* 手动添加 AUTO_INCREMENT */
ALTER TABLE ConstraintTest
MODIFY id INT AUTO_INCREMENT;

DESC ConstraintTest;
/* 删除 AUTO_INCREMENT */

ALTER TABLE ConstraintTest
MODIFY id INT;

DESC ConstraintTest;


/* 8. FOREIGN KEY约束 */
/* 外键约束不能跨引擎使用 */
/* 先删除从表，再删除主表 */
DROP TABLE emp_test;
DROP TABLE dept_test;
/* 创建主表 */
CREATE TABLE IF NOT EXISTS dept_test(
dept_id INT,/* 必须有主键约束 / 唯一性约束 */
dept_name VARCHAR(15)
);

/* 为主表添加主键约束 */
ALTER TABLE dept_test
ADD PRIMARY KEY (dept_id);

DESC dept_test;

/* 创建从表 */
CREATE TABLE IF NOT EXISTS emp_test(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(15),
department_id INT,
salary DECIMAL(10,2) CHECK(salary > 2000) DEFAULT 7000,

/* 表级约束 */
CONSTRAINT fk_emp_dept_id FOREIGN KEY(department_id) REFERENCES dept_test(dept_id) ON UPDATE CASCADE ON DELETE SET NULL
);

DESC emp_test;

/* 查询唯一性约束 */
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'emp_test';

/* 演示外键效果 */
/* 先在主表中添加10号部门 */
INSERT INTO dept_test
VALUES(10,'IT');
INSERT INTO emp_test(emp_id,emp_name,department_id)
VALUES(1001,'Tom',10);/* 自动补充 DEFAULT */

/* 在ALTER TABLE时，添加外键约束 */
-- ALTER TABLE emp_test
-- ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY(department_id) REFERENCES (dept_id);


/* 约束等级 */
-- Cascade方式：在父表update/delete记录时，同步update/delete掉子表的匹配记录
-- Set null方式：在父表上update/delete，将子表上匹配记录的列设为NULL，但是要注意子表的外键列不能为 NOT NULL
-- No action方式：如果子表中有匹配的记录，则不允许父表对应候选键进行update/delete操作
-- Restrict方式：同no action，都是立即检查外键约束
-- Set default方式：父表中有变更时，子表将外键列设置成一个默认的值，但Innodb不能识别

-- 如果没有指定等级，默认为Restrict方式
-- 对于外键约束，最好是采用：ON UPDATE CASCADE ON DELETE RESTRICT 的方式

INSERT INTO dept_test
VALUES(1001,'Education');
INSERT INTO dept_test
VALUES(1002,'Treasury');
INSERT INTO dept_test
VALUES(1003,'Consultation');

INSERT INTO emp_test
VALUES(1,'Jack',1001,3500);
INSERT INTO emp_test
VALUES(2,'Mary',1002,4000);
INSERT INTO emp_test
VALUES(3,'Jerry',1003,4500);

SELECT * FROM dept_test;
SELECT * FROM emp_test;

/* ON UPDATE CASCADE ON DELETE SET NULL 演示 */
UPDATE dept_test
SET dept_id = 1004
WHERE dept_id = 1002;

SELECT * FROM dept_test;
SELECT * FROM emp_test;

DELETE FROM dept_test
WHERE dept_id = 1004;

SELECT * FROM dept_test;
SELECT * FROM emp_test;

/* 删除外键约束 */
/* 一个表中可以声明多个外键约束，删除时必须指明外键约束名 */
ALTER TABLE emp_test
DROP FOREIGN KEY fk_emp_dept_id;

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'emp_test';

/* 删除外键约束对应的普通索引 */
SHOW INDEX FROM emp_test;

ALTER TABLE emp_test
DROP INDEX fk_emp_dept_id;

SHOW INDEX FROM emp_test;

/* 阿里规范：不使用外键与级联，一切外键概念在应用层解决 */

/* 9. CHECK 约束 */
-- salary DECIMAL(10,2) CHECK(salary > 2000)

/* 10. DEFAULT 约束 */
ALTER TABLE emp_test
MODIFY salary DECIMAL(8,2) DEFAULT 2700;

DESC emp_test;

/* 删除约束 */
ALTER TABLE emp_test
MODIFY salary DECIMAL(8,2);

DESC emp_test;