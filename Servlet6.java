package com.omen.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/servlet6")
public class Servlet6 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String info = "<h1>Hello</h1>";

        //设置响应行API    HTTP/1.1    200/404/405/500    状态描述文字
        response.setStatus(200);

        //设置响应头API
        response.setHeader("testHead","valueH");
        //response.setHeader("Content-Type","text/html");
        //response.setHeader("Content-Length","1234");
        response.setContentType("text/html");//Content-Type 重要*
        response.setContentLength(info.getBytes().length);

        //设置响应体内容API
        //获得一个向响应体中输入文本字符的输出流
        PrintWriter writer = response.getWriter();
        writer.write(info);

        //向响应体中放文件
        //获得一个向响应体中输入二进制信息的字节输出流
        //ServletOutputStream outputStream = response.getOutputStream();
    }
}
