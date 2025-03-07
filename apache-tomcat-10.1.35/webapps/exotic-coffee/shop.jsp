<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop | Exotic Coffee</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="./stylesheets/general-sans.css">
    <link rel="stylesheet" href="./stylesheets/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

    <!-- Navbar -->
    <nav class="fixed top-0 left-0 w-full flex justify-between items-center px-6 py-4 text-black z-10">
        <a href="index.jsp" class="text-2xl font-bold">Exotic Coffee.</a>
        <ul class="flex space-x-6">
            <li><a href="index.jsp" class="font-semibold hover:text-gray-500">HOME</a></li>
            <li><a href="shop.jsp" class="font-semibold text-gray-500">SHOP</a></li>
            <li><a href="about.jsp" class="font-semibold hover:text-gray-500">ABOUT US</a></li>
        </ul>
    </nav>

    <!-- Featured Product Section -->
    <section class="py-16 general-sans text-center">
        <h3 class="text-3xl font-bold mb-6">Shop Our Exclusive Selection</h3>
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 px-6">
            
            <%  
                int page = 1;
                int productsPerPage = 8; // Number of products per page

                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                
                int start = (page - 1) * productsPerPage; // Calculate offset

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exotic_coffee_shop", "root", "Transcom#188");

                    // Get products with pagination
                    String sql = "SELECT * FROM products LIMIT ? OFFSET ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, productsPerPage);
                    stmt.setInt(2, start);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
            %>
                    <div class="bg-white p-4 rounded-md shadow-lg">
                        <img src="<%= rs.getString("image_url") %>" style="height: 300px; object-fit: cover;" class="w-full rounded-md" alt="Coffee">
                        <h4 class="text-lg font-semibold mt-2"><%= rs.getString("name") %></h4>
                        <p class="text-gray-600">Origin: <%= rs.getString("origin") %></p>
                        <p class="text-gray-600">Roast: <%= rs.getString("roast_level") %></p>
                        <p class="text-gray-800 font-bold">Price: $<%= rs.getDouble("price") %></p>
                        <button class="mt-4 bg-black text-white py-2 px-4 rounded hover:bg-gray-700">Add to Cart</button>
                    </div>
            <%  
                    }
                    
                    // Get total product count for pagination
                    String countSql = "SELECT COUNT(*) FROM products";
                    PreparedStatement countStmt = conn.prepareStatement(countSql);
                    ResultSet countRs = countStmt.executeQuery();
                    countRs.next();
                    int totalProducts = countRs.getInt(1);
                    int totalPages = (int) Math.ceil(totalProducts / (double) productsPerPage);

                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error fetching coffee data.</p>");
                }
            %>
        </div>
    </section>

    <!-- Pagination -->
    <div class="flex justify-center mt-8">
        <% if (page > 1) { %>
            <a href="shop.jsp?page=<%= page - 1 %>" class="mx-2 px-4 py-2 bg-gray-300 rounded hover:bg-gray-400">Previous</a>
        <% } %>
        <% for (int i = 1; i <= totalPages; i++) { %>
            <a href="shop.jsp?page=<%= i %>" class="mx-2 px-4 py-2 <%= (i == page) ? "bg-black text-white" : "bg-gray-300 hover:bg-gray-400" %> rounded"><%= i %></a>
        <% } %>
        <% if (page < totalPages) { %>
            <a href="shop.jsp?page=<%= page + 1 %>" class="mx-2 px-4 py-2 bg-gray-300 rounded hover:bg-gray-400">Next</a>
        <% } %>
    </div>

    <!-- Footer -->
    <footer class="bg-black text-white general-sans text-center py-6 mt-12">
        <p>&copy; IM2073 Project | Joel & Chretienne.</p>
    </footer>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
