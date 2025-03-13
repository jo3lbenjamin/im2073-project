import java.io.IOException;
import java.sql.*;
import java.util.regex.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate username format (4-20 chars, letters, numbers, underscores)
        String usernameRegex = "^[a-zA-Z0-9_]{4,20}$";
        if (!Pattern.matches(usernameRegex, username)) {
            request.setAttribute("error", "Invalid username format.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exotic_coffee_shop", "root", "Transcom#188");

            // Check if username exists
            stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                String role = rs.getString("role");

                // Verify password with BCrypt
                if (BCrypt.checkpw(password, storedHash)) {
                    // Start user session
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    // Redirect to dashboard based on role
                    if (role.equals("admin")) {
                        response.sendRedirect("admin-dashboard.jsp");
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    return;
                }
            }

            // If login fails
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }
}