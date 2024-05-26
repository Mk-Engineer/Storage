package com.omen.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;
import java.util.Set;

@WebServlet("/servlet5")
public class Servlet5 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /* 获取请求参数 */
        //接收请求中`键值对形式`的参数
        //根据参数名获取单个参数值
        System.out.println(request.getParameter("username"));
        System.out.println(request.getParameter("userPwd"));
        System.out.println(request.getParameter("hobby"));
        System.out.println();
        //根据参数名获取多个参数值
        String[] hobbies = request.getParameterValues("hobby");
        System.out.println(Arrays.toString(hobbies));
        System.out.println();
        //获取所有参数名
        Enumeration<String> pnames = request.getParameterNames();
        while (pnames.hasMoreElements()) {
            String pname = pnames.nextElement();
            String[] values = request.getParameterValues(pname);
            if(values.length > 1){
                System.out.println(pname + " : " + Arrays.toString(values));
            } else {
                System.out.println(pname + " : " + values[0]);
            }
        }
        System.out.println();
        //返回所有参数的map集合
        Map<String, String[]> parameterMap = request.getParameterMap();
        Set<Map.Entry<String, String[]>> entries = parameterMap.entrySet();
        for (Map.Entry<String, String[]> entry : entries) {
            String pname = entry.getKey();
            String[] value = entry.getValue();
            if(value.length > 1){
                System.out.println(pname + " = " + Arrays.toString(value));
            } else {
                System.out.println(pname + " = " + value[0]);
            }
        }
        /*
        * 以上API专门用于获取key=value形式的参数，无论这些参数是在URL后还是在请求体中
        * 请求
        *   请求行：请求方式 请求URI HTTP/1.1
        *   请求头
        *   请求体
        * form表单标签提交GET请求时，参数以键值对形式放在URL后，不放在请求体中，`GET方式的请求也是可以有请求体`
        */
        /*
        * 获得请求体中的非键值对数据：JSON串 / 文件
        * //获取一个从请求体中读取字符的字符输入流
        * BufferedReader reader = request.getReader();              //JSON串
        * //获得一个从请求中读取二进制数据字节的输入流
        * ServletInputStream inputStream = request.getInputStream();//文件
        */
        System.out.println();
        System.out.println(request.getServletPath());
    }
}
