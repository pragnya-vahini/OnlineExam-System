<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Submit Quiz</title>
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
        .results-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        p {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #007BFF;
            font-size: 16px;
        }
        a:hover {
            text-decoration: underline;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="results-container">
        <h2>Quiz Results</h2>
        <%
            // Database connection details
            String jdbcURL = "jdbc:mysql://localhost:3306/online_exam?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPassword = "pragnya";

            Connection connection = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            // Fetch session variables
            String subjectName = (String) session.getAttribute("subject");
            String studentName = (String) session.getAttribute("username1");

            int totalQuestions = Integer.parseInt(request.getParameter("totalQuestions"));
            int correctAnswersCount = 0;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Fetch correct answers for the selected subject
                String fetchQuestionsSQL = "SELECT question_id, correct_answer FROM ques WHERE subject_id = " +
                                            "(SELECT subject_id FROM sunject WHERE name = ?)";
                stmt = connection.prepareStatement(fetchQuestionsSQL);
                stmt.setString(1, subjectName);
                rs = stmt.executeQuery();

                // Compare student answers with correct answers
                while (rs.next()) {
                    String correctAnswer = rs.getString("correct_answer").trim().toUpperCase();
                    String studentAnswer = request.getParameter("q" + rs.getInt("question_id"));

                    if (studentAnswer != null && studentAnswer.trim().toUpperCase().equals(correctAnswer)) {
                        correctAnswersCount++;
                    }
                }

                // Save the results in the database
                String saveResultsSQL = "INSERT INTO results (student_name, subject_name, marks, total_questions, date_taken) VALUES (?, ?, ?, ?, NOW())";
                stmt = connection.prepareStatement(saveResultsSQL);
                stmt.setString(1, studentName);
                stmt.setString(2, subjectName);
                stmt.setInt(3, correctAnswersCount);
                stmt.setInt(4, totalQuestions);
                stmt.executeUpdate();

                // Set correctAnswersCount in session for future use
                session.setAttribute("correctAnswersCount", correctAnswersCount);

                out.println("<p class='success'>Results saved successfully!</p>");
            } catch (Exception e) {
                //out.println("<p class='error'>Error processing quiz: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
            }
        %>
        <p>You answered <%= correctAnswersCount %> out of <%= totalQuestions %> questions correctly!</p>
        <a href="chooseSubject.jsp">Retake Quiz</a>
    </div>
</body>
</html>
