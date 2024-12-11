<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
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
        .login-container {
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
        .login-container:hover {
            transform: translateY(-5px);
        }

        /* Styling the form title */
        .login-container h1 {
            color: #00796b; /* Teal color */
            margin-bottom: 20px;
            font-size: 2.5em; /* Increased font size */
            font-weight: bold;
        }

        /* Input fields styling */
        input[type="text"],
        input[type="password"] {
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
        input[type="password"]:focus {
            border-color: #00796b; /* Teal color on focus */
            outline: none;
        }

        /* Submit button styling */
        input[type="submit"] {
            width: 100%;
            padding: 15px;
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

        /* Link styling for Sign Up */
        a.login-button {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            background-color: #2196F3; /* Blue background */
            color: white;
            padding: 12px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s, transform 0.3s;
        }

        /* Hover effect for the sign-up button */
        a.login-button:hover {
            background-color: #1976d2; /* Darker blue on hover */
            transform: scale(1.02);
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login to Connect Globe</h1>
        <form action="login" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
        <p>Don’t have an account? <a href="signup.jsp">Sign up</a></p>
    </div>
</body>
</html>
