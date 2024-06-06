package com.omen.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/servletX")
public class ServletX extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //接收请求中的username参数
        String username = req.getParameter("username");

        //获得session对象
        HttpSession session = req.getSession();
//      session.setMaxInactiveInterval(30);
        //判断请求中有无特殊的cookie：JSESSIONID 值 *** ***
            //1 有 JSESSIONID
                //根据 JSESSIONID 找对应的session对象
                    //1 找到：  返回之前的session
                    //2 没找到：创建一个新session返回，并且向response对象中存放一个JSESSIONID的cookie
            //2 无 JSESSIONID
                //创建一个新session返回，并且向response对象中存放一个JSESSIONID的cookie
        System.out.println(session.getId());
        System.out.println(session.isNew());

        //将username存入session
        session.setAttribute("username", username);

        //向客户端响应信息
        resp.setContentType("text/html;charset=utf-8");
        resp.getWriter().write("成功");

        /*
        * Session对象的时效性
        *   1 默认寿命为30min
        *   2 在web.xml中配置
        *       <session-config>
        *           <session-timeout>30</session-timeout>
        *       </session-config>
        *   3 session.setMaxInactiveInterval(30)
        */

    }
}
