<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    if(session == null || session.getAttribute("username") == null) {
        response.sendRedirect("logout.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    if (username == null || username.isEmpty() || !username.equals("admin")) {
        response.sendRedirect("logout.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style><%@include file="WEB-INF/assets/css/adminHome.css"%></style>

</head>
<body>
    <div class="dashboard">
        <h2>Welcome, Administrator</h2>

        <div class="btn-container">
            <a href="manageQuestions.jsp" class="btn">Add Questions</a>
            <a href="viewResults.jsp" class="btn">View Results</a>
        </div>

        <div class="btn-container">
            <a href="logout.jsp" class="btn btn-logout">Logout</a>
        </div>
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






