<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <body>
    <h2>Ask a Question</h2>
    <form action="PostQuestionServlet" method="post">
      <p>
        Title:<br>
        <input type="text" name="title" required style="width:50%"/>
      </p>
      <p>
        Message:<br>
        <textarea name="body" rows="6" cols="60" required></textarea>
      </p>
      <button type="submit">Submit</button>
    </form>
    <c:if test="${not empty error}">
      <p style="color:red;"><strong>${error}</strong></p>
    </c:if>
    <p><a href="BrowseQAServlet">← Back to Questions</a></p>
  </body>
</html>
