package com.omen.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/servletM")
public class ServletM extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*
        * 请求域对象：
        *   请求转发时，请求域可以传递数据。
        *   请求域内一般放本次请求业务有关的数据，如：查询到的所有的部门信息
        *
        * 会话域对象：
        *   同一个会话内，不用请求转发，会话域可以传递数据。
        *   会话域内一般放本次会话的客户端状态有关的数据，如：当前客户端登录的用户
        *
        * 应用域对象：
        *   同一个APP内，不同的客户端，应用域可以传递数据。
        *   应用域内一般放本程序应用有关的数据，如：Spring框架的IOC容器
        */
        //向请求域存放数据
        req.setAttribute("request","requestMessage");

        //向会话域存放数据
        HttpSession session = req.getSession();
        session.setAttribute("session","sessionMessage");

        //向应用域存放数据
        ServletContext application = req.getServletContext();
        application.setAttribute("application","applicationMessage");

        //获取请求域数据
        String reqMessage = (String)req.getAttribute("request");
        System.out.println("请求域：" + reqMessage);

        //请求转发
//      req.getRequestDispatcher("servlet4").forward(req, resp);
    }
}
