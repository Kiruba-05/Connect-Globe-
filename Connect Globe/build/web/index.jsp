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

        // Get all posts with users who posted them
        PreparedStatement psPosts = conn.prepareStatement(
            "SELECT posts.id AS post_id, users.username, posts.post_content, posts.created_at " +
            "FROM posts " +
            "JOIN users ON posts.user_id = users.id " +
            "ORDER BY posts.created_at DESC"
        );
        ResultSet rsPosts = psPosts.executeQuery();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Connect Globe - Public Posts</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                color: #333;
                display: flex;
                justify-content: center;
            }
            .container {
                width: 80%;
                max-width: 900px;
                margin: 30px auto;
            }
            h1 {
                text-align: center;
                color: #3a3b3c;
            }
            nav {
                text-align: right;
                margin-bottom: 20px;
            }
            nav a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
                padding: 10px;
            }
            .post {
                background: #fff;
                border-radius: 8px;
                padding: 15px;
                margin: 20px 0;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            .post strong {
                color: #007bff;
            }
            .post-content {
                font-size: 16px;
                margin: 10px 0;
            }
            .timestamp {
                font-size: 12px;
                color: #777;
            }
            .reply-form textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                resize: none;
                margin-top: 10px;
                font-size: 14px;
            }
            .reply-form input[type="submit"] {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 8px 16px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
            }
            .reply-form input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .replies .reply {
                margin-left: 20px;
                border-left: 2px solid #007bff;
                padding-left: 10px;
                margin-top: 10px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Connect Globe - Public Posts</h1>
            
            <!-- Navigation Links -->
            <nav>
                <a href="inbox.jsp">Inbox</a>
                <a href="create_post.jsp">Create Post</a> 
            </nav>

            <!-- Display posts with replies -->
            <div class="posts">
                <% while (rsPosts.next()) { %>
                    <div class="post">
                        <p><strong><%= rsPosts.getString("username") %></strong></p>
                        <p class="post-content"><%= rsPosts.getString("post_content") %></p>
                        <p class="timestamp"><em>Posted on: <%= rsPosts.getTimestamp("created_at") %></em></p>

                        <!-- Reply form -->
                        <div class="reply-form">
                            <form action="ReplyServlet" method="post">
                                <input type="hidden" name="postId" value="<%= rsPosts.getInt("post_id") %>">
                                <textarea name="replyContent" placeholder="Write a reply..." required></textarea>
                                <input type="submit" value="Reply">
                            </form>
                        </div>

                        <!-- Display replies for each post -->
                        <div class="replies">
                            <%
                                int postId = rsPosts.getInt("post_id");
                                PreparedStatement psReplies = conn.prepareStatement(
                                    "SELECT users.username, replies.reply_content, replies.created_at " +
                                    "FROM replies " +
                                    "JOIN users ON replies.user_id = users.id " +
                                    "WHERE replies.post_id = ? " +
                                    "ORDER BY replies.created_at ASC"
                                );
                                psReplies.setInt(1, postId);
                                ResultSet rsReplies = psReplies.executeQuery();

                                while (rsReplies.next()) {
                            %>
                                <div class="reply">
                                    <p><strong><%= rsReplies.getString("username") %></strong>: <%= rsReplies.getString("reply_content") %></p>
                                    <p class="timestamp"><em>Replied on: <%= rsReplies.getTimestamp("created_at") %></em></p>
                                </div>
                            <% } %>
                        </div>
                    </div>
                <% } %>
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
