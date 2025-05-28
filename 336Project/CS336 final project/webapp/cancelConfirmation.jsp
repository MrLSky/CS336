<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <body>
    <h2>Cancellation Processed</h2>
    <p>Your reservation has been cancelled successfully.</p>
    <c:if test="${not empty notifyMsg}">
      <p style="color:green;"><strong>${notifyMsg}</strong></p>
    </c:if>
    <p>
      <a href="MyBookingsServlet">Back to My Bookings</a> |
      <a href="home.jsp">Home</a>
    </p>
  </body>
</html>
