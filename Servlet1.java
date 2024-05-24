package com.omen.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
/* 用注解的方式配置Sevlet */
// 注解配置Sevlet和XML配置Sevlet相互冲突

/* 等价 */
//@WebServlet("/s1")
//@WebServlet(value = "/s1")
//@WebServlet(urlPatterns = "/s1")

/* 定义多个路径 */
//@WebServlet(urlPatterns = {"/s1","/s2","/s3"})

@WebServlet("/s1")
public class Servlet1 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Servlet1 执行");
    }
}
