<%@ page import="java.sql.*, java.util.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3307/online_exam";
    String jdbcUsername = "root";
    String jdbcPassword = "";

    Connection conn = null;
//    PreparedStatement stmt = null;
//    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
//        statement = connection.createStatement();
//        String query = "SELECT * FROM your_table";
//        resultSet = statement.executeQuery(query);
//        List<String> data = new ArrayList<>();
//        while (resultSet.next()) {
//            data.add(resultSet.getString("column_name"));
//        }
//        request.setAttribute("data", data);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
