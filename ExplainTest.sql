# EXPLAIN

CREATE TABLE s1 (
    id INT AUTO_INCREMENT,
    key1 VARCHAR(100),
    key2 INT,
    key3 VARCHAR(100),
    key_part1 VARCHAR(100),
    key_part2 VARCHAR(100),
    key_part3 VARCHAR(100),
    common_field VARCHAR(100),
    PRIMARY KEY (id),
    INDEX idx_key1(key1),
    UNIQUE INDEX idx_key2(key2),
    INDEX idx_key3(key3),
    INDEX idx_key_part(key_part1,key_part2,key_part3)
) ENGINE=INNODB CHARSET=utf8;


CREATE TABLE s2 (
    id INT AUTO_INCREMENT,
    key1 VARCHAR(100),
    key2 INT,
    key3 VARCHAR(100),
    key_part1 VARCHAR(100),
    key_part2 VARCHAR(100),
    key_part3 VARCHAR(100),
    common_field VARCHAR(100),
    PRIMARY KEY (id),
    INDEX idx_key1(key1),
    UNIQUE INDEX idx_key2(key2),
    INDEX idx_key3(key3),
    INDEX idx_key_part(key_part1,key_part2,key_part3)
) ENGINE=INNODB CHARSET=utf8;

DELIMITER //
CREATE FUNCTION rand_string1(n INT)
    RETURNS VARCHAR(255) # 该函数返回字符串
BEGIN
     DECLARE chars_str VARCHAR(100) DEFAULT
     'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRESUVWXYZ';
     DECLARE return_str VARCHAR(255) DEFAULT '';
     DECLARE i INT DEFAULT 0;
     WHILE i < n DO
        SET return_str=CONCAT(return_str,SBSTRING(chars_str,FLOOR(1+RAND()*52),1));
        SET i = i + 1;
     END WHILE;
     RETURN return_str;
END //
DELIMITER ;

