<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exotic Coffee Marketplace</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

    <!-- ✅ Navigation Bar -->
    <nav class="bg-white shadow-md p-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-gray-800">Exotic Coffee.</h1>
        <ul class="flex space-x-6">
            <li><a href="#shop" class="text-gray-600 hover:text-black">Shop</a></li>
            <li><a href="#subscribe" class="text-gray-600 hover:text-black">Subscribe</a></li>
            <li><a href="#about" class="text-gray-600 hover:text-black">About Us</a></li>
        </ul>
    </nav>

    <!-- ✅ Hero Section -->
    <section class="relative h-screen bg-[url('https://cdn.pixabay.com/photo/2019/10/31/07/14/coffee-4591159_1280.jpg')] bg-cover bg-center flex items-center justify-center text-white">
        <div class="text-center">
            <h2 class="text-5xl font-bold">A World of Coffee, One Click Away</h2>
            <p class="text-lg mt-4">Discover the finest coffee from Vietnam, Hawaii, Ethiopia, and beyond.</p>
            <a href="#shop" class="mt-6 inline-block bg-black text-white py-3 px-6 rounded-full hover:bg-gray-800">Explore Now</a>
        </div>
    </section>

    <!-- ✅ Subscription Plans -->
    <section id="subscribe" class="py-16 text-center bg-gray-50">
        <h3 class="text-3xl font-bold">Subscribe & Enjoy</h3>
        <p class="mt-2">Get fresh coffee delivered to your door monthly.</p>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 px-6 mt-6">
            <div class="bg-white p-6 shadow-md rounded-md">
                <h4 class="text-lg font-semibold">Single Origin Plan</h4>
                <p class="text-gray-600 mt-2">$19.99/month</p>
                <button class="mt-4 bg-black text-white py-2 px-4 rounded">Subscribe</button>
            </div>
            <div class="bg-white p-6 shadow-md rounded-md">
                <h4 class="text-lg font-semibold">Blend Collection</h4>
                <p class="text-gray-600 mt-2">$29.99/month</p>
                <button class="mt-4 bg-black text-white py-2 px-4 rounded">Subscribe</button>
            </div>
            <div class="bg-white p-6 shadow-md rounded-md">
                <h4 class="text-lg font-semibold">Premium Reserve</h4>
                <p class="text-gray-600 mt-2">$39.99/month</p>
                <button class="mt-4 bg-black text-white py-2 px-4 rounded">Subscribe</button>
            </div>
        </div>
    </section>

    <!-- ✅ Featured Coffee -->
    <section id="shop" class="py-16 text-center">
        <h3 class="text-3xl font-bold">Our Best Sellers</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 px-6 mt-6">
            <%  
                // Connect to MySQL and fetch coffee products
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/global_coffee_shop", "root", "Transcom#188");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM coffee_products ORDER BY price DESC LIMIT 3");

                    while (rs.next()) {
            %>
            <div class="bg-white p-4 shadow-md rounded-md">
                <img src="<%= rs.getString("image_url") %>" style="height: 250px; object-fit: cover;" class="w-full rounded-md" alt="Coffee">
                <h4 class="text-lg font-semibold mt-2"><%= rs.getString("name") %></h4>
                <p class="text-gray-600">Origin: <%= rs.getString("origin") %></p>
                <p class="text-gray-600">Price: $<%= rs.getDouble("price") %></p>
                <button class="mt-4 bg-black text-white py-2 px-4 rounded">Add to Cart</button>
            </div>
            <%  
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error fetching coffee data.</p>");
                }
            %>
        </div>
    </section>

    <!-- ✅ Footer -->
    <footer class="bg-black text-white text-center py-4 mt-12">
        <p>&copy; 2024 Global Coffee | All Rights Reserved</p>
    </footer>

</body>
</html>
