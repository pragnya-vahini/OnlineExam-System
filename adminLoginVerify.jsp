<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>

<%
    if(session != null && session.getAttribute("username") != null){
        String username = (String) session.getAttribute("username");
        if(username.equals("admin"))
            response.sendRedirect("adminHome.jsp?message=Session%20already%20exists");
        else
            response.sendRedirect("studentHome.jsp?message=Session%20already%20exists");

        return;
    }

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    boolean flag = username == null || password == null || username.isEmpty() || password.isEmpty() || !username.equals("admin") || !password.equals("admin");
    if(flag){
        response.sendRedirect("adminLogin.jsp?message=INVALID%20CREDENTIALS");
    } else {
        session.setAttribute("username", "admin");
        response.sendRedirect("adminHome.jsp");
    }
%>