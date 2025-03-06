<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Exotic Coffee</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="./stylesheets/general-sans.css">
    <link rel="stylesheet" href="./stylesheets/index.css">
</head>
<body class="bg-white text-gray-900">

    <!-- Navbar -->
    <nav class="fixed top-0 left-0 w-full flex justify-between items-center px-6 py-4 text-black z-10">
        <a href="index.jsp" class="text-2xl font-bold">Exotic Coffee.</a>
        <ul class="flex space-x-6">
            <li><a href="index.jsp" class="font-semibold hover:text-gray-500">HOME</a></li>
            <li><a href="shop.jsp" class="font-semibold hover:text-gray-500">SHOP</a></li>
            <li><a href="about.jsp" class="font-semibold text-gray-500">ABOUT US</a></li>
        </ul>
    </nav>

    <!-- About Section -->
    <section class="max-w-5xl mx-auto px-6 pt-32 pb-12">
        <h1 class="text-5xl font-bold mb-6">ABOUT US.</h1>
        <p class="text-gray-600 text-lg leading-relaxed">
            At Exotic Coffee, we are dedicated to sourcing and roasting the finest coffee beans from around the world. 
            Our journey started with a passion for exceptional coffee, sustainability, and ethical sourcing.
        </p>
        <p class="text-gray-600 text-lg leading-relaxed mt-4">
            Every cup tells a story, from the farmers who cultivate our beans to the roasters who bring out their unique flavors. 
            We take pride in offering premium-quality coffee that elevates your daily experience.
        </p>
    </section>

    <!-- Team Image -->
    <section class="w-full">
        <img src="https://cdn.pixabay.com/photo/2017/08/01/13/31/coffee-2565442_1280.jpg" class="w-full h-[400px] object-cover" alt="Our Team">
    </section>

    <!-- Quote Section -->
    <section class="max-w-5xl mx-auto px-6 py-16 flex flex-col md:flex-row items-center gap-12">
        <!-- Quote -->
        <div class="md:w-1/2 text-left">
            <p class="text-2xl italic font-semibold">
                "Great coffee is more than just a drink, it’s an experience that connects people across the world."
            </p>
            <p class="text-gray-600 mt-4">- John Doe, Founder</p>
        </div>
        <!-- Supporting Image -->
        <div class="md:w-1/2">
            <img src="https://cdn.pixabay.com/photo/2021/04/22/02/36/barista-6197867_1280.jpg" class="rounded-lg shadow-md" alt="Barista">
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-black text-white text-center py-6">
        <p>&copy; IM2073 Project | Joel & Chretienne.</p>
    </footer>

</body>
</html>
