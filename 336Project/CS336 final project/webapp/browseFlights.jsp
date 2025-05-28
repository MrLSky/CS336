<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>All Available Flights</title></head>
  <body>
    <h2>All Available Flights</h2>
    <c:choose>
      <c:when test="${empty flights}">
        <p>No flights in the system.</p>
      </c:when>
      <c:otherwise>
        <table border="1">
          <tr>
            <th>Flight#</th><th>Airline</th><th>From</th><th>To</th>
            <th>Depart</th><th>Arrive</th><th>Stops</th><th>Cost</th><th>Action</th>
          </tr>
          <c:forEach var="f" items="${flights}">
            <tr>
              <td>${f.flightNum}</td>
              <td>${f.airline}</td>
              <td>${f.ori}</td>
              <td>${f.dest}</td>
              <td>${f.depart}</td>
              <td>${f.arrive}</td>
              <td>${f.stops}</td>
              <td>$${f.cost}</td>
              <td>
                <form action="BookingServlet" method="post" style="margin:0">
                  <input type="hidden" name="flight_num" value="${f.flightNum}"/>
                  <select name="seat_class">
                    <option>Economy</option>
                    <option>Business</option>
                    <option>First</option>
                  </select>
                  <button type="submit">Book</button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </table>
      </c:otherwise>
    </c:choose>
    <p><a href="home.jsp">← Back to Home</a></p>
  </body>
</html>
