package com.omen.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/servletI")
public class ServletI extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("ServletI");
        /*
        * 重定向路径
        *   1 相对路径
        *       以当前资源的所在位置`@WebServlet("/servletI")`为出发点，去找目标资源
        *     语法：不以`/`开头
        *          `./`  表示当前资源的路径
        *          `../` 表示上层资源的路径
        *     缺点：目标资源路径收到当前资源路径的影响，不同位置相对路径写法不同
        *   2 绝对路径
        *       以http://localhost:8080/为出发点
        */
        //重定向到ServletII
        /* 相对路径 */
//        resp.sendRedirect("servletII");
        /* 绝对路径 */
//        resp.sendRedirect("/demo05/servletII");

//        ServletContext servletContext = req.getServletContext();
//        String contextPath = servletContext.getContextPath();// "/demo05/"
//        resp.sendRedirect(contextPath + "/servletII");

        //请求转发到ServletB
        /*
        * 请求转发路径
        *   1 相对路径
        *       以当前资源的所在位置`@WebServlet("/servletI")`为出发点，去找目标资源
        *     语法：不以`/`开头
        *          `./`  表示当前资源的路径
        *          `../` 表示上层资源的路径
        *     缺点：目标资源路径收到当前资源路径的影响，不同位置相对路径写法不同
        *   2 绝对路径 (不同)
        *       请求转发的绝对路径不需要添加项目上下文
        *       请求转发的`/`代表的路径是http://localhost:8080/demo05/
        */
        /* 相对路径 */
//        req.getRequestDispatcher("servletII").forward(req, resp);
        /* 绝对路径 */
//        req.getRequestDispatcher("/servletII").forward(req, resp);
    }
}
