/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

/**
 *
 * @author abith
 */
@WebServlet(name = "MessageServlet", urlPatterns = {"/MessageServlet"})
public class MessageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String receiverUsername = request.getParameter("receiverUsername");
        String messageBody = request.getParameter("messageBody");
        HttpSession session = request.getSession();
        String senderUsername = (String) session.getAttribute("username");

        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
            // Establish the connection to the database
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Connect_Globe", "postgres", "2154");

            // Retrieve sender ID from the session username
            PreparedStatement psSender = conn.prepareStatement("SELECT id FROM users WHERE username=?");
            psSender.setString(1, senderUsername);
            ResultSet rsSender = psSender.executeQuery();

            if (rsSender.next()) {
                int senderId = rsSender.getInt("id");

                // Retrieve receiver ID based on username
                PreparedStatement psReceiver = conn.prepareStatement("SELECT id FROM users WHERE username=?");
                psReceiver.setString(1, receiverUsername);
                ResultSet rsReceiver = psReceiver.executeQuery();

                if (rsReceiver.next()) {
                    int receiverId = rsReceiver.getInt("id");

                    // Insert the message into the messages table
                    PreparedStatement psMessage = conn.prepareStatement(
                        "INSERT INTO messages (sender_id, receiver_id, message_body, timestamp) VALUES (?, ?, ?, NOW())"
                    );
                    psMessage.setInt(1, senderId);
                    psMessage.setInt(2, receiverId);
                    psMessage.setString(3, messageBody);
                    psMessage.executeUpdate();

                    // Notify the user of successful message sending
                    response.getWriter().println("Message sent successfully!");
                } else {
                    response.getWriter().println("Receiver not found!");
                }
            } else {
                response.getWriter().println("Sender not found!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error sending message.");
        }
    }
}
