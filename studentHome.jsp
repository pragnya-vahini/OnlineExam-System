<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%
    if(session == null || session.getAttribute("username") == null) {
        response.sendRedirect("logout.jsp");
        return;
    }

    String username =  (String) session.getAttribute("username");
    if(username == null || username.isEmpty()){
        response.sendRedirect("logout.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Choose Subject</title>
    <style><%@include file="WEB-INF/assets/css/studentHome.css"%></style>
</head>



<body>



    <div class="form-container">
        <h2>Choose Subject</h2>

        <form action="quiz.jsp" method="POST">
            <label for="subject">Select Subject:</label>
            <select name="subject" id="subject" required>
                <option value="Math">Mathematics</option>
                <option value="Science">Science</option>
                <option value="History">History</option>
            </select>
            <input type="submit" value="Start Quiz" onclick="formAction(event)">
        </form><br>
        
        <button><a href="logout.jsp">Log out</a></button>
   

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


