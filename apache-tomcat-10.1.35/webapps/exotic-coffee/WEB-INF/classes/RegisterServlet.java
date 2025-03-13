import java.io.IOException;
import java.sql.*;
import java.util.regex.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone_number = request.getParameter("phone_number");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (role == null || (!role.equals("admin") && !role.equals("customer"))) {
            role = "customer"; // Default role
        }

        // ✅ Validate username: 4-20 characters, only letters, numbers, underscore
        String usernameRegex = "^[a-zA-Z0-9_]{4,20}$";
        if (!Pattern.matches(usernameRegex, username)) {
            request.setAttribute("error", "Invalid username. Use 4-20 letters, numbers, or underscores.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // ✅ Validate password: 8+ chars, 1 uppercase, 1 lowercase, 1 number
        String passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$";
        if (!Pattern.matches(passwordRegex, password)) {
            request.setAttribute("error", "Password must have 8+ chars, 1 uppercase, 1 lowercase, 1 number.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement checkUser = null;
        PreparedStatement insertUser = null;
        ResultSet rs = null;

        try {
            // ✅ Connect to MySQL Database (Add useSSL=false&allowPublicKeyRetrieval=true to avoid SSL errors)
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exotic_coffee_shop?useSSL=false&allowPublicKeyRetrieval=true", "root", "Transcom#188");

            // ✅ Check if username already exists
            checkUser = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
            checkUser.setString(1, username);
            rs = checkUser.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("error", "Username already taken.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // ✅ Hash the password using BCrypt
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(10));

            // ✅ Insert user into database
            insertUser = conn.prepareStatement("INSERT INTO users (username, fullname, phone_no, email, password_hash, role) VALUES (?, ?, ?, ?, ?, ?)");
            insertUser.setString(1, username);
            insertUser.setString(2, fullname);
            insertUser.setString(3, phone_number);
            insertUser.setString(4, email);
            insertUser.setString(5, hashedPassword);
            insertUser.setString(6, role);
            insertUser.executeUpdate();

            // ✅ Redirect to login page with success message
            response.sendRedirect("login.jsp?success=registered");

        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        } finally {
            // ✅ Close resources to prevent memory leaks
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (checkUser != null) checkUser.close(); } catch (SQLException ignored) {}
            try { if (insertUser != null) insertUser.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }
}