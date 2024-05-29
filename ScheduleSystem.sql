SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- -------------------
-- 创建日程表
-- -------------------
DROP TABLE IF EXISTS `sys_schedule`;
CREATE TABLE `sys_schedule`(
    `sid` INT NOT NULL AUTO_INCREMENT,
    `uid` INT NULL DEFAULT NULL,
    `title` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `completed` INT(1) NULL DEFAULT NULL,
    PRIMARY KEY (`sid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- -------------------
-- 插入日志数据
-- -------------------

-- -------------------
-- 创建用户表
-- -------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`(
    `uid` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `user_pwd` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    PRIMARY KEY (`uid`) USING BTREE,
    UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- -------------------
-- 插入用户数据
-- -------------------
-- ``
INSERT INTO `sys_user` VALUES(1,'zhangsan','e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `sys_user` VALUES(2,'lisi','e10adc3949ba59abbe56e057f20f883e');

SET FOREIGN_KEY_CHECKS = 1;