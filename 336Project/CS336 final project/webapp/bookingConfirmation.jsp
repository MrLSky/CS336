<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head><title>Booking Confirmation</title></head>
  <body>
    <h2>Booking Confirmation</h2>
    <p>
      <c:out value="${bookingMsg}" />
    </p>
    <p>
      <a href="MyBookingsServlet">View My Bookings</a> |
      <a href="searchForm.jsp">Search More Flights</a> |
      <a href="home.jsp">Home</a>
    </p>
  </body>
</html>
