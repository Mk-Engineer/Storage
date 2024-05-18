package com.omen.base;

import com.mysql.cj.jdbc.Driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @author 0xhekt
 * @date 2024/5/2 - 21:21
 */
public class JDBCQuick {
    public static void main(String[] args) throws Exception {
        //1.注册驱动（从JDK6开始自动注册驱动）
//      Class.forName("com.mysql.cj.jdbc.Driver");
//      DriverManager.registerDriver(new Driver());

        //2.获取连接对象
        String url = "jdbc:mysql://localhost:3306/dbtest";
        String username = "root";
        String password = "0000";
        Connection connection = DriverManager.getConnection(url, username, password);

        //3.获取执行SQL语句的对象
        Statement statement = connection.createStatement();

        //4.编写SQL语句并执行
        String sql = "SELECT * FROM t_emp";
        ResultSet resultSet = statement.executeQuery(sql);//接收返回的结果集

        //5.处理结果，便利resultSet结果集
        while (resultSet.next()){
            int empId = resultSet.getInt("emp_id");
            String empName = resultSet.getString("emp_name");
            double empSalary = resultSet.getDouble("emp_salary");
            int empAge = resultSet.getInt("emp_age");

            System.out.println(empId + "\t" + empName + "\t" + empSalary + "\t" + empAge);
        }

        //6. 释放资源（先卡后关）
        resultSet.close();
        statement.close();
        connection.close();
    }
}
