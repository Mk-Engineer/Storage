package com.omen.servlet;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * servlet开发流程
 * 1 创建javaWEB项目，同时将tomcat添加为项目的`依赖`
 * 2 重写service方法，service(HttpServletRequest req, HttpServletResponse resp)
 * 3 在service方法中定义业务处理代码
 * 4 在web.xml中配置Servlet对应的请求映射路径
 *
 * 注意
 * 1 servlet-api.jar导入问题
 * 2 Content-Type响应头的问题
 *      客户端根据响应头中的Content-Type的MIME类型，解析响应体
 *
 * 注意
 * 1 推荐在servlet中重写 doGet() / doPost() 方法来处理请求
 *   如果直接重写 service() 方法，父类中的 service() 方法的部分处理功能将失效
 * 2 目前直接重写 service() 也适用
 * 3 如果 doGet() 和 doPost() 中定义的代码耦合度很高，可以使用doGet()调用doPost()，或相反
 * 4 后续使用SpringMVC框架后，无需继承HttpServlet，处理请求的方法也不再使用重写 doXxx() / service() 的模式
 * */
public class UserServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1 从request对象中获取请求中的任何信息(username参数)
        String username = request.getParameter("username");//根据参数名获取参数值，无论参数是在URL?后，还是在请求体中

        //2 业务处理代码
        String info = "<h1>YES</h1>";

        if("admin".equals(username)){
            info = "NO";
        }

        //3 将要响应的数据放入response
        //应该设置Content-Type响应头
        //response.setHeader("Content-Type", "text/html");
        response.setContentType("text/html");

        PrintWriter writer = response.getWriter();//该方法返回的是一个向响应体中打印字符串的打印流
        writer.write(info);
    }
}
