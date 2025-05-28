<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>My Bookings</title>
</head>
<body>


<h2>Upcoming Flights</h2>
<c:if test="${empty upcomingBookings}">
  <p>No upcoming reservations.</p>
</c:if>
<c:if test="${not empty upcomingBookings}">
  <table border="1">
    <tr>
      <th>Booking ID</th><th>Flight</th><th>Airline</th>
      <th>From → To</th><th>Depart</th><th>Arrive</th>
      <th>Class</th><th>Cost</th><th>Cancel</th>
    </tr>
    <c:forEach var="b" items="${upcomingBookings}">
      <tr>
        <td><c:out value="${b.bookId}"/></td>
        <td><c:out value="${b.flightNum}"/></td>
        <td><c:out value="${b.airlineName}"/></td>
        <td>${b.fromCode} → ${b.toCode}</td>
        <td><fmt:formatDate value="${b.departDate}" pattern="yyyy-MM-dd HH:mm"/></td>
        <td><fmt:formatDate value="${b.arriveDate}" pattern="yyyy-MM-dd HH:mm"/></td>
        <td><c:out value="${b.seatClass}"/></td>
        <td>$<c:out value="${b.paidCost}"/></td>
        <td>
          <form action="CancelServlet" method="post" style="display:inline">
            <input type="hidden" name="bookID" value="${b.bookId}"/>
            <button type="submit">Cancel</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </table>
</c:if>




  <h2>Past Flights</h2>
  <c:if test="${empty pastBookings}">
    <p>No past reservations.</p>
  </c:if>
  <c:if test="${not empty pastBookings}">
    <table border="1">
      <tr>
        <th>Booking ID</th><th>Flight</th><th>Airline</th>
        <th>From → To</th><th>Depart</th><th>Arrive</th>
        <th>Class</th><th>Cost</th>
      </tr>
      <c:forEach var="b" items="${pastBookings}">
        <tr>
          <td><c:out value="${b.bookId}"/></td>
          <td><c:out value="${b.flightNum}"/></td>
          <td><c:out value="${b.airlineName}"/></td>
          <td>${b.fromCode} → ${b.toCode}</td>
          <td><fmt:formatDate value="${b.departDate}" pattern="yyyy-MM-dd HH:mm"/></td>
          <td><fmt:formatDate value="${b.arriveDate}" pattern="yyyy-MM-dd HH:mm"/></td>
          <td><c:out value="${b.seatClass}"/></td>
          <td>$<c:out value="${b.paidCost}"/></td>
        </tr>
      </c:forEach>
    </table>
  </c:if>

  <p>
    <a href="home.jsp">Back to Home</a> |
    <a href="searchForm.jsp">Search Flights</a>
  </p>
</body>
</html>
