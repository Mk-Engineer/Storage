# 13 多表查询
SELECT 'COMMENT #1'
FROM DUAL;

SELECT * FROM employees;

/*
笛卡尔积错误产生的条件：
    省略多表连接的条件，或连接条件无效
    为避免，可以通过WHERE加入有效的连接条件
*/

/* 注意：从SQL 优化 的角度，建议在多表查询时，每个字段前都指明其所在的表 */
SELECT employee_id,department_name,employees.department_id /* 注意：如果查询语句中出现了多个表中都存在的字段，必须指明该字段所在的表 */
FROM employees,departments
/* 两个表连接的条件 */
WHERE employees.`department_id` = departments.`department_id`;

/* 对表起别名，在SELECT和WHERE中使用表的别名 */
SELECT emp.employee_id,dept.department_name,emp.department_id 
FROM employees emp,departments dept
WHERE emp.`department_id` = dept.`department_id`;/* 注意：如果给表起了别名，以但在SELECT或WHERE使用表明的话，必须使用表的别名，不能再使用表的原名 */

/* 如果有N个表实现多表查询，则需要(至少)有N-1个连接条件，连接符为 AND*/
SELECT employee_id,last_name,department_name,city
FROM employees e,departments d,locations l
WHERE e.`department_id` = d.`department_id` AND d.`location_id` = l.`location_id`;

# 14 多表查询的分类
/*
    1：等值连接 vs 非等值连接
    2：自连接 vs 非自连接
    3：内连接 vs 外连接
*/

# 14.1 等值连接 vs 非等值连接
/* 非等值连接 */
SELECT * 
FROM job_grades;

SELECT last_name,salary,grade_level
FROM employees e,job_grades j
WHERE e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`;

# 14.2 自连接 vs 非自连接
/* 自连接 */
SELECT emp.employee_id,emp.last_name,mgr.employee_id,mgr.last_name
FROM employees emp,employees mgr
WHERE emp.`manager_id` = mgr.`employee_id`;

/* 验证 */
SELECT * 
FROM employees
WHERE last_name = 'Mavris';

SELECT * 
FROM employees
WHERE employee_id = 101; #'Kochhar'

# 14.3 内连接 vs 外连接
/* 内连接： 结果集中只包含了 左右表 中 满足连接条件 的数据，其他数据均舍弃 */
SELECT employee_id,department_name
FROM employees e,departments d  /*其他数据：有的员工没部门，有的部门没员工*/
WHERE e.`department_id` = d.`department_id`;

/* 外连接：结果集中除了包含 左右表 中 满足连接条件 的数据之外，还查询到了左表 或 右表中 不匹配 的行*/
/* 外连接分类：左外连接、右外连接、满外连接 */

/* 练习：查询所有员工的last_name,department_name信息 */
/* SQL92语法实现内连接 */
SELECT last_name,department_name
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`;
/* SQL92语法实现外连接：使用 + */
/* MySQL 不支持SQL92的外连接写法 */
/* WHERE e.`department_id` = d.`department_id`(+); */ 
/* WHERE e.`department_id`(+) = d.`department_id`; */

/* SQL99语法实现内连接：使用 JOIN ON */
SELECT last_name,department_name/*,city*/
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;
/*JOIN locations l
ON d.`location_id` = l.`location_id`;*/

/* SQL99语法实现外连接：使用 JOIN ON */
/* 左外连接 */
SELECT last_name,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* 右外连接 */
SELECT last_name,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* 满外连接 */
SELECT last_name,department_name
FROM employees e JOIN departments d /*见：#6 满外连接 line136 */
/* FROM employees e FULL JOIN departments d */ /* MySQL 不支持SQL99 FULL JOIN 的满外连接的语法 */
ON e.`department_id` = d.`department_id`;

/* UNION 合并查询结果 */
/* UNION ALL 合并查询结果,交集重复计算一次 */
/* UNION ALL 效率更高，推荐使用 */
/* UNION 会执行去重的操作，UNION ALL 不会执行去重的操作 */

# 15 七种 JOIN 的实现
/* #1 内连接 */
SELECT employee_id,department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

/* #2 左外连接 */
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* #3 右外连接 */
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;

/* #4 左外连接，去掉交集 */
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL;

/* #5 右外连接，去掉交集 */
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

/* #6 满外连接 */
/* 方式一：左外连接 UNION ALL 右外连接，去掉交集*/
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`

UNION ALL

SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

/* 方式二：右外连接 UNION ALL 左外连接，去掉交集*/
SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`

UNION ALL

SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL;

/* #7 满外连接,去掉交集 */
SELECT employee_id,department_name
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL

UNION ALL

SELECT employee_id,department_name
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;


# 16 SQL99 新特性 NATURAL JOIN
SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
AND e.`manager_id` = d.`manager_id`;

/* 等价 */

SELECT employee_id,last_name,department_name
FROM employees e NATURAL JOIN departments d;


# 17 SQL99 新特性 USING
SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

SELECT employee_id,last_name,department_name
FROM employees e JOIN departments d
USING (department_id);/* 注意：不适用于自连接, USING()内必须填写同名的字段 */

/* 可以查看employees表的所有Field */

/* 注意：起别名用 "name" 符号修饰 */
SELECT emp.last_name "employees",emp.employee_id "Emp#",mgr.last_name "manager",mgr.employee_id "Mgr#"
FROM employees emp LEFT JOIN employees mgr /* FROM 后的别名吗，不能用 "name" 符号修饰 */
ON emp.manager_id = mgr.employee_id;

DESC employees;
DESC departments;
DESC locations;

/* 练习：查询哪些城市没有部门 */
SELECT d.department_name,l.city
FROM departments d RIGHT JOIN locations l
ON l.`location_id` = d.`location_id`
WHERE d.department_id IS NULL; /* 存在NULL 的集合是较小集合 */

/* 练习：查询哪些部门没有员工 */
SELECT d.department_name,e.employee_id
FROM departments d LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`department_id` IS NULL;


# 18 单行函数
# 18.1 数值函数
/* CEIL(X)\CEILING(X) 天花板函数：取距X最近，比X大的整数。 */
/* FLOOR(X) 地板函数：取距X最近，比X小的整数 */
SELECT ABS(-123),ABS(32),SIGN(-23),SIGN(43),PI(),CEIL(32.32),CEILING(-43.23),FLOOR(32.32),FLOOR(-43.23),MOD(12,5)
FROM DUAL;

/* RAND(X) 两个RAND的X相等，取到的随机数也相等 */
SELECT RAND(),RAND(),RAND(10),RAND(10),RAND(-1),RAND(-1)
FROM DUAL;

/* 四舍五入 */
SELECT ROUND(123,456),ROUND(123.456,2),ROUND(123.456,-1) /* ROUND(小数，保留几位小数) */
FROM DUAL;

/* 截断操作 */
SELECT TRUNCATE(123.456,2),TRUNCATE(123.456,-1)
FROM DUAL;

/* 单行函数嵌套 */
SELECT TRUNCATE(ROUND(123.456,2),-1)
FROM DUAL;

/* 
    角度与弧度换算:
        RADIANS(X)：将X转化为弧度
        DEGREES(X) ：将X转化为角度
*/
SELECT RADIANS(30),RADIANS(45),RADIANS(60),RADIANS(90),DEGREES(2*PI()),DEGREES(RADIANS(60)),DEGREES(PI()*3/4)
FROM DUAL;

/* 三角函数 */
SELECT SIN(PI()/6),DEGREES(ASIN(1/2)),TAN(PI()/4),DEGREES(ATAN(1))
FROM DUAL;

/* 指数 */
SELECT POW(2,5) "2^5",POWER(2,4) "2^4",EXP(2) "e^2"
FROM DUAL;

/* 对数 */
SELECT LN(EXP(2)) "ln(e^2)",LOG(EXP(2)) "ln(e^2)",LOG10(POW(10,3)) "log10(10^3)",LOG2(4) "log2(4)"
FROM DUAL;

/* 进制转换 */
SELECT BIN(10),HEX(10),OCT(10),CONV(10,2,8)/* CONV(X,F1,F2)：X为F1进制的数字，返回X的F2进制的转换结果 */
FROM DUAL;

# 18.2 字符串函数
SELECT ASCII('Abc') /* 只返回第一个字符的 ASCII 值 */
FROM DUAL;

/* 一个字母占一个字节，一个汉字占3个字节 */
SELECT CHAR_LENGTH('HELLO'),CHAR_LENGTH('我们'),LENGTH('HELLO'),LENGTH('我们')
FROM DUAL;

/* CONCAT() 连接字符 */
SELECT CONCAT(emp.last_name,' worked for',mgr.last_name) "detials"
FROM employees emp JOIN employees mgr
WHERE emp.`manager_id` = mgr.`manager_id`;

/* CONCAT_WS(分隔符，待连接字符1，待连接字符2，...) */
SELECT CONCAT_WS('-','HELLO','WORLD','HELLO','BEIJING')
FROM DUAL;

/* INSERT('待替换字符',插入位置,替换个数,'替换内容') */
/* REPLACE('待替换字符串','待替换字串','替换内容') */
/* 注意：字符串的索引是从 1 开始的 */
SELECT INSERT('HELLOWORLD',2,3,'aaaaa'),REPLACE('HELLO','LL','MM')
FROM DUAL;

SELECT UPPER('hello'),LOWER('WORLD')
FROM DUAL;

SELECT LEFT('HELLO',2),RIGHT('HELLO',3),RIGHT('HELLO',13)
FROM DUAL;

/* 右对齐 LPAD(待补充内容，补足位数，'填充符号') */
/* 左对齐 RPAD(待补充内容，补足位数，'填充符号') */
SELECT employee_id,last_name,LPAD(salary,10,'*')
FROM employees;

/* 去除空格 */
SELECT TRIM('    H EL  LO   ') "result"/* 去除两端的空格 */
FROM DUAL;
SELECT LTRIM('    H EL  LO   ') "result"/* 去除左端的空格 */
FROM DUAL;
SELECT RTRIM('    H EL  LO   ') "result"/* 去除右端的空格 */
FROM DUAL;

SELECT TRIM('O' FROM 'OHEOLO') "RESULT" /* 去除两端的＇OO＇*/
FROM DUAL;
/* TRIM(LEADING s1 FROM s) */
/* TRIM(TRAILING s1 FROM s) */

/* 重复 */
SELECT REPEAT('HELLO',4),SPACE(5) "12345",SPACE(10) "0123456789",STRCMP('abc','abe')/* STRCMP(s1,s2) 比较字符串s1和s2的ASCII码大小 */
FROM DUAL;

SELECT SUBSTR('HELLO',2,2)
FROM DUAL;

/* LOCATE(substr,str) 返回substr在str中首次出现的位置 */
SELECT LOCATE('l','hello')
FROM DUAL;

/* 返回字符串列表中指定位置的字符串 */
SELECT ELT(2,'A','B','C','D')
FROM DUAL;

/* 返回字符串s在字符串列表中第一次出现的位置 */
SELECT FIELD('MM','GG','JJ','MM','DD','MM')
FROM DUAL;

SELECT FIND_IN_SET('MM','GG,JJ,MM,DD,MM')
FROM DUAL;

/* REVERSE(s) 反转字符串 */

/* NULLIF(s1,s2) 如果s1=s2返回NULL，否饭返回s1 */
SELECT employee_id,NULLIF(LENGTH(last_name),LENGTH(first_name))
FROM employees; 

# 19 日期和时间函数

SELECT UNIX_TIMESTAMP(),FROM_UNIXTIME(UNIX_TIMESTAMP()) /* 时间戳，时间戳的格式化*/
FROM DUAL;

/* EXTRACT(type from date) */
SELECT EXTRACT(SECOND FROM NOW()),EXTRACT(HOUR_MINUTE FROM NOW())
FROM DUAL;

/* 计算日期和时间的函数 */
SELECT NOW(),DATE_ADD(NOW(),INTERVAL 1 HOUR),DATE_ADD(NOW(),INTERVAL -1 HOUR),DATE_ADD(NOW(),INTERVAL '1_1' MINUTE_SECOND)
FROM DUAL;
/* DATE_SUB(NOW(),INTERVAL 1 HOUR) */

SELECT CURDATE(),CURDATE() + 0
FROM DUAL;

SELECT *
FROM employees
WHERE hire_date = DATE_FORMAT('19930113','%Y-%m-%d');

SELECT CURDATE(),DATE_FORMAT(CURDATE(),'%Y-%M-%D')
FROM DUAL;

SELECT CURDATE(),DATE_FORMAT(CURDATE(),GET_FORMAT(DATE,'USA'))
FROM DUAL;