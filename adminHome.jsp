<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        /* General Styling */
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom right, #e3f2fd, #ffffff);
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .dashboard {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 90%;
            max-width: 600px;
            text-align: center;
        }

        h2 {
            color: #4CAF50;
            font-size: 2.5em;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .btn-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 20px;
        }

        /* Button Styling */
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            font-size: 1.1em;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn:hover {
            background-color: #45a049;
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Logout Button */
        .btn-logout {
            background-color: #f44336;
        }

        .btn-logout:hover {
            background-color: #e53935;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            h2 {
                font-size: 2em;
            }

            .btn {
                padding: 12px;
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <h2>Welcome, <%= username %>!</h2>
        <div class="btn-container">
            <a href="manageQuestions.jsp" class="btn">Add Questions</a>
            <a href="viewResults.jsp" class="btn">View Results</a>
        </div>

        <!-- Logout Button -->
        <div class="btn-container">
            <a href="logout.jsp" class="btn btn-logout">Logout</a>
        </div>
    </div>
</body>
</html>
