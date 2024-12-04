<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Questions</title>
    <style>
        /* Styling for better appearance */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }
        form {
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            max-width: 600px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }
        select, textarea, input[type="text"], button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 14px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .success, .error {
            text-align: center;
            margin: 20px auto;
            padding: 10px;
            max-width: 600px;
            border-radius: 5px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <h2>Manage Questions</h2>
    <%
        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/online_exam?useSSL=false&serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "pragnya";

        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rsSubjects = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Fetch subjects
            String fetchSubjectsSQL = "SELECT subject_id, name FROM sunject";
            stmt = connection.prepareStatement(fetchSubjectsSQL);
            rsSubjects = stmt.executeQuery();
        } catch (ClassNotFoundException e) {
            out.println("<div class='error'>MySQL JDBC Driver not found: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<div class='error'>Error connecting to the database: " + e.getMessage() + "</div>");
            e.printStackTrace();
        }

        // Handle form submission
        String subjectId = request.getParameter("subjectId");
        String question = request.getParameter("question");
        String answer1 = request.getParameter("answer1");
        String answer2 = request.getParameter("answer2");
        String answer3 = request.getParameter("answer3");
        String answer4 = request.getParameter("answer4");
        String correctAnswer = request.getParameter("correctAnswer");

        if (subjectId != null && question != null && answer1 != null && answer2 != null &&
            answer3 != null && answer4 != null && correctAnswer != null) {

            // Validate correctAnswer input
            if (!correctAnswer.matches("[A-Da-d]")) {
                out.println("<div class='error'>Correct answer must be A, B, C, or D.</div>");
            } else {
                try {
                    String insertQuestionSQL = "INSERT INTO ques(subject_id, question, answer1, answer2, answer3, answer4, correct_answer) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement insertStmt = connection.prepareStatement(insertQuestionSQL);

                    insertStmt.setInt(1, Integer.parseInt(subjectId));
                    insertStmt.setString(2, question);
                    insertStmt.setString(3, answer1);
                    insertStmt.setString(4, answer2);
                    insertStmt.setString(5, answer3);
                    insertStmt.setString(6, answer4);
                    insertStmt.setString(7, correctAnswer.toUpperCase());
                    insertStmt.executeUpdate();

                    out.println("<div class='success'>Question added successfully!</div>");
                    insertStmt.close();
                } catch (SQLException e) {
                    out.println("<div class='error'>Error saving question. Please try again later: " + e.getMessage() + "</div>");
                }
            }
        }
    %>

    <form method="post">
        <label for="subjectId">Select Subject:</label>
        <select name="subjectId" id="subjectId" required>
            <option value="" disabled selected>Select a Subject</option>
            <%
                try {
                    if (rsSubjects != null) {
                        while (rsSubjects.next()) {
                            int id = rsSubjects.getInt("subject_id");
                            String name = rsSubjects.getString("name");
            %>
                            <option value="<%= id %>"><%= name %></option>
            <%
                        }
                    }
                } catch (SQLException e) {
                    out.println("<option disabled>Error loading subjects</option>");
                }
            %>
        </select>

        <label for="question">Question:</label>
        <textarea name="question" id="question" rows="4" cols="50" required></textarea>

        <label for="answer1">Answer 1:</label>
        <input type="text" name="answer1" id="answer1" required>

        <label for="answer2">Answer 2:</label>
        <input type="text" name="answer2" id="answer2" required>

        <label for="answer3">Answer 3:</label>
        <input type="text" name="answer3" id="answer3" required>

        <label for="answer4">Answer 4:</label>
        <input type="text" name="answer4" id="answer4" required>

        <label for="correctAnswer">Correct Answer (A/B/C/D):</label>
        <input type="text" name="correctAnswer" id="correctAnswer" maxlength="1" required>

        <button type="submit">Add Question</button>
    </form>

    <%
        // Close resources
        if (rsSubjects != null) try { rsSubjects.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
    %>
</body>
</html>
