<%@ page import="java.sql.*" %>

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
<html>
<head>
    <title>Manage Questions</title>
    <style><%@include file="WEB-INF/assets/css/manageQuestions.css"%></style>

</head>
<body>
    <h2>Manage Questions</h2>

    <form method="post" action="PushQuestionIntoDB.jsp">

        <label for="subjectId">Select Subject:</label>
        <select name="subject" id="subjectId" required>
            <option value="" disabled selected>Select a Subject</option>
            <option value="Math">Math</option>
            <option value="Science">Science</option>
            <option value="History">History</option>
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

        <label for="correctAnswer">Correct Answer</label>
        <input type="text" name="correctAnswer" id="correctAnswer" required>

        <button type="submit">Add Question</button>
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
            window.location.href="manageQuestions.jsp";
        }, 100);
    };
</script>
<%
    }
%>




<%--<%--%>
<%--    PreparedStatement stmt = null;--%>
<%--    ResultSet rsSubjects = null;--%>

<%--//        try {--%>
<%--//            String fetchSubjectsSQL = "SELECT subject_id, name FROM sunject";--%>
<%--//            stmt = conn.prepareStatement(fetchSubjectsSQL);--%>
<%--//            rsSubjects = stmt.executeQuery();--%>
<%--//        } catch (ClassNotFoundException e) {--%>
<%--//            out.println("<div class='error'>MySQL JDBC Driver not found: " + e.getMessage() + "</div>");--%>
<%--//            e.printStackTrace();--%>
<%--//        } catch (SQLException e) {--%>
<%--//            out.println("<div class='error'>Error connecting to the database: " + e.getMessage() + "</div>");--%>
<%--//            e.printStackTrace();--%>
<%--//        }--%>

<%--    // Handle form submission--%>
<%--//        String subjectId = request.getParameter("subjectId");--%>
<%--//        String question = request.getParameter("question");--%>
<%--//        String answer1 = request.getParameter("answer1");--%>
<%--//        String answer2 = request.getParameter("answer2");--%>
<%--//        String answer3 = request.getParameter("answer3");--%>
<%--//        String answer4 = request.getParameter("answer4");--%>
<%--//        String correctAnswer = request.getParameter("correctAnswer");--%>

<%--//        if (subjectId != null && question != null && answer1 != null && answer2 != null &&--%>
<%--//            answer3 != null && answer4 != null && correctAnswer != null) {--%>
<%--//--%>
<%--//            // Validate correctAnswer input--%>
<%--//            if (!correctAnswer.matches("[A-Da-d]")) {--%>
<%--//                out.println("<div class='error'>Correct answer must be A, B, C, or D.</div>");--%>
<%--//            } else {--%>
<%--//                try {--%>
<%--//                    String insertQuestionSQL = "INSERT INTO ques(subject_id, question, answer1, answer2, answer3, answer4, correct_answer) VALUES (?, ?, ?, ?, ?, ?, ?)";--%>
<%--//                    PreparedStatement insertStmt = conn.prepareStatement(insertQuestionSQL);--%>
<%--//--%>
<%--//                    insertStmt.setInt(1, Integer.parseInt(subjectId));--%>
<%--//                    insertStmt.setString(2, question);--%>
<%--//                    insertStmt.setString(3, answer1);--%>
<%--//                    insertStmt.setString(4, answer2);--%>
<%--//                    insertStmt.setString(5, answer3);--%>
<%--//                    insertStmt.setString(6, answer4);--%>
<%--//                    insertStmt.setString(7, correctAnswer.toUpperCase());--%>
<%--//                    insertStmt.executeUpdate();--%>
<%--//--%>
<%--//                    out.println("<div class='success'>Question added successfully!</div>");--%>
<%--//                    insertStmt.close();--%>
<%--//                } catch (SQLException e) {--%>
<%--//                    out.println("<div class='error'>Error saving question. Please try again later: " + e.getMessage() + "</div>");--%>
<%--//                }--%>
<%--//            }--%>
<%--//        }--%>
<%--%>--%>
