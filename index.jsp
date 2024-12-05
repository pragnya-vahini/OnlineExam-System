<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination System</title>
    <style><%@include file="WEB-INF/assets/css/index.css"%></style>
</head>
<body>
    <h1>Welcome to the Online Examination System</h1>
    <div class="link-container">
        <a href="studentLogin.jsp">Student Login</a>
        <a href="adminLogin.jsp">Admin Login</a>
    </div>
    <footer>© 2024 Online Examination System. All rights reserved.</footer>
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
