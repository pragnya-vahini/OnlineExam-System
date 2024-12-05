<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="dbConnection.jsp" %>
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

    String subject = request.getParameter("subject");
    String question = request.getParameter("question");
    String answer1 = request.getParameter("answer1");
    String answer2 = request.getParameter("answer2");
    String answer3 = request.getParameter("answer3");
    String answer4 = request.getParameter("answer4");
    String correctAnswer = request.getParameter("correctAnswer");

    if(subject == null || question == null || answer1 == null || answer2 == null || answer3 == null || answer4 == null || correctAnswer == null) {
        response.sendRedirect("manageQuestions.jsp?message=Invalid%20Question");
        return;
    }


    try {
        String sql = "insert into questions (subject, question, answer1, answer2, answer3, answer4, correctAnswer) values (?, ?, ?, ?, ?, ?, ?); ";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, subject);
        ps.setString(2, question);
        ps.setString(3, answer1);
        ps.setString(4, answer2);
        ps.setString(5, answer3);
        ps.setString(6, answer4);
        ps.setString(7, correctAnswer);

        ps.executeUpdate();

        response.sendRedirect("manageQuestions.jsp?message=Question%20saved%20successfully");
        return;
    } catch (SQLException e){
        e.printStackTrace();
    }
%>