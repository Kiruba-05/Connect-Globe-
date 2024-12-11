import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

@WebServlet("/PostServlet")
public class PostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String postContent = request.getParameter("postContent");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Connect_Globe", "postgres", "2154");

            // Get the user ID of the logged-in user
            PreparedStatement psUser = conn.prepareStatement("SELECT id FROM users WHERE username=?");
            psUser.setString(1, username);
            ResultSet rsUser = psUser.executeQuery();

            int userId = -1;
            if (rsUser.next()) {
                userId = rsUser.getInt("id");
            }

            // Insert the new post
            PreparedStatement psPost = conn.prepareStatement("INSERT INTO posts (user_id, post_content) VALUES (?, ?)");
            psPost.setInt(1, userId);
            psPost.setString(2, postContent);
            psPost.executeUpdate();

            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
