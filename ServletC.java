package com.omen.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/servletC")
/*
* 重定向:
*       1 重定向是通过HttpServletResponse对象实现的
*       2 响应重定向是在服务端提示下的客户端行为
*       3 客户端的地址栏是变化的，同时客户端至少发送了两次请求
*       4 请求产生了多次，后端会有多个request对象，此时请求中的参数不能自动传递
*       5 目标资源可以是Servlet动态资源，也可以是HTML静态资源
*       6 目标资源不能是WEB-INF下的资源,WEB-INF下的资源不能通过浏览器直接访问
*       7 目标资源可以是项目外部资源
*       8 `请求转发`和`重定向`都可以实现页面跳转，优先使用`重定向`
*/
public class ServletC extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //接收用户请求
        System.out.println("ServletC 执行");

        //响应重定向     设置响应状态码为302，同时设置location响应头
        response.sendRedirect("servletD");
        //response.sendRedirect("a.html");
        //response.sendRedirect("https://www.bing.com");
    }
}
