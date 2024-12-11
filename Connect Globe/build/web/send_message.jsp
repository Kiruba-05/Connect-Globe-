<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");  // Redirect to login if not logged in
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Send Message</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                color: #333;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
            h1 {
                color: #007bff;
                margin-bottom: 20px;
            }
            nav {
                display: flex;
                justify-content: space-between;
                margin: 20px 0;
                background-color: #007bff;
                padding: 10px;
                border-radius: 8px;
                width: 100%;
                max-width: 600px;
            }
            nav a {
                color: #fff;
                text-decoration: none;
                font-weight: bold;
                padding: 8px 15px;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            nav a:hover {
                background-color: #0056b3;
            }
            .form-container {
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                width: 90%;
                max-width: 500px;
                margin: auto;
            }
            label {
                margin-top: 10px;
                font-weight: bold;
            }
            input[type="text"], textarea {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }
            input[type="submit"] {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
                font-weight: bold;
                transition: background-color 0.3s;
            }
            input[type="submit"]:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <h1>Send Message</h1>

        <!-- Navigation Links -->
        <nav>
            <a href="inbox.jsp">Inbox</a>
            <a href="send_message.jsp">Send Message</a>
        </nav>

        <!-- Form for composing a message -->
        <div class="form-container">
            <form action="MessageServlet" method="post">
                <label for="receiverUsername">To (Username):</label>
                <input type="text" name="receiverUsername" id="receiverUsername" required /><br>

                <label for="messageBody">Message:</label><br>
                <textarea name="messageBody" id="messageBody" rows="10" required></textarea><br>

                <input type="submit" value="Send">
            </form>
        </div>
    </body>
</html>
