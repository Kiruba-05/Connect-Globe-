import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

@WebServlet("/ReplyServlet")
public class ReplyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String replyContent = request.getParameter("replyContent");
        int postId = Integer.parseInt(request.getParameter("postId"));
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Connect_Globe", "postgres", "2154");

            // Get the user ID based on the username
            PreparedStatement psUser = conn.prepareStatement("SELECT id FROM users WHERE username = ?");
            psUser.setString(1, username);
            ResultSet rsUser = psUser.executeQuery();

            if (rsUser.next()) {
                int userId = rsUser.getInt("id");

                // Insert reply into the replies table
                PreparedStatement psReply = conn.prepareStatement(
                        "INSERT INTO replies (post_id, user_id, reply_content) VALUES (?, ?, ?)");
                psReply.setInt(1, postId);
                psReply.setInt(2, userId);
                psReply.setString(3, replyContent);
                psReply.executeUpdate();
            }

            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
