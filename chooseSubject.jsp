<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Choose Subject</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #555;
        }
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #0a7e2d;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #087b06;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Choose Subject</h2>
        <form action="quiz.jsp" method="POST">
            <label for="subject">Select Subject:</label>
            <select name="subject" id="subject" required>
                <option value="Math">Mathematics</option>
                <option value="Science">Science</option>
                <option value="History">History</option>
            </select>
            <input type="submit" value="Start Quiz">
        </form>

        <%
            String subject = request.getParameter("subject");
            if (subject != null) {
                session.setAttribute("subject", subject);
            }

            String studentName = (String) session.getAttribute("username1");
        %>
    </div>
</body>
</html>
