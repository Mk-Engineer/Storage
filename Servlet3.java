package com.omen.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileOutputStream;
import java.io.IOException;

@WebServlet("/servlet3")
public class Servlet3 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /* 向upload目录中写入一个文件 */
        ServletContext servletContext = getServletContext();

        //获得一个指向项目部署位置下的某个文件目录的磁盘真实路径的API
        String path = servletContext.getRealPath("upload");
        System.out.println(path);

        //获得项目部署的上下文路径
        //后续需要在项目中使用`相对路径`和`绝对路径`找目标资源
        String contextPath = servletContext.getContextPath();
        System.out.println(contextPath);

    }
}
