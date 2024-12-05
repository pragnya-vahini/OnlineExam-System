<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ include file="dbConnection.jsp" %>

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

    boolean flag = username == null || password == null || username.isEmpty() || password.isEmpty() ;
    if(flag){
        response.sendRedirect("studentLogin.jsp?message=INVALID%20CREDENTIALS");
    }


    try {
        String query = "Select * from students where username = ? and password = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
            session.setAttribute("username", username);
            response.sendRedirect("studentHome.jsp");
        } else {
            response.sendRedirect("studentLogin.jsp?message=INVALID%20CREDENTIALS");
        }

    } catch (SQLException e){
        e.printStackTrace();
    }
%>