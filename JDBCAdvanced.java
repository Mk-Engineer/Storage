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

    /*
    * 主键回显
    *   在Java程序中获取数据库中插入新数据后的主键值，并赋值给Java对象
    */
    @Test
    public void testReturnPK() throws SQLException {
        //获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        //预编译SQL语句，告知preparedStatement，返回新增数据的主键列的值
        String sql = "INSERT INTO t_emp(emp_name,emp_salary,emp_age) VALUES(?,?,?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);

        //创建对象，将对象的属性值，填充在?占位符上(ORM)
        Employee employee = new Employee(null,"Jack",123.45,29);
        preparedStatement.setString(1,employee.getEmpName());
        preparedStatement.setDouble(2,employee.getEmpSalary());
        preparedStatement.setInt(3,employee.getEmpAge());

        //执行SQL，并获取返回结果
        int result = preparedStatement.executeUpdate();
        ResultSet resultSet = null;

        //处理结果
        if(result > 0){
            System.out.println("SUCCESS");
            //获取当前新增数据的主键值，回显到Java中employee对象的empId属性上
            //返回的主键值是一个单行单列的结果
            resultSet = preparedStatement.getGeneratedKeys();
            if(resultSet.next()){
                int empId = resultSet.getInt(1);
                employee.setEmpId(empId);
            }
            System.out.println(employee);
        } else {
            System.out.println("FAIL");
        }

        //释放资源
        if(resultSet != null){
            resultSet.close();
        }
        preparedStatement.close();
        connection.close();
    }

    /* 批量操作 */
    @Test
    public void testMoreInsert() throws SQLException {
        //注册驱动
        //Class.forName("com.mysql.cj.jdbc.Driver");

        //获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest", "root", "1111");

        //编写SQL语句
        String sql = "INSERT INTO t_emp(emp_name,emp_salary,emp_age) VALUES(?,?,?)";

        //创建预编译prepareStatement对象，传入SQL语句
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        /* 插入多条数据 */
        long start = System.currentTimeMillis();
        for(int i = 1; i <= 10000; i++){
            //为占位符赋值
            preparedStatement.setString(1,"Mary"+i);
            preparedStatement.setDouble(2,100.0+i);
            preparedStatement.setInt(3,20+i);

            preparedStatement.executeUpdate();
        }
        long end = System.currentTimeMillis();
        System.out.println("TimeCost:" + (end-start));

        //释放资源
        preparedStatement.close();
        connection.close();
    }

    @Test
    public void testBatch() throws SQLException {
        //注册驱动
        //Class.forName("com.mysql.cj.jdbc.Driver");

        //获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql:///dbtest?rewriteBatchedStatements=true", "root", "1111");

        //编写SQL语句
        /*
        * 注意：
        *   1 必须在连接数据的URL后面追加?rewriteBatchedStatements=true，允许批量操作
        *   2 新增SQL必须用VALUES，且语句尾不要加`;`
        *   3 调用addBatch()方法，将SQL语句进行批量添加
        *   4 统一执行批量操作，调用executeBatch()
        */
        String sql = "INSERT INTO t_emp(emp_name,emp_salary,emp_age) VALUES(?,?,?)";

        //创建预编译prepareStatement对象，传入SQL语句
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        /* 插入多条数据 */
        long start = System.currentTimeMillis();
        for(int i = 1; i <= 10000; i++){
            //为占位符赋值
            preparedStatement.setString(1,"Mary"+i);
            preparedStatement.setDouble(2,100.0+i);
            preparedStatement.setInt(3,20+i);

            preparedStatement.addBatch();
        }

        //执行批量操作
        preparedStatement.executeBatch();

        long end = System.currentTimeMillis();
        System.out.println("TimeCost:" + (end-start));

        //释放资源
        preparedStatement.close();
        connection.close();
    }
}
