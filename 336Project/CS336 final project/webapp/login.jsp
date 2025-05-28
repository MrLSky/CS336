<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <body>
    <h2>Login</h2>
    <form action="LoginServlet" method="post">
      Username: <input name="username" required/><br/>
      Password: <input type="password" name="password" required/><br/>
      <button type="submit">Log In</button>
    </form>
    <c:if test="${param.error != null}">
      <p style="color:red;">Invalid username or password.</p>
    </c:if>
  </body>
</html>
