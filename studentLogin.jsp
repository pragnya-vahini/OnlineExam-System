<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<%
    if(session != null && session.getAttribute("username") != null){
        String username = (String) session.getAttribute("username");
        if(username.equals("admin"))
            response.sendRedirect("adminHome.jsp?message=Session%20already%20exists");
        else
            response.sendRedirect("studentHome.jsp?message=Session%20already%20exists");

        return;
    }
%>
<head>
    <title>Student Login</title>
    <style><%@include file="WEB-INF/assets/css/studentLogin.css"%></style>

</head>
<body>
    <div class="login-container">
        <h2>Student Login</h2>
        <form action="studentLoginVerify.jsp" method="POST">
            <label for="username1">Username:</label>
            <input type="text" id="username1" name="username" required>
            <label for="password1">Password:</label>
            <input type="password" id="password1" name="password" required>
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>


<%
    String message = request.getParameter("message");
    if (message != null && !message.isEmpty()) {
%>
<script>
    window.onload = function() {
        setTimeout(function() {
            alert("<%= message %>");
        }, 100);
    };
</script>
<%
    }
%>




<%--        <% --%>
<%--            String username1 = request.getParameter("username1");--%>
<%--            if (username1 != null) {--%>
<%--                session.setAttribute("username1", username1); // Store username in session--%>
<%--            }--%>
<%--        %>--%>