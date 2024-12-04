<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .quiz-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 500px;
            box-sizing: border-box;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .question {
            margin-bottom: 20px;
        }
        .question label {
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
            color: #555;
        }
        .options {
            margin-left: 20px;
        }
        .options input[type="radio"] {
            margin-right: 10px;
        }
        input[type="submit"] {
            display: block;
            margin: 20px auto;
            background-color: #08611b;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #076305;
        }
        p {
            color: red;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        // Retrieve subject from request and set it in the session
        String subject = request.getParameter("subject");
        if (subject != null) {
            session.setAttribute("subject", subject);
        }
        String studentName = (String) session.getAttribute("username1");
    %>
    <div class="quiz-container">
        <h2>Quiz: <%= session.getAttribute("subject") %></h2>
        <form action="submitQuiz.jsp" method="POST">
            <%
                String jdbcURL = "jdbc:mysql://localhost:3306/online_exam?useSSL=false&serverTimezone=UTC";
                String dbUser = "root";
                String dbPassword = "pragnya";

                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet rsQuestions = null;

                try {
                    // Load MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    // Fetch the subject ID
                    String fetchSubjectSQL = "SELECT subject_id FROM sunject WHERE name = ?";
                    stmt = connection.prepareStatement(fetchSubjectSQL);
                    stmt.setString(1, subject);
                    ResultSet rsSubject = stmt.executeQuery();

                    int subjectId =1; // Default invalid subject ID
                    if (rsSubject.next()) {
                        subjectId = rsSubject.getInt("subject_id");
                    }
                    rsSubject.close();

                    if (subjectId == -1) {
                        out.println("<p>Error: Subject not found!</p>");
                    } else {
                        // Fetch questions for the subject
                        String fetchQuestionsSQL = "SELECT * FROM ques WHERE subject_id = ?";
                        stmt = connection.prepareStatement(fetchQuestionsSQL);
                        stmt.setInt(1, subjectId);
                        rsQuestions = stmt.executeQuery();

                        int questionIndex = 1;
                        while (rsQuestions.next()) {
                            int questionId = rsQuestions.getInt("question_id");
                            String questionText = rsQuestions.getString("question");
                            String answer1 = rsQuestions.getString("answer1");
                            String answer2 = rsQuestions.getString("answer2");
                            String answer3 = rsQuestions.getString("answer3");
                            String answer4 = rsQuestions.getString("answer4");
            %>
                            <div class="question">
                                <label><%= questionIndex + ". " + questionText %></label>
                                <div class="options">
                                    <input type="radio" name="q<%= questionId %>" value="A" required> A) <%= answer1 %><br>
                                    <input type="radio" name="q<%= questionId %>" value="B"> B) <%= answer2 %><br>
                                    <input type="radio" name="q<%= questionId %>" value="C"> C) <%= answer3 %><br>
                                    <input type="radio" name="q<%= questionId %>" value="D"> D) <%= answer4 %><br>
                                </div>
                            </div>
            <%
                            questionIndex++;
                        }
                        out.println("<input type='hidden' name='totalQuestions' value='" + (questionIndex - 1) + "'>");
                    }
                } catch (Exception e) {
                   // out.println("<p>Error loading quiz: " + e.getMessage() + "</p>");
                } finally {
                    if (rsQuestions != null) try { rsQuestions.close(); } catch (SQLException ignored) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
                }
            %>
            <input type="submit" value="Submit Quiz">
        </form>
    </div>
</body>
</html>
