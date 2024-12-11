<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Connect_Globe", "postgres", "2154");

        PreparedStatement psUser = conn.prepareStatement("SELECT id FROM users WHERE username=?");
        psUser.setString(1, username);
        ResultSet rsUser = psUser.executeQuery();

        int userId = -1;
        if (rsUser.next()) {
            userId = rsUser.getInt("id");
        }

        // Modified to only retrieve messages sent to or received by the logged-in user
        PreparedStatement psMessages = conn.prepareStatement(
            "SELECT sender_id, message_body, timestamp " +
            "FROM messages " +
            "WHERE receiver_id=? " + // Only messages addressed to the user
            "ORDER BY timestamp DESC"
        );
        psMessages.setInt(1, userId); // Fetch messages for the logged-in user
        ResultSet rsMessages = psMessages.executeQuery();

        PreparedStatement psSenderUsername = conn.prepareStatement("SELECT username FROM users WHERE id=?");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inbox</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                color: #333;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .container {
                width: 90%;
                max-width: 800px;
                margin: 20px auto;
            }
            h1 {
                text-align: center;
                color: #007bff;
                font-size: 2em;
            }
            nav {
                display: flex;
                justify-content: space-between;
                margin: 20px 0;
                background-color: #007bff;
                padding: 10px;
                border-radius: 8px;
            }
            nav a {
                color: #fff;
                text-decoration: none;
                font-weight: bold;
                padding: 8px 15px;
                border-radius: 5px;
            }
            nav a:hover {
                background-color: #0056b3;
            }
            .message {
                background: #fff;
                border-radius: 10px;
                padding: 15px;
                margin-bottom: 15px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            .message-header {
                font-size: 1.1em;
                color: #007bff;
                margin-bottom: 5px;
            }
            .message-content {
                font-size: 1em;
                margin: 10px 0;
                line-height: 1.5em;
            }
            .message-timestamp {
                font-size: 0.9em;
                color: #777;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Inbox</h1>
            
            <!-- Navigation Links -->
            <nav>
                <a href="index.jsp">Home</a>
                <a href="send_message.jsp">Send Message</a>
                <a href="inbox.jsp">Inbox</a>
            </nav>

            <!-- Messages -->
            <div class="messages">
                <%
                    while (rsMessages.next()) {
                        int senderId = rsMessages.getInt("sender_id");
                        String messageBody = rsMessages.getString("message_body");
                        Timestamp timestamp = rsMessages.getTimestamp("timestamp");

                        // Fetch the sender's username
                        psSenderUsername.setInt(1, senderId);
                        ResultSet rsSender = psSenderUsername.executeQuery();
                        String senderUsername = rsSender.next() ? rsSender.getString("username") : "Unknown";
                %>
                    <div class="message">
                        <div class="message-header">From: <strong><%= senderUsername %></strong></div>
                        <div class="message-content"><%= messageBody %></div>
                        <div class="message-timestamp">Received on: <%= timestamp %></div>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
