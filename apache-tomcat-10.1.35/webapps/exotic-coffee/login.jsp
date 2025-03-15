<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Exotic Coffee</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="./stylesheets/general-sans.css">
    <link rel="stylesheet" href="./stylesheets/index.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen general-sans">

    <div class="bg-white p-8 rounded shadow-lg w-96">
        <h2 class="text-2xl font-bold mb-4 text-center">Login</h2>

        <% if (request.getAttribute("error") != null) { %>
            <p class="text-red-500 text-sm mb-3"><%= request.getAttribute("error") %></p>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Username</label>
                <input type="text" name="username" required class="w-full px-3 py-2 border rounded">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Password</label>
                <input type="password" name="password" required class="w-full px-3 py-2 border rounded">
            </div>

            <button type="submit" class="w-full bg-black text-white py-2 rounded hover:bg-gray-800">Login</button>
        </form>

        <p class="text-center text-sm text-gray-600 mt-4">
            Don't have an account? <a href="register.jsp" class="text-blue-500">Register here</a>.
        </p>
    </div>

</body>
</html>