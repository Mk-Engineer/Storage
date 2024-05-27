package com.omen.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/servletA")
public class ServletA extends HttpServlet {
    /*
    *  请求转发：
    *       1 请求转发是通过HttpServletRequest对象实现的
    *       2 请求转发是服务器内部行为，对客户端是屏蔽的
    *       3 客户端只产生了一次请求，服务端只产生了一对request / response对象
    *       4 客户端的地址栏是不变的
    *       5 请求的参数是可以继续传递的
    *       6 目标资源可以是Servlet动态资源，也可以是HTML静态资源
    *       7 目标资源也可以是WEB-INF下的受保护资源，该方式也是WEB-INF下资源的唯一访问方式
    *       8 目标资源不可以是本项目以外的外部资源
    */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("servletA 执行");

        //http://localhost:8080/demo04/servletA?money=1000
        String money = request.getParameter("money");
        System.out.println("ServletA 获得参数 money = " + money);

        //请求转发给ServletB
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("servletB");
        //RequestDispatcher requestDispatcher = request.getRequestDispatcher("a.html");
        //RequestDispatcher requestDispatcher = request.getRequestDispatcher("WEB-INF/b.html");
        //直接访问http://localhost:8080/demo04/servletA/WEB-INF/b.html，访问不到
        //RequestDispatcher requestDispatcher = request.getRequestDispatcher("https://cn.bing.com/");//404

        //让请求转发器做出转发动作
        requestDispatcher.forward(request, response);
    }
}
