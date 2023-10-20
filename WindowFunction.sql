# 窗口函数
use dbtest;

CREATE TABLE IF NOT EXISTS sales(
id INT PRIMARY KEY AUTO_INCREMENT,
city VARCHAR(15),
county VARCHAR(15),
sales_value DECIMAL

);

INSERT INTO sales(city,county,sales_value)
VALUES
('Beijing','HaiDian',10.00),
('Beijing','ChaoYang',20.00),
('Shanghai','HuangPu',30.00),
('Shanghai','ChangNing',10.00);

SELECT * FROM sales;
-- 需求：现在计算这个网站在每个城市的销售总额、在全国的销售总额、
--      每个区的销售额占所在城市销售额中的比率，以及占总销售额中的比率。
/* 传统方式 */
-- 1 创建临时表
-- 总销售金额
CREATE TABLE IF NOT EXISTS a               -- 创建临时表
SELECT SUM(sales_value) AS sales_value -- 计算总计金额
FROM sales;

SELECT * FROM a;

-- 每个城市销售总额
CREATE TABLE IF NOT EXISTS b                     -- 创建临时表
SELECT city,SUM(sales_value) AS sales_value  -- 计算城市销售合计
FROM sales
GROUP BY city;

SELECT * FROM b;

-- 计算最终结果
SELECT s.city AS city,s.county AS county,s.sales_value AS county_sales,
b.sales_value AS city_sales,s.sales_value/b.sales_value AS city_rate,
a.sales_value AS sum_sales,s.sales_value/a.sales_value AS sum_rate
FROM sales s
JOIN b ON (s.city=b.city) -- 连接市统计结果临时表
JOIN a                    -- 连接总计金额临时表
ORDER BY s.city,s.county;

DROP TABLE a;
DROP TABLE b;

/* 窗口函数 */
SELECT city AS CITY,county AS COUNTY,sales_value AS COUNTY_SALES,
SUM(sales_value) OVER(PARTITION BY city) AS CITY_SALES,  -- 计算市销售额
sales_value/SUM(sales_value) OVER(PARTITION BY city) AS CITY_RATE,
SUM(sales_value) OVER() AS SUM_RATE,                   -- 计算总销售额
sales_value/SUM(sales_value) OVER() AS SUM_RATE
FROM sales
ORDER BY city,county;

TRUNCATE TABLE sales;
DROP TABLE sales;


/* 窗口函数介绍 */
CREATE TABLE IF NOT EXISTS goods(
id INT PRIMARY KEY AUTO_INCREMENT,
category_id INT,
category VARCHAR(15),
`NAME` VARCHAR(30),
price DECIMAL(10,2),
stock INT,
upper_time DATETIME
);

TRUNCATE TABLE goods;

INSERT INTO goods(category_id,category,NAME,price,stock,upper_time)
VALUES
(1, 'FemaleSuit', 'T-Shirt', 39.90, 1000, '2020-11-10 00:00:00'),
(1, 'FemaleSuit', 'dress', 79.90, 2500, '2020-11-10 00:00:00'),
(1, 'FemaleSuit', 'jacket', 89.90, 1500, '2020-11-10 00:00:00'),
(1, 'FemaleSuit', 'jeans', 89.90, 3500, '2020-11-10 00:00:00'),
(1, 'FemaleSuit', 'skirt', 29.90, 500, '2020-11-10 00:00:00'),
(1, 'FemaleSuit', 'WoollenOutfit', 399.90, 1200, '2020-11-10 00:00:00'),
(2, 'OutdoorSport', 'bike', 399.90, 1000, '2020-11-10 00:00:00'),
(2, 'OutdoorSport', 'bicycle', 1399.90, 2500, '2020-11-10 00:00:00'),
(2, 'OutdoorSport', 'stick', 59.90, 1500, '2020-11-10 00:00:00'),
(2, 'OutdoorSport', 'equipment', 399.90, 3500, '2020-11-10 00:00:00'),
(2, 'OutdoorSport', 'SportOutfit', 799.90, 500, '2020-11-10 00:00:00'),
(2, 'OutdoorSport', 'skateboard', 499.90, 1200, '2020-11-10 00:00:00');

SELECT * FROM goods;

/* ROW_NUMBER()函数 */
-- 举例：查询 goods 数据表中每个商品分类下价格降序排列的各个商品信息。
SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, `NAME`, price, stock
FROM goods;


-- 举例：查询 goods 数据表中每个商品分类下价格最高的3种商品信息。
SELECT *
FROM (
SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, NAME, price, stock
FROM goods) t
WHERE row_num <= 3;

/* RANK()函数 */
-- 举例：使用RANK()函数获取 goods 数据表中各类别的价格从高到低排序的各商品信息。
SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, NAME, price, stock
FROM goods;

/* DENSE_RANK()函数 */
SELECT DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, NAME, price, stock
FROM goods;

/* 分布函数 */
/* PERCENT_RANK()函数 */
-- 举例：计算 goods 数据表中名称为“FemaleSuit”的类别下的商品的PERCENT_RANK值。
--      等级值百分比计算公式： (rank - 1) / (rows - 1)
-- 写法1
SELECT RANK() OVER w AS r,
PERCENT_RANK() OVER w AS pr,
id, category_id, category, NAME, price, stock
FROM goods
WHERE category_id = 1 WINDOW w AS (PARTITION BY category_id ORDER BY price DESC);
-- 写法2
SELECT RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS r,
PERCENT_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS pr,
id, category_id, category, NAME, price, stock
FROM goods
WHERE category_id = 1;

/* CUME_DIST()函数 */
-- 举例：查询goods数据表中小于或等于当前价格的比例。
SELECT CUME_DIST() OVER(PARTITION BY category_id ORDER BY price ASC) AS cd,
id, category, NAME, price
FROM goods;

/* 前后函数 */
/* LAG(expr,n)函数 */
-- 举例：查询goods数据表中前一个商品价格与当前商品价格的差值。
SELECT id, category, NAME, price, pre_price, price - pre_price AS diff_price
FROM (
SELECT  id, category, NAME, price,LAG(price,1) OVER w AS pre_price
FROM goods
WINDOW w AS (PARTITION BY category_id ORDER BY price)) t;

/* LEAD(expr,n)函数 */
-- 举例：查询goods数据表中后一个商品价格与当前商品价格的差值。
SELECT id, category, NAME, behind_price, price,behind_price - price AS diff_price
FROM(
SELECT id, category, NAME, price,LEAD(price, 1) OVER w AS behind_price
FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price)) t;

/* 首尾函数 */
/* FIRST_VALUE(expr)函数 */
-- 举例：按照价格排序，查询第1个商品的价格信息。
SELECT id, category, NAME, price, stock,FIRST_VALUE(price) OVER w AS first_price
FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);

/* LAST_VALUE(expr)函数 */
-- 举例：按照价格排序，查询最后一个商品的价格信息。
SELECT id, category, NAME, price, stock,LAST_VALUE(price) OVER w AS last_price
FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);

/* 其他函数 */
/* NTH_VALUE(expr,n)函数 */
-- 举例：查询goods数据表中排名第2和第3的价格信息。
SELECT id, category, NAME, price,NTH_VALUE(price,2) OVER w AS second_price,
NTH_VALUE(price,3) OVER w AS third_price
FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);

/* NTILE(n)函数 */
-- 举例：将goods表中的商品按照价格分为3组。
SELECT NTILE(3) OVER w AS nt,id, category, NAME, price
FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);