<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ include file="dbConnection.jsp" %>




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

<%
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT * FROM results";
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Exam Results</title>
    <style><%@include file="WEB-INF/assets/css/viewResults.css"%></style>

</head>
<body>
    <div class="container">
        <h2>Exam Results</h2>

        <table>
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Subject</th>
                    <th>Marks Obtained</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        String student = rs.getString("username");
                        String subject = rs.getString("subject");
                        String marks = " " + rs.getInt("correctAnswers") + "/" + rs.getInt("totalQuestions");
                %>
                <tr>
                    <td><%= student %></td>
                    <td><%= subject %></td>
                    <td><%= marks %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>

<%
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>