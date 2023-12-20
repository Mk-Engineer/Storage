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



