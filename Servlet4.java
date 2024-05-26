package com.omen.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/servlet4")
public class Servlet4 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //请求行相关 GET / POST  URI  HTTP/1.1
        System.out.println(request.getMethod());    //获取请求方式
        System.out.println(request.getScheme());    //获取请求协议
        System.out.println(request.getProtocol());  //获取协议及版本号
        System.out.println(request.getRequestURI());//获取URI，获取项目内的资源路径:/demo03/servlet4
        System.out.println(request.getRequestURL());//获取URL，获取项目内资源的完整路径:http://localhost:8080/demo03/servlet4
        System.out.println();
        /*
            URI 统一资源标识符 interface URI{}
                资源定位的要求和规范
            URL 统一资源定位符 class URL implements URI{}
                网络中一个具体的资源路径
        */
        System.out.println(request.getLocalPort()); //获取本应用容器的端口号       服务器端口号
        System.out.println(request.getServerPort());//获取客户端发请求时使用的端口号 代理服务器端口号
        System.out.println(request.getRemotePort());//获取客户端软件的端口号       浏览器端口号
        System.out.println();

        //请求头相关 key:value  key:value ...
        //根据名称单独获取某个请求头
        System.out.println("Accept:" + request.getHeader("Accept"));
        System.out.println();
        //获取本次请求中所有请求头的名字
        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String hname = headerNames.nextElement();
            System.out.println(hname + ":" + request.getHeader(hname));
        }

        //获取请求参数
    }
}
