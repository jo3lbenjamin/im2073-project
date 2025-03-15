<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>

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
<body class="flex flex-col min-h-screen general-sans">

    <!-- Main Navigation Bar -->
    <nav class="top-0 left-0 w-full flex absolute justify-between items-center py-3 px-4 text-black z-10">
        <h1 class="text-2xl font-bold">Exotic Coffee.</h1>
        <ul class="flex space-x-6">
            <li><a href="index.jsp" class="font-semibold hover:text-gray-300">Home</a></li>
            <li><a href="products" class="font-semibold hover:text-gray-300">Shop</a></li>
            <li><a href="about.jsp" class="font-semibold hover:text-gray-300">About Us</a></li>
            <li><a href="register.jsp" class="font-semibold hover:text-gray-300">Log In/Register</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <section class="py-5 flex-grow">
        <div class="container pt-32 pb-12">
            <h2 class="text-center text-5xl font-bold mb-6">Our Coffee Selection</h2>

            <div class="row">
                <%
                    // Retrieve attributes set by the servlet
                    List<Map<String, Object>> products = (List<Map<String, Object>>) request.getAttribute("products");
                    Integer totalPages = (Integer) request.getAttribute("totalPages");
                    Integer currentPage = (Integer) request.getAttribute("currentPage");

                    // Fallback to defaults if they're null
                    if (totalPages == null) totalPages = 1;
                    if (currentPage == null) currentPage = 1;

                    if (products != null && !products.isEmpty()) {
                        for (Map<String, Object> product : products) {
                %>
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <img src="<%= product.get("image_url") %>" class="card-img-top" 
                             style="height: 250px; object-fit: cover;" alt="Coffee Image">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.get("name") %></h5>
                            <p class="card-text text-muted">Brand: <%= product.get("brand") %></p>
                            <p class="fw-bold">$<%= product.get("price") %></p>
                            <!-- Example link to product.jsp if you have a details page -->
                            <a href="product.jsp?id=<%= product.get("id") %>" class="btn btn-dark">View Product</a>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <p class="text-center">No products available.</p>
                <%
                    }
                %>
            </div>

            <!-- Pagination -->
            <div class="text-center mt-4">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                %>
                    <a href="products?page=<%= i %>" 
                       class="btn btn-outline-dark <%= (i == currentPage) ? "active" : "" %>">
                        <%= i %>
                    </a>
                <%
                    }
                %>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-black text-white text-center py-3">
        <p>&copy; IM2073 Project | Joel & Chretienne.</p>
    </footer>

</body>
</html>
