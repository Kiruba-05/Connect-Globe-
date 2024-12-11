<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create Post</title>
    <style>
        /* General styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Container styling */
        .container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 90%;
            max-width: 600px;
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        /* Textarea styling */
        textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            resize: none;
            transition: border-color 0.3s;
        }

        textarea:focus {
            border-color: #4CAF50;
            outline: none;
        }

        /* Submit button styling */
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Navigation links styling */
        nav {
            margin-top: 20px;
            display: flex;
            justify-content: space-around;
        }

        nav a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            padding: 8px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        nav a:hover {
            background-color: #e7f1ff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Create a New Post</h1>
        <form action="CreatePostServlet" method="post">
            <textarea name="postContent" placeholder="Write your post here..." required></textarea><br>
            <input type="submit" value="Post">
        </form>
        <nav>
            <a href="inbox.jsp">Inbox</a>
            <a href="index.jsp">View Posts</a>
        </nav>
    </div>
</body>
</html>
