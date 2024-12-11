<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sign Up</title>
    <style>
        /* General styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #e0f7fa; /* Light blue background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 20px;
        }

        /* Styling the form container */
        .signup-container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 4px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            transition: transform 0.3s;
        }

        /* Add a hover effect for the container */
        .signup-container:hover {
            transform: translateY(-5px);
        }

        /* Styling the form title */
        .signup-container h1 {
            color: #00796b; /* Teal color */
            margin-bottom: 20px;
            font-size: 2.5em; /* Increased font size */
            font-weight: bold;
        }

        /* Input fields styling */
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 15px; /* Increased padding */
            margin: 10px 0;
            border: 1px solid #b2dfdb; /* Light teal border */
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border 0.3s;
        }

        /* Focus effect for input fields */
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus {
            border-color: #00796b; /* Teal color on focus */
            outline: none;
        }

        /* Submit button styling */
        input[type="submit"] {
            width: 100%;
            padding: 15px; /* Increased padding */
            background-color: #00796b; /* Teal background */
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 18px; /* Increased font size */
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        /* Hover effect for the submit button */
        input[type="submit"]:hover {
            background-color: #004d40; /* Darker teal on hover */
            transform: scale(1.02);
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h1>Create Your Account</h1>
        <form action="signup" method="post">
 <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Sign Up">
        </form>
        <p>Already have an account? <a href="login.jsp">Log in</a></p>
    </div>
</body>
</html>
