<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz</title>
    <style><%@include file="WEB-INF/assets/css/quiz.css"%></style>
</head>

<body>
    <%
        String subject = (String) request.getParameter("subject");
    %>

    <div class="quiz-container">
        <h2>Quiz: <%= subject %></h2>
        <form action="submitQuiz.jsp" method="POST">
            <%
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    String fetchSubjectSQL = "SELECT * FROM questions WHERE subject = ?";
                    ps = conn.prepareStatement(fetchSubjectSQL);
                    ps.setString(1, subject);
                    rs = ps.executeQuery();

                    int count = 1;

                    while (rs.next()) {
                        int questionId = rs.getInt("ID");
                        String questionText = rs.getString("question");
                        String answer1 = rs.getString("answer1");
                        String answer2 = rs.getString("answer2");
                        String answer3 = rs.getString("answer3");
                        String answer4 = rs.getString("answer4");
            %>
                        <div class="question">
                            <label><%= count + ". " + questionText %></label>
                            <div class="options">
                                <input type="radio" name="q<%= questionId %>" value="<%=answer1%>" required> A) <%= answer1 %><br>
                                <input type="radio" name="q<%= questionId %>" value="<%=answer2%>"> B) <%= answer2 %><br>
                                <input type="radio" name="q<%= questionId %>" value="<%=answer3%>"> C) <%= answer3 %><br>
                                <input type="radio" name="q<%= questionId %>" value="<%=answer4%>"> D) <%= answer4 %><br>
                            </div>
                        </div>
            <%
                        count++;
                    }
                } catch (SQLException e) {
                   e.printStackTrace();
                }
            %>


            <input name="subject" value="<%=subject%>" hidden/>
            <input type="submit" value="Submit Quiz">
        </form>
    </div>
</body>
</html>


