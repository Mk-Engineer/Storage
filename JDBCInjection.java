package com.omen.base;

import java.sql.*;
import java.util.Scanner;
import java.util.stream.Stream;

/**
 * @author 0xhekt
 * @date 2024/5/12 - 23:25
 */

/* SQL注入问题演示 */
/* 输入abc' or '1' = '1 */
/* SELECT emp_id,emp_name,emp_salary,emp_age FROM t_emp WHERE emp_name = 'abc' OR '1' = '1' */

public class JDBCInjection {
    public static void main(String[] args) throws Exception {
        //1.注册驱动(省略)

        //2.获取连接对象
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        //3.获取执行SQL语句的对象
        Statement statement = connection.createStatement();

        System.out.println("请输入员工姓名：");
        Scanner scanner = new Scanner(System.in);
        String name = scanner.nextLine();

        //4.编写SQL语句，并执行、接收返回的结果
        String sql = "SELECT emp_id,emp_name,emp_salary,emp_age FROM t_emp WHERE emp_name = '"+name+"'";
        ResultSet resultSet = statement.executeQuery(sql);

        //5.处理结果，便利resultSet结果集
        while (resultSet.next()){
            int empId = resultSet.getInt("emp_id");
            String empName = resultSet.getString("emp_name");
            double empSalary = resultSet.getDouble("emp_salary");
            int empAge = resultSet.getInt("emp_age");

            System.out.println(empId + "\t" + empName + "\t" + empSalary + "\t" + empAge);
        }

        //6. 释放资源（先开后关）
        resultSet.close();
        statement.close();
        connection.close();
    }

}
