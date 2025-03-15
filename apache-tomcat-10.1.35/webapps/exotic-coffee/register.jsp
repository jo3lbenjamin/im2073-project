<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Exotic Coffee</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="./stylesheets/general-sans.css">
    <link rel="stylesheet" href="./stylesheets/index.css">
</head>
<body class="bg-gray-100 flex justify-center items-center min-h-screen general-sans">
    <div class="absolute inset-0 bg-cover bg-center" style="background-image: url('https://cdn.pixabay.com/photo/2021/09/06/01/13/coffee-6600644_1280.jpg'); opacity: 0.6;"></div>
    <div class="bg-white p-6 rounded-lg shadow-md w-96 z-10">
        <h2 class="text-2xl font-bold text-center mb-4">Register</h2>

        <% if (request.getAttribute("error") != null) { %>
            <p class="text-red-500 text-sm text-center"><%= request.getAttribute("error") %></p>
        <% } %>

        <form action="RegisterServlet" method="post" class="flex flex-col">
            <label class="text-md font-semibold">Username</label>
            <input type="text" name="username" class="border rounded-md p-2 mb-3" required>

            <label class="text-md font-semibold">Your Full Name</label>
            <input type="text" name="fullname" class="border rounded-md p-2 mb-3" required>
            
            <label class="text-md font-semibold">Email</label>
            <input type="text" name="email" class="border rounded-md p-2 mb-3" required>
            
            <label class="text-md font-semibold">Phone Number</label>
            <input type="text" name="phone_number" class="border rounded-md p-2 mb-3" required>

            <label class="text-md font-semibold">Password</label>
            <input type="password" name="password" class="border rounded-md p-2 mb-4" required>

            <label class="text-md font-semibold">Role</label>
            <select name="role" class="border rounded-md p-2 mb-4">
                <option value="customer" selected>Customer</option>
                <option value="admin">Admin</option>
            </select>

            <button type="submit" class="bg-black text-white py-2 rounded hover:bg-gray-800">Register</button>
        </form>

        <p class="text-center text-sm mt-4">Already have an account? <a href="login.jsp" class="text-blue-500">Login</a></p>
    </div>

</body>
</html>