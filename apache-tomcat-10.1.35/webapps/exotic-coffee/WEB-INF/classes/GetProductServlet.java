import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class GetProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, Object>> productList = new ArrayList<>();
        int page = 1;
        int productsPerPage = 6;
        int totalPages = 1;  // Default value

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1; // Default to page 1 if invalid input
            }
        }
        int offset = (page - 1) * productsPerPage;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exotic_coffee_shop", "root", "Transcom#188");

            // Get total product count
            String countQuery = "SELECT COUNT(*) FROM products";
            PreparedStatement countStmt = conn.prepareStatement(countQuery);
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalPages = (int) Math.ceil((double) countRs.getInt(1) / productsPerPage);
            }

            // Fetch products
            String sql = "SELECT p.product_id, p.name, p.price, p.image_url, b.name AS brand FROM products p INNER JOIN brands b ON p.brand_id = b.id LIMIT ? OFFSET ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productsPerPage);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id", rs.getInt("product_id"));
                product.put("name", rs.getString("name"));
                product.put("brand", rs.getString("brand"));
                product.put("price", rs.getDouble("price"));
                product.put("image_url", rs.getString("image_url"));
                productList.add(product);
            }

            // Close resources
            rs.close();
            stmt.close();
            countStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        //  Ensure attributes are always set
        request.setAttribute("products", productList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);

        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }
}