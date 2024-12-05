<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style><%@include file="WEB-INF/assets/css/adminLogin.css"%></style>
</head>

<body>
    <form action="adminLoginVerify.jsp" method="POST">
        <h2>Admin Login</h2>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="Enter your username" required>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>
        <input type="submit" value="Login">
    </form>

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










<%--<%--%>
<%--    String username = request.getParameter("username");--%>
<%--    String password = request.getParameter("password");--%>

<%--    if (username != null && password != null) {--%>
<%--        if ("admin".equals(username) && "password".equals(password)) { // Example credentials--%>
<%--            session.setAttribute("username", username);--%>
<%--            response.sendRedirect("adminHome.jsp");--%>
<%--            return;--%>
<%--        } else {--%>
<%--            request.setAttribute("errorMessage", "Invalid username or password.");--%>
<%--        }--%>
<%--    }--%>
<%--%>--%>


<%--<%--%>
<%--    String errorMessage = (String) request.getAttribute("errorMessage");--%>
<%--    if (errorMessage != null) {--%>
<%--%>--%>
<%--<div class="error"><%= errorMessage %></div>--%>
<%--<%--%>
<%--    }--%>
<%--%>--%>