package com.omen.advanced;

import com.omen.advanced.pojo.Employee;
import org.junit.Test;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 0xhekt
 * @date 2024/5/19 - 23:18
 */
public class JDBCAdvanced {
    @Test
    public void testORM() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        PreparedStatement preparedStatement = connection.prepareStatement("SELECT emp_id,emp_name,emp_salary,emp_age FROM t_emp WHERE emp_id = ?");

        preparedStatement.setInt(1,1);

        ResultSet resultSet = preparedStatement.executeQuery();

        Employee employee = null;

        //ORM
        //封装单个对象
        if(resultSet.next()){
            employee = new Employee();

            int empId = resultSet.getInt("emp_id");
            String empName = resultSet.getString("emp_name");
            double empSalary = resultSet.getDouble("emp_salary");
            int empAge = resultSet.getInt("emp_age");

            //为对象的属性赋值
            employee.setEmpId(empId);
            employee.setEmpAge(empAge);
            employee.setEmpName(empName);
            employee.setEmpSalary(empSalary);
        }

        System.out.println(employee);

        resultSet.close();
        preparedStatement.close();
        connection.close();
    }

    @Test
    public void testORMList() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        PreparedStatement preparedStatement = connection.prepareStatement("SELECT emp_id,emp_name,emp_salary,emp_age FROM t_emp ");

        ResultSet resultSet = preparedStatement.executeQuery();

        Employee employee = null;

        List<Employee> employeeList = new ArrayList<>();

        while(resultSet.next()) {
            employee = new Employee();

            int empId = resultSet.getInt("emp_id");
            String empName = resultSet.getString("emp_name");
            double empSalary = resultSet.getDouble("emp_salary");
            int empAge = resultSet.getInt("emp_age");

            //为对象的属性赋值
            employee.setEmpId(empId);
            employee.setEmpAge(empAge);
            employee.setEmpName(empName);
            employee.setEmpSalary(empSalary);

            //将每次循环封装的一行数据的对象存储在集合里
            employeeList.add(employee);
        }

        //遍历集合
        for(Employee emp : employeeList){
            System.out.println(emp);
        }

        resultSet.close();
        preparedStatement.close();
        connection.close();
    }
}
