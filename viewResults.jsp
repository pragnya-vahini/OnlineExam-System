<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.*" %>

<%
    // Fetch session variables
    Integer correctAnswersCount = (Integer) session.getAttribute("correctAnswersCount");
    String subject = (String) session.getAttribute("subject");
    String studentName = (String) session.getAttribute("username1");

    // Set default values if not present in session
    if (correctAnswersCount == null) {
        correctAnswersCount = 0; // Default value
    }
    if (subject == null) {
        subject = "N/A"; // Default value
    }
    if (studentName == null) {
        studentName = "N/A"; // Default value
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/online_exam";
    String dbUser = "root";
    String dbPassword = "pragnya";

    // Create database connection
    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // SQL to select results from the table
        String sql = "SELECT student_name, subject_name, marks FROM results";
        stmt = connection.prepareStatement(sql);
        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Exam Results</title>
    <style>
        /* Styling omitted for brevity */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Exam Results</h2>

        <!-- Display session variables -->
        <p>Subject: <%= subject %></p>
        <p>Student Name: <%= studentName %></p>
        <p>Total Correct Answers: <%= correctAnswersCount %></p>

        <!-- Table to display exam results -->
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
                    // Iterate through the result set and display the values in the table
                    while (rs.next()) {
                        String studentNameFromDB = rs.getString("student_name");
                        String subjectNameFromDB = rs.getString("subject_name");
                        int marks = rs.getInt("marks");
                %>
                <tr>
                    <td><%= studentNameFromDB %></td>
                    <td><%= subjectNameFromDB %></td>
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
        out.println("<p>Error fetching results: " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        out.println("<p>Driver Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
    }