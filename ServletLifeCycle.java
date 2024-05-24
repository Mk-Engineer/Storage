package com.omen.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
/*
* Servlet声明周期
*   1 实例化           构造器()       第1次请求 / 服务启动时
*   2 初始化           init()        构造完毕
*   3 接受请求，处理请求 service()     每次请求
*   4 销毁            destroy()     关闭服务
*
* Servlet在Tomcat中是单例的
*   Servlet的成员变量在多个线程栈中是共享的
*   不建议在`service()`中修改成员变量，在并发请求时会引发`线程安全问题`
*
* default-servlet
*   请求静态资源由`default-servlet`加载
*   SpringMVC会使`default-servlet`失效，需要重新配置，才能正常获取静态资源
* */

/*
    @WebServlet()
    `-1`含义是tomcat启动时不会实例化servlet
    其他正整数含义是tomcat启动时，实例化servlet的顺序，如果序号冲突tomcat会自动协调启动顺序
    `loadOnStartup`建议从`6`开始
*/
@WebServlet(value = "/servletLifeCycle",loadOnStartup = -1)
public class ServletLifeCycle extends HttpServlet {
    public ServletLifeCycle(){
        System.out.println("构造器执行");
    }

    @Override
    public void init() throws ServletException {
        System.out.println("初始化");
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("处理服务");
    }

    @Override
    public void destroy() {
        System.out.println("销毁");
    }
}
