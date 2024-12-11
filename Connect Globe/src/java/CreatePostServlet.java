import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

@WebServlet(name = "CreatePostServlet", urlPatterns = {"/CreatePostServlet"})
public class CreatePostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        String postContent = request.getParameter("postContent");

        try {
            // Load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Connect_Globe", "postgres", "2154");

            // Retrieve user ID based on username
            PreparedStatement psUser = conn.prepareStatement("SELECT id FROM users WHERE username=?");
            psUser.setString(1, username);
            ResultSet rsUser = psUser.executeQuery();

            if (rsUser.next()) {
                int userId = rsUser.getInt("id");

                // Insert the new post into the posts table
                PreparedStatement psPost = conn.prepareStatement("INSERT INTO posts (user_id, post_content, created_at) VALUES (?, ?, NOW())");
                psPost.setInt(1, userId);
                psPost.setString(2, postContent);
                psPost.executeUpdate();

                // Redirect back to index.jsp after creating the post
                response.sendRedirect("index.jsp");
            } else {
                response.getWriter().println("User not found!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error creating post.");
        }
    }
}
