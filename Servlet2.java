package com.omen.servlet;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Enumeration;
/*
* ServletConfig  为某一个Servlet配置独享参数
* ServletContext 为所有的Servlet配置共享参数
*/
/* 注解方法配置ServletConfig初始参数 */
@WebServlet(
        urlPatterns = "/servlet2",
        initParams = {@WebInitParam(name="keya",value="valueA"),@WebInitParam(name="keyb",value="valueB")}
)
public class Servlet2 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("--------------------------ServletConfig获取参数--------------------------");
        ServletConfig servletConfig = this.getServletConfig();
        /* 获取初始配置信息 */
        //根据参数名获取参数值
        String keya = servletConfig.getInitParameter("keya");
        System.out.println("keya: " + keya);

        /* 获取所有初始参数的名字 */
        System.out.println();
        Enumeration<String> initParameterNames = servletConfig.getInitParameterNames();
        //hasMoreElements(): 判断有无下一个参数，有返回true，没有返回false
        //nextElement():     取出下一个元素，向下移动游标
        while (initParameterNames.hasMoreElements()) {
            String pname = initParameterNames.nextElement();
            System.out.println(pname + " : " + servletConfig.getInitParameter(pname));
        }
        System.out.println();
        System.out.println("--------------------------ServletContext获取参数--------------------------");
        //获取ServletContext对象
        //ServletContext servletContext = this.getServletContext();
        //ServletContext servletContext = request.getServletContext();
        ServletContext servletContext = servletConfig.getServletContext();

        //根据参数名获取参数值
        String encoding = servletContext.getInitParameter("encoding");
        System.out.println("encoding: " + encoding);
        System.out.println();

        //获取所有初始参数的名字
        Enumeration<String> parameterNames = servletContext.getInitParameterNames();
        while (parameterNames.hasMoreElements()) {
            String pname = parameterNames.nextElement();
            System.out.println(pname + " : " + servletContext.getInitParameter(pname));
        }
    }
}
