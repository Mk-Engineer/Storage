package com.omen.base;

import org.junit.Test;

import java.sql.*;

/**
 * @author 0xhekt
 * @date 2024/5/16 - 23:13
 */
public class JDBCOperation {
    //单行单列
    @Test
    public void testQuerySingleRowAndCol() throws SQLException {
        //1.注册驱动-省略

        //2.获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        //3.预编译SQL语句得到PreparedStatement对象
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT COUNT(*) AS count FROM t_emp");

        //4.执行SQL语句，获取结果
        ResultSet resultSet = preparedStatement.executeQuery();

        //5.遍历结果
        while(resultSet.next()){
            int count = resultSet.getInt("count");
            System.out.println(count);
        }

        //6.释放资源
        resultSet.close();
        preparedStatement.close();
        connection.close();
    }

    //单行多列
    @Test
    public void testQuerySingleRow() throws SQLException {
        //1.注册驱动-省略

        //2.获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        //3.预编译SQL语句得到PreparedStatement对象
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT emp_id,emp_name,emp_salary,emp_age FROM t_emp WHERE emp_id = ?");

        //4.执行SQL语句，获取结果
        //为占位符赋值
        preparedStatement.setInt(1,5);
        ResultSet resultSet = preparedStatement.executeQuery();

        //5.遍历结果
        while(resultSet.next()){
            int empId = resultSet.getInt("emp_id");
            String empName = resultSet.getString("emp_name");
            double empSalary = resultSet.getDouble("emp_salary");
            int empAge = resultSet.getInt("emp_age");

            System.out.println(empId + "\t" + empName + "\t" + empSalary + "\t" + empAge);
        }

        //6.关闭资源
        resultSet.close();
        preparedStatement.close();
        connection.close();
    }

    //多行多列
    @Test
    public void testQueryMoreRow() throws SQLException {
        //1.注册驱动-省略

        //2.获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        //3.预编译SQL语句得到PreparedStatement对象
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT emp_id,emp_name,emp_salary,emp_age FROM t_emp WHERE emp_age > ?");

        //4.执行SQL语句，获取结果
        //为占位符赋值
        preparedStatement.setInt(1,25);
        ResultSet resultSet = preparedStatement.executeQuery();

        //5.遍历结果
        while(resultSet.next()){
            int empId = resultSet.getInt("emp_id");
            String empName = resultSet.getString("emp_name");
            double empSalary = resultSet.getDouble("emp_salary");
            int empAge = resultSet.getInt("emp_age");

            System.out.println(empId + "\t" + empName + "\t" + empSalary + "\t" + empAge);
        }

        //6.关闭资源
        resultSet.close();
        preparedStatement.close();
        connection.close();
    }

    //新增功能
    @Test
    public void testInsert() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO t_emp(emp_name,emp_salary,emp_age) VALUES(?,?,?)");

        preparedStatement.setString(1,"Rose");
        preparedStatement.setDouble(2,345.67);
        preparedStatement.setInt(3,28);

        int result = preparedStatement.executeUpdate();

        //根据受影响行数做判断，得到成功或失败
        if(result > 0){
            System.out.println("success");
        } else {
            System.out.println("failure");
        }

        preparedStatement.close();
        connection.close();
    }
}
