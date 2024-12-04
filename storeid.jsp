<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>

<%
    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/online_exam";
    String dbUser = "root";
    String dbPassword = "pragnya";
s
    // Retrieve form data from the request (from the previous form in the quiz)
    String studentName = request.getParameter("username1");
    String subjectName = request.getParameter("subject");
    String marksString = request.getParameter("correctAnswersCount");
    
    // Convert marks to an integer (assuming it's a valid integer)
    int marks = 0;
    try {
        marks = Integer.parseInt(marksString);
    } catch (NumberFormatException e) {
        out.println("Invalid marks format: " + e.getMessage());
    }

    // Create database connection
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load the MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // SQL to insert data into results table
        String sql = "INSERT INTO results (student_name, subject_name, marks) VALUES (?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);

        // Set parameters for the prepared statement
        preparedStatement.setString(1, studentName);
        preparedStatement.setString(2, subjectName);
        preparedStatement.setInt(3, marks);

        // Execute the insert query
        int rowsInserted = preparedStatement.executeUpdate();

        // If the record is inserted successfully, forward to viewResults.jsp
        if (rowsInserted > 0) {
            // Set the booking details as request attributes (if needed for display in viewResults.jsp)
            request.setAttribute("student_name", studentName);
            request.setAttribute("subject_name", subjectName);
            request.setAttribute("marks", marks);

            // Forward to viewResults.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewResults.jsp");
            dispatcher.forward(request, response);
        } else {
            out.println("Error: Unable to save results.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close the resources
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
%>
