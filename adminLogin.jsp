<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        if ("admin".equals(username) && "password".equals(password)) { // Example credentials
            session.setAttribute("username", username);
            response.sendRedirect("adminHome.jsp");
            return;
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        /* General Styling */
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(to bottom right, #4CAF50, #81C784);
            color: #fff;
        }

        /* Form Container */
        form {
            background: #fff;
            color: #333;
            width: 400px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            transition: box-shadow 0.3s ease, transform 0.2s ease-in-out;
        }

        form:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
            transform: translateY(-2px);
        }

        h2 {
            margin-bottom: 20px;
            color: #4CAF50;
            font-size: 1.8em;
            font-weight: bold;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #4CAF50;
            outline: none;
        }

        input[type="submit"] {
            background: #4CAF50;
            color: #fff;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        input[type="submit"]:hover {
            background: #45a049;
            transform: translateY(-2px);
        }

        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: left;
        }

        @media (max-width: 768px) {
            form {
                width: 90%;
                padding: 20px;
            }

            h2 {
                font-size: 1.6em;
            }

            input[type="text"],
            input[type="password"],
            input[type="submit"] {
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
    <form action="adminLogin.jsp" method="POST">
        <h2>Admin Login</h2>

        <!-- Error Message -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="error"><%= errorMessage %></div>
        <%
            }
        %>

        <!-- Username Field -->
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="Enter your username" required>

        <!-- Password Field -->
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>

        <!-- Submit Button -->
        <input type="submit" value="Login">
    </form>
</body>
</html>
