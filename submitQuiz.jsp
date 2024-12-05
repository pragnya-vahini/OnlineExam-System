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
    <title>Submit Quiz</title>
    <style><%@include file="WEB-INF/assets/css/submitQuiz.css"%></style>
</head>
<body>
    <div class="results-container">
        <h2>Quiz Results</h2>
        <%
            PreparedStatement ps = null;
            ResultSet rs = null;

            String subject = (String) request.getParameter("subject");

            int correctAnswers = 0;
            int totalQuestions = 0;

            try {
                String fetchQuestionsSQL = "SELECT ID, correctAnswer FROM questions WHERE subject = ?; " ;

                ps = conn.prepareStatement(fetchQuestionsSQL);
                ps.setString(1, subject);
                rs = ps.executeQuery();


                while (rs.next()) {
                    String correctAnswer = rs.getString("correctAnswer");
                    String studentAnswer = request.getParameter("q" + rs.getInt("ID"));

                    if (studentAnswer != null && studentAnswer.equals(correctAnswer)) {
                        correctAnswers++;
                    }
                    totalQuestions++;
                }

                String saveResultsSQL = "INSERT INTO results (username, subject, totalQuestions, correctAnswers) VALUES (?, ?, ?, ?)";
                PreparedStatement ps1 = conn.prepareStatement(saveResultsSQL);
                ps1.setString(1, username);
                ps1.setString(2, subject);
                ps1.setInt(3, totalQuestions);
                ps1.setInt(4, correctAnswers);
                ps1.executeUpdate();

                out.println("<p class='success'>Results saved successfully!</p>");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        <p>You answered <%= correctAnswers %> out of <%= totalQuestions %> questions correctly!</p>
        <a href="studentHome.jsp">Retake Quiz</a>
    </div>
</body>

</html>
