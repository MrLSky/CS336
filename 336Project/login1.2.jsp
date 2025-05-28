<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Form</title>
</head>
<body>
    <h2>Login</h2>

    <!-- Show error message if login fails -->
    <% 
        String error = request.getParameter("error");
        if ("1".equals(error)) {
    %>
        <p style="color:red;">Invalid username or password. Please try again.</p>
    <% 
        }
    %>

    <form action="checkLoginDetails.jsp" method="POST">
        Username: <input type="text" name="username" required /> <br/><br/>
        Password: <input type="password" name="password" required /> <br/><br/>
        <input type="submit" value="Login" />
    </form>
</body>
</html>