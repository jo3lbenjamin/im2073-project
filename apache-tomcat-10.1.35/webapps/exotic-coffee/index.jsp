<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exotic Coffee Marketplace</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="./stylesheets/general-sans.css">
    <link rel="stylesheet" href="./stylesheets/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">


<!-- Main Navigation Bar -->
<nav class="top-0 left-0 w-full flex absolute justify-between items-center py-3 px-4 text-white z-10">
    <h1 class="text-2xl font-bold">Exotic Coffee.</h1>
    <ul class="flex space-x-6">
        <li><a href="index.jsp" class="font-semibold hover:text-gray-300">HOME</a></li>
        <li><a href="shop.jsp" class="font-semibold hover:text-gray-300">SHOP</a></li>
        <li><a href="about.jsp" class="font-semibold hover:text-gray-300">ABOUT US</a></li>
    </ul>
</nav>

    


    <!-- Hero Section with Full-Width Video Background -->
    <section class="relative h-screen flex items-center justify-center text-white">
        <video autoplay muted loop class="absolute w-full h-full object-cover">
            <source src="https://cdn.pixabay.com/video/2024/04/25/209419_large.mp4" type="video/mp4">
        </video>
        <div class="relative general-sans z-10 text-center">
            <h2 class="text-5xl font-bold">The World’s Finest Coffee</h2>
            <p class="text-lg mt-4">Indulge in the rich aromas of hand-picked coffee from across the globe.</p>
            <a href="shop.jsp" class="mt-6 inline-block bg-white text-black py-3 px-6 rounded-full hover:bg-gray-200">Shop Now</a>
        </div>
    </section>

    <!-- Featured Product Section -->
    <section class="py-16 general-sans text-center">
        <h3 class="text-3xl font-bold mb-6">Shop Our Exclusive Selection</h3>
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 px-6">
            <%  
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exotic_coffee_shop", "root", "Transcom#188");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM products ORDER BY price DESC LIMIT 4");

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
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error fetching coffee data.</p>");
                }
            %>
        </div>
    </section>

    <!-- Promotional Banner Section -->
    <section class="relative general-sans h-[500px] flex items-center justify-center text-white bg-black">
        <div class="absolute inset-0 bg-cover bg-center" style="background-image: url('https://cdn.pixabay.com/photo/2015/09/01/21/00/coffee-beans-917613_1280.jpg'); opacity: 0.5;"></div>
        <div class="relative z-10 text-center">
            <h3 class="text-4xl font-bold">Discover Limited Edition Blends</h3>
            <p class="text-lg mt-4">Handcrafted for coffee lovers worldwide.</p>
            <a href="shop.jsp" class="mt-6 inline-block bg-white text-black py-3 px-6 rounded-full hover:bg-gray-200">Explore Now</a>
        </div>
    </section>

    <!-- Secondary Product Showcase -->
    <section class="py-16 general-sans text-center">
        <h3 class="text-3xl font-bold">Handpicked Just for You</h3>
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 px-6 mt-6">
            <%  
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exotic_coffee_shop", "root", "Transcom#188");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM products ORDER BY RAND() LIMIT 4");

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
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error fetching coffee data.</p>");
                }
            %>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-black text-white general-sans text-center py-6 mt-12">
        <p>&copy; IM2073 Project | Joel & Chretienne.</p>
    </footer>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</html>
